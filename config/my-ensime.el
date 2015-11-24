;;; my-ensime.el --- 

;; Copyright (C) 2014  zxsu

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

(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/ensime_emacs/elisp/"))
(let ((sbt-bin "/usr/local/bin/")
      (scala-bin "/Users/moses/software/scala-2.11.2/bin/"))
  (progn (push sbt-bin exec-path)
         (push scala-bin exec-path))
  )

(require 'ensime)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(provide 'my-ensime)
;;; my-ensime.el ends here
