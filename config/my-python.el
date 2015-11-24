;; fix bugs in compatible between python-mode and semantic
;;(autoload 'python-proc "python" "autoload python-proc to resolve python-mode and sematinc conflic" nil nil)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/python.el/"))

(require 'python)
(require 'ob-python)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/python-django.el"))
(require 'python-django)
(global-set-key (kbd "C-x j") 'python-django-open-project)
;(add-to-list 'load-path "/Users/jacobsu/.emacs.d/emacs-lisp/python-mode.el-6.0.12/") 
;(setq py-install-directory "/Users/jacobsu/.emacs.d/emacs-lisp/python-mode.el-6.0.12/")

;; python-mode settings
;; customize python-mode
;; (setq py-prepare-autopair-mode-p t)
;; (setq py-trailing-whitespace-smart-delete-p t)
;; ;;(setq py-complete-function nil)
;; (setq py-load-pymacs-p t)
;; (setq py-honor-IPYTHONDIR-p t)
;; (setq py-honor-PYTHONHISTORY-p t)
;; (setq-default py-smart-operator-mode-p t)
;; (setq py-switch-buffers-on-execute-p t)
;; (setq py-start-run-py-shell nil)
;; (setq py-force-py-shell-name-p t)
;; (setq py-force-local-shell-p t)

;; (require 'anything)
;; ;(require 'anything-ipython)
;; (when (require 'anything-show-completion nil t)
;;   (use-anything-show-completion 'anything-ipython-complete
;;                                 '(length initial-pattern)))

(require 'pymacs)
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (autoload 'pymacs-autoload "pymacs")

;; Richard Riley's settings
(defun richard-riley-python ()
  (set (make-variable-buffer-local 'beginning-of-defun-function)
       'py-beginning-of-def-or-class)
  (setq outline-regexp "def\\|class ")
  (eldoc-mode 1))

;(add-hook 'python-mode-hook 'richard-riley-python)
;;

;; fgallina's python mode
;(add-hook 'python-mode-hook (lambda () (setq forward-sexp-function nil)))

(defconst epy-install-dir (expand-file-name "~/.emacs.d/emacs-lisp/emacs-for-python/")
  "Installatin directory of emacs-for-python.")

(add-to-list 'load-path (concat epy-install-dir "extensions/"))

(defun setup-ropemacs ()
  "Setup the ropemacs harness"
  ;; (message "****************************")
  ;; (if (and (getenv "PYTHONPATH") (not (string= (getenv "PYTHONPATH") "")))
  ;;     (message "true")
  ;;   (message "false"))
  ;; (message "****************************")
  ;; If PYTHONPATH is set and not an empty string
  ;; (if (and (getenv "PYTHONPATH") (not (string= (getenv "PYTHONPATH") "")))
  ;;     ;; append at the end with separator
  ;;     (setenv "PYTHONPATH"
  ;;         (concat
  ;;          (getenv "PYTHONPATH") path-separator
  ;;          (concat epy-install-dir "python-libs/")))
  ;;   ;; else set it without separator
  ;;   (setenv "PYTHONPATH"
  ;;       (concat epy-install-dir "python-libs/"))
  ;;   )
  
  (pymacs-load "ropemacs" "rope-")
  
  ;; Stops from erroring if there's a syntax err
  (setq ropemacs-codeassist-maxfixes 3)

  ;; Configurations
  (setq ropemacs-guess-project t)
  (setq ropemacs-enable-autoimport t)


  (setq ropemacs-autoimport-modules '("os" "shutil" "sys" "logging"
				      "django.*"))

 

  ;; Adding hook to automatically open a rope project if there is one
  ;; in the current or in the upper level directory
   (add-hook 'python-mode-hook
            (lambda ()
              (cond ((file-exists-p ".ropeproject")
                     (rope-open-project default-directory))
                    ((file-exists-p "../.ropeproject")
                     (rope-open-project (concat default-directory "..")))
                    )))
   )

;; Ipython integration with fgallina/python.el
(defun epy-setup-ipython ()
  "Setup ipython integration with python-mode"
  (interactive)

  (setq
   python-shell-interpreter "ipython"
   python-shell-interpreter-args ""
   python-shell-prompt-regexp "In \[[0-9]+\]: "
   python-shell-prompt-output-regexp "Out\[[0-9]+\]: "
   python-shell-completion-setup-code ""
   python-shell-completion-string-code "';'.join(get_ipython().complete('''%s''')[1])\n")
  )

;;=========================================================
;; Flymake additions, I have to put this one somwhere else?
;;=========================================================

(defun flymake-create-temp-in-system-tempdir (filename prefix)
  (make-temp-file (or prefix "flymake")))

(defun flymake-create-copy-file ()
  "Create a copy local file"
  (let* ((temp-file (flymake-init-create-temp-buffer-copy 
                     'flymake-create-temp-in-system-tempdir)))
    (file-relative-name 
     temp-file 
     (file-name-directory buffer-file-name))))     

(defun flymake-command-parse (cmdline)
  "Parses the command line CMDLINE in a format compatible
       with flymake, as:(list cmd-name arg-list)

The CMDLINE should be something like:

 flymake %f python custom.py %f

%f will be substituted with a temporary copy of the file that is
 currently being checked.
"
  (let ((cmdline-subst (replace-regexp-in-string "%f" (flymake-create-copy-file) cmdline)))
    (setq cmdline-subst (split-string-and-unquote cmdline-subst))
    (list (first cmdline-subst) (rest cmdline-subst))
    ))


(when (load-file (concat epy-install-dir "extensions/flymake-patch.el"))
  (setq flymake-info-line-regex
        (append flymake-info-line-regex '("unused$" "^redefinition" "used$")))
  (load-library "flymake-cursor"))

(defun epy-setup-checker (cmdline)
  (add-to-list 'flymake-allowed-file-name-masks
               (list "\\.py\\'" (apply-partially 'flymake-command-parse cmdline)))
  )

;; Python or python mode?
(eval-after-load 'python
  '(progn
     ;;==================================================
     ;; Ropemacs Configuration
     ;;==================================================
     (setup-ropemacs)

     ;;==================================================
     ;; Virtualenv Commands
     ;;==================================================
     (autoload 'virtualenv-activate "virtualenv"
       "Activate a Virtual Environment specified by PATH" t)
     (autoload 'virtualenv-workon "virtualenv"
       "Activate a Virtual Environment present using virtualenvwrapper" t)
     
     
     ;; Not on all modes, please
     ;; Be careful of mumamo, buffer file name nil
     (add-hook 'python-mode-hook (lambda () (if (buffer-file-name)
						(flymake-mode))))

     ;; when we swich on the command line, switch in Emacs
     ;;(desktop-save-mode 1)
     (defun workon-postactivate (virtualenv)
       (require 'virtualenv)
       (virtualenv-activate virtualenv)
       (desktop-change-dir virtualenv))

     
     )
  )

;; Cython Mode
(autoload 'cython-mode "cython-mode" "Mode for editing Cython source files")

(add-to-list 'auto-mode-alist '("\\.pyx\\'" . cython-mode))
(add-to-list 'auto-mode-alist '("\\.pxd\\'" . cython-mode))
(add-to-list 'auto-mode-alist '("\\.pxi\\'" . cython-mode))

;; Py3 files
(add-to-list 'auto-mode-alist '("\\.py3\\'" . python-mode))

(add-hook 'python-mode-hook '(lambda () 
     (define-key python-mode-map "\C-m" 'newline-and-indent)))
(add-hook 'ein:notebook-python-mode-hook 
	  (lambda ()
	    (define-key python-mode-map "\C-m" 'newline)))

;; python complete config

;; Just python
(add-hook 'python-mode-hook 
	  (lambda () 
	    (define-key python-mode-map "'" 'skeleton-pair-insert-maybe)))

;; custom keybindings to use tab, enter and up and down arrows
(define-key ac-complete-mode-map "\t" 'ac-expand)
(define-key ac-complete-mode-map "\r" 'ac-complete)
(define-key ac-complete-mode-map "\M-n" 'ac-next)
(define-key ac-complete-mode-map "\M-p" 'ac-previous)

;; ropemacs Integration with auto-completion
(defun ac-ropemacs-candidates ()
  (mapcar (lambda (completion)
      (concat ac-prefix completion))
    (rope-completions)))

(ac-define-source nropemacs
  '((candidates . ac-ropemacs-candidates)
    (symbol     . "p")))

(ac-define-source nropemacs-dot
  '((candidates . ac-ropemacs-candidates)
    (symbol     . "p")
    (prefix     . c-dot)
    (requires   . 0)))

(defun ac-nropemacs-setup ()
  (setq ac-sources (append '(ac-source-nropemacs
                             ac-source-nropemacs-dot) ac-sources)))
(defun ac-python-mode-setup ()
  )

;; ac-source-yasnippet : Symbol's function definition is void: yas/current-snippet-table1
;(add-hook 'python-mode-hook 'ac-python-mode-setup)
(add-hook 'rope-open-project-hook 'ac-nropemacs-setup)

;; python editing

;; code borrowed from http://emacs-fu.blogspot.com/2010/01/duplicating-lines-and-commenting-them.html
(defun djcb-duplicate-line (&optional commentfirst)
  "comment line at point; if COMMENTFIRST is non-nil, comment the
original" (interactive)
  (beginning-of-line)
  (push-mark)
  (end-of-line)
  (let ((str (buffer-substring (region-beginning) (region-end))))
    (when commentfirst
    (comment-region (region-beginning) (region-end)))
    (insert
      (concat (if (= 0 (forward-line 1)) "" "\n") str "\n"))
    (forward-line -1)))

;; duplicate a line
(global-set-key (kbd "C-c y") 'djcb-duplicate-line)

;; duplicate a line and comment the first
(global-set-key (kbd "C-c c")(lambda()(interactive)(djcb-duplicate-line t)))

;; Mark whole line
(defun mark-line (&optional arg)
  "Marks a line"
  (interactive "p")
  (beginning-of-line)
  (push-mark (point) nil t)
  (end-of-line))

(global-set-key (kbd "C-c l") 'mark-line)


; code copied from http://stackoverflow.com/questions/2423834/move-line-region-up-and-down-in-emacs
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

; patches by balle
; http://www.datenterrorist.de
(defun balle-python-shift-left ()
  (interactive)
  (let (start end bds)
    (if (and transient-mark-mode
	   mark-active)
	(setq start (region-beginning) end (region-end))
      (progn
	(setq bds (bounds-of-thing-at-point 'line))
	(setq start (car bds) end (cdr bds))))
  (python-indent-shift-left start end))
  (setq deactivate-mark nil)
)

(defun balle-python-shift-right ()
  (interactive)
  (let (start end bds)
    (if (and transient-mark-mode
	   mark-active)
	(setq start (region-beginning) end (region-end))
      (progn
	(setq bds (bounds-of-thing-at-point 'line))
	(setq start (car bds) end (cdr bds))))
  (python-indent-shift-right start end))
  (setq deactivate-mark nil)
)

(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

(add-hook 'python-mode-hook
	  (lambda ()
	    (define-key python-mode-map (kbd "M-<right>")
	      'balle-python-shift-right)
	    (define-key python-mode-map (kbd "M-<left>")
	      'balle-python-shift-left))
	  )

; delete seleted text when typing
(delete-selection-mode 1)

;; python nose
(require 'nose)

;; Nose bindings
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key "\C-ca" 'nosetests-all)
            (local-set-key "\C-cM" 'nosetests-module)  ;; C-c m conflicts w/ pylint
            (local-set-key "\C-c." 'nosetests-one)
            (local-set-key "\C-cx" 'nosetests-stop)
            (local-set-key "\C-cpa" 'nosetests-pdb-all)
            (local-set-key "\C-cpm" 'nosetests-pdb-module)
            (local-set-key "\C-cp." 'nosetests-pdb-one))
          )

;; Rope bindings
(add-hook 'python-mode-hook
	  (lambda ()
	    (define-key python-mode-map "\C-ci" 'rope-auto-import)
	    (define-key python-mode-map "\C-c\C-d" 'rope-show-calltip)
	    )
)

(ac-ropemacs-initialize)

(provide 'my-python)
