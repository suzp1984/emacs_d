;; (eval-after-load "auto-complete-autoload"
;;   `(progn 
;;      (require 'auto-complete-config)
;;      (ac-config-default)
;;      (add-to-list 'ac-dictionary-directories "~/.emacs.d/emacs-lisp/dict")

;;      (global-auto-complete-mode t)
;;      (auto-complete-mode t))
;; )

(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/auto-complete-1.3.1"))

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories (expand-file-name "~/.emacs.d/emacs-lisp/dict"))

(global-auto-complete-mode t)
(auto-complete-mode t)

(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(add-hook 'lisp-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  `(progn
     (add-to-list 'ac-modes 'slime-repl-mode)
     (add-to-list 'ac-modes 'lisp-mode)))

(defun my-add-semantic-source ()
  (setq ac-sources (append '(ac-source-semantic) ac-sources)))
(add-hook 'c-mode-hook 'my-add-semantic-source)
;; (require 'auto-complete-etags)

;;(ac-set-trigger-key "TAB")
;;(define-key ac-mode-map (kbd "C-TAB") 'auto-complete)

(provide 'my-auto-complete)
