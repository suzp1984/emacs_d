(setq user-emacs-directory (file-name-directory load-file-name)) ;; current direcotry

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)

(package-install "elnode")
