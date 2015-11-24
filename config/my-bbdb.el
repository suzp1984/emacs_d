(add-to-list 'load-path
             (expand-file-name "~/.emacs.d/emacs-lisp/bbdb-2.35/lisp/"))

(require 'bbdb)
(require 'bbdb-autoloads)
(setq
 bbdb-file "~/.bbdb"
 bbdb-gui t
 bbdb-offer-save 'auto
 bbdb-notice-auto-save-file t
 bbdb-expand-mail-aliases t
 bbdb-canonicalize-redundant-nets-p t
 bbdb-north-american-phone-numbers-p nil
 bbdb-check-zip-codes-p nil
 bbdb-always-add-addresses t
 bbdb-complete-name-allow-cycling t
 )

;;(add-to-list 'Info-directory-list "/Users/jacobsu/.emacs.d/emacs-lisp/bbdb-2.35/texinfo")
(add-to-list 'Info-default-directory-list (expand-file-name "~/.emacs.d/emacs-lisp/bbdb-2.35/texinfo"))

(setq gnus-score-find-score-files-function
      '(gnus-score-find-bnews bbdb/gnus-score))

;; gnus integration
(bbdb-initialize 'gnus 'message)
;; (bbdb-insinuate-message)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
(provide 'my-bbdb)
