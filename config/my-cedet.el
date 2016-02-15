
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/cedet-1.1/common/"))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/cedet-1.1/eieio/"))
;;(setq semantic-load-turn-everything-on t)
;(require 'eieio-load)
;(require 'cedet)
;; (load-file (expand-file-name "~/.emacs.d/emacs-lisp/cedet-1.1/common/cedet.el"))
;;(require 'semantic-ia)

(require 'semantic)
(semantic-default-c-setup)
;(require 'semanticdb)
;(semantic-mode 1)
;;(require 'semantic/ia)
;;(require 'semantic/bovine/gcc)
;;(semantic-add-system-include "~/exp/include/boost_1_37" 'c++-mode)


(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)

;; Semantic do not works with emacs24 
;;(global-semantic-idle-completions-mode t)
;;(global-semantic-decoration-mode 1)
;;(global-semantic-highlight-func-mode 1)
;;(global-semantic-show-unmatched-syntax-mode 1)

;; Enabling Semantic (code-parsing, smart completion)features
;; Select one of the following;
;;(semantic-load-enable-minimum-features)
;;(semantic-load-enable-code-helpers)
;;(semantic-load-enable-gaudy-code-helpers)
;(semantic-load-enable-excessive-code-helpers)
;;(semantic-load-enable-semantic-debugging-helpers)

;; Enable source code folding
;(global-semantic-tag-folding-mode 1)

;; Key bindings
(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key (kbd "C-c ?") 'semantic-ia-complete-symbol-menu)
  (local-set-key (kbd "C-c d") 'semantic-ia-fast-jump)
  (local-set-key (kbd "C-c r") 'semantic-symref-symbol)
  (local-set-key (kbd "C-c R") 'semantic-symref)
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu))
(add-hook 'c-mode-common-hook 'my-cedet-hook)

(defun my-c-mode-cedet-hook ()
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key (kbd "C-c C-f a") 'semantic-tag-folding-fold-all)
  (local-set-key (kbd "C-c C-f b") 'semantic-tag-folding-fold-block)
  (local-set-key (kbd "C-c C-f s") 'semantic-tag-folding-show-all)
  (local-set-key (kbd "C-c C-f h") 'semantic-tag-folding-show-block))
(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

;;(global-srecode-minor-mode 1)
;; ede settings
(global-ede-mode 1)

;; preprocessing settings
(setq glib-base-dir "/usr/include/glib-2.0")
(semantic-add-system-include glib-base-dir 'c-mode)
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat glib-base-dir "/glib.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat glib-base-dir "/glib-object.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat glib-base-dir "/gmodule.h"))

(defconst cedet-user-include-dirs
  (list ".." "../include" "../.." "../../.." "../../include" "../../../inlcude"
        "/usr/include/sys" "/usr/include/bits"))
(setq cedet-sys-include-dirs (list
                              "/usr/include"))
(let ((include-dirs cedet-user-include-dirs))
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

; (defun my-c-mode-cedet-hook ()
; (local-set-key "." 'semantic-complete-self-insert)
; (local-set-key ">" 'semantic-complete-self-insert))
;(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

(provide 'my-cedet)
