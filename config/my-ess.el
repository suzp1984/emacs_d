;; ess settings
(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/ess-12.09/lisp"))
(require 'ess-site)

(setq ess-eval-visibly-p nil)
(setq ess-ask-for-ess-directory nil)

(provide 'my-ess)
