(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/emms/lisp"))
(require 'emms-setup)
(emms-standard)
(emms-default-players)

(provide 'my-emms)
