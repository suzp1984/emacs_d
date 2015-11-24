;;; my-groovy.el ---                                 -*- lexical-binding: t; -*-

;; Copyright (C) 2015  zxsu

;; Author: zxsu <suzp1984@gmail.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/groovy-emacs-modes"))

(require 'groovy-mode)
(require 'groovy-electric)
(require 'grails-mode)

;;; env setup

(setenv "JAVA_HOME" "/System/Library/Frameworks/JavaVM.framework/Versions/Current/")
(setenv "GROOVY_HOME" (expand-file-name "~/.gvm/groovy/current/"))
(setenv "MAVEN_HOME" (expand-file-name "~/software/apache-maven-3.2.2/"))

(setenv "PATH" (concat (getenv "PATH")
                       ":" (getenv "GROOVY_HOME") "/bin"
                       ":" (getenv "MAVEN_HOME") "/bin"))

;;; turn on syntax highlighting
(global-font-lock-mode 1)

;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;;; make groovy mode electric by default.
(add-hook 'groovy-mode-hook
          '(lambda ()
             (require 'groovy-electric)
             (groovy-electric-mode)))

(provide 'my-groovy)
;;; my-groovy.el ends here
