;; wangyin settings
;; wangyin settings

(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;;(load "desktop")
;;(desktop-load-default)
;;(desktop-read)

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

(require 'ido)
(ido-mode t)


;;(require 'tabbar)
;;(tabbar-mode)
;;(global-set-key (kbd "M-]") 'tabbar-backward-group)
;;(global-set-key (kbd "M-[") 'tabbar-forward-group)
;;(global-set-key (kbd "M-n") 'tabbar-backward)
;;(global-set-key (kbd "M-p") 'tabbar-forward)

(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
 Typing `wy-go-to-char-key' again will move forwad to the next Nth
 occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
 		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

;; (define-key global-map (kbd "C-c a") 'wy-go-to-char)
(provide 'wangyin-setting)
