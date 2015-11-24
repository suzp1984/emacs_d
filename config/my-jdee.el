;;
(setq debug-on-error t)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/jdee-2.4.1/lisp/"))
(autoload 'jde-mode "jde" "JDE mode" t)
(setq auto-mode-alist
      (append '(("\\.java\\'" . jde-mode)) auto-mode-alist))


(setq defer-loading-jde nil)

(if defer-loading-jde
    (progn
      (autoload 'jde-mode "jde" "JDE mode." t)
      (setq auto-mode-alist
            (append
             '(("\\.java\\'" . jde-mode))
             auto-mode-alist)))
  (require 'jde))

(defun my-jde-mode-hook ()
  (setq c-basic-offset 4))

(provide 'my-jdee)
