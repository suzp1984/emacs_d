(setq user-emacs-directory (file-name-directory (or buffer-file-name load-file-name))) ;; current direcotry

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

;; (add-to-list 'package-archives
;;             '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)
(package-refresh-contents)

(package-install 'elnode)
;; (package-install 'cedet) ;; cedet is built-in

(package-install 'slime)
