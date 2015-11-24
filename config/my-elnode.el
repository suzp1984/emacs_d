;;; my-elnode.el --- elnode configure

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

(require 'elnode)

;(defvar my-org-dir "~/tmp/org")

;; (defun my-elnode-org-handler (httpcon)
;;   (elnode-docroot-for my-org-dir
;;     with org-file
;;     on httpcon
;;     do (with-current-buffer (find-file-noselect org-file)
;;          (let ((org-html
;;                 ;; This might throw errors so you could condition-case it
;;                 (org-export-as-html 3 nil 'string)))
;;            (elnode-send-html httpcon org-html)))))

;; (elnode-start 'my-elnode-org-handler :port 8002)

;;(setq elnode-init-port 8702)

(defconst my-elnode-webserver-handler
   (elnode-webserver-handler-maker (expand-file-name "~/hack/html/")))
(elnode-start my-elnode-webserver-handler :port 8701 :host "localhost")

(defun my-elnode-hello-world-handler (httpcon)
  (elnode-http-start httpcon 200 '("Content-Type" . "text/html"))
  (elnode-http-return 
   httpcon 
   "<html><body><h1>Hello World</h1></body></html>"))
(add-to-list 'elnode-hostpath-default-table '("/helloworld/" . my-elnode-hello-world-handler))

(defvar my-elnode-editor-buffer (get-buffer-create "*my-elnode-editor-buffer*"))

(defun my-elnode-editor-handler (httpcon)
  (elnode-http-start httpcon 200 '("Content-Type" . "text/plain"))
  (elnode-http-return 
   httpcon 
   (with-current-buffer my-elnode-editor-buffer
     (buffer-substring-no-properties (point-min) (point-max)))))
(add-to-list 'elnode-hostpath-default-table '("/buffer/" . my-elnode-editor-handler))

(defun my-elnode-show-buffer ()
  (interactive)
  (let ((buffer (get-buffer-create my-elnode-editor-buffer)))
    (pop-to-buffer buffer)))

(elnode-init)

(provide 'my-elnode)
;;; my-elnode.el ends here
