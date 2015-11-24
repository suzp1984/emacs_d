;;; my-qt.el --- Qt mode configuration 

;; Copyright (C) 2013  zxsu

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

(add-to-list 'auto-mode-alist 
             '("/Users/jacobsu/software/Qt5.1.1/5.1.1/clang_64/include" . c++-mode))

(semantic-add-system-include
 "/Users/jacobsu/software/Qt5.1.1/5.1.1/clang_64/include" 'c++-mode)

(add-to-list 'semantic-lex-c-preprocessor-symbol-file
             "/Users/jacobsu/software/Qt5.1.1/5.1.1/clang_64/include/QtCore/qconfig.h")

(add-to-list 'semantic-lex-c-preprocessor-symbol-file
             "/Users/jacobsu/software/Qt5.1.1/5.1.1/clang_64/include/QtCore/qconfig-dist.h")

(provide 'my-qt)
;;; my-qt.el ends here
