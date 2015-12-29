;; my slime settings
(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/slime-2012-09-09"))  ; your SLIME directory
(load (expand-file-name "~/quicklisp/slime-helper"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")
;; (setq inferior-lisp-program "/usr/bin/sbcl"
;;      slime-startup-animation t) ; your Lisp system

(eval-after-load "slime"
  `(progn
      (setq slime-lisp-implementations
            '((sbcl ("/usr/local/bin/sbcl"))
               (clisp ("/usr/bin/clis")))
              common-lisp-hyperspec-root (expand-file-name "~/hyperspec/"))
      (slime-setup '(slime-asdf
                      slime-autodoc
                      slime-editing-commands
                      slime-fancy-inspector
                      slime-fontifying-fu
                      slime-fuzzy
                      slime-indentation
                      ;slime-mdot-fu
                      slime-package-fu
                      slime-references
                      slime-repl
                      slime-sbcl-exts
                      slime-scratch
                      slime-xref-browser))
      (slime-autodoc-mode)
      (setq slime-complete-symbol*-fancy t)
      (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
      (add-hook 'llisp-mode-hook (lambda () (slime-mode t)))))

(require 'slime)
(slime-setup '(slime-fancy))
;; (slime-startup-animation t)


;; (add-to-list 'load-path (expand-file-name "~/software/slime/contrib"))
;; (setq slime-backend (expand-file-name "~/software/slime/swank-loader.lisp"))
;; (load "slime-autoloads")
;; (require 'slime)
;; (require 'slime-autoloads)
;; (eval-after-load "slime"
;;   `(progn
;;      (slime-setup '(slime-repl))
;;      (custom-set-variables
;;       '(inhibit-splash-screen t)
;;       '(slime-complete-symbol*-fancy t)
;;       '(slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
;;       '(slime-net-coding-system 'utf-8-unix)
;;       '(slime-startup-animation nil)
;;       '(slime-lisp-implementations '((sbcl ("/user/bin/sbcl")))))))
;; ;; Stop SLIME’s REPL from grabbing DEL,
;; ;; which is annoying when backspacing over a ‘(‘
;; (defun override-slime-repl-bindings-with-paredit ()
;;   (define-key slime-repl-mode-map
;;     (read-kbd-macro paredit-backward-delete-key) nil))
;; (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)
;; ;; User’s stuff:
;; ;; (zenburn)
;; ;; (slime)

;; ParEdit settings 
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)

(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook           'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook       'enable-paredit-mode)

;; AutoPair settings
(autoload 'enable-autopair-mode "autopair"
  "Turn autopair mode on" t)
(autoload 'disable-autopair-mode "autopair"
  "Turn autopair mode off" t)

;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

(provide 'my-slime)
