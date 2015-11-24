
(setq jabber-account-list
      '(("suzp1984@gmail.com"
         (:network-server . "talk.google.com")
         (:connection-type . ssl))))

(setq jabber-history-enabled t)
(setq jabber-debug-log-xml t)
(add-hook 'jabber-chat-mode-hook 'flyspell-mode)
;; (add-hook 'jabber-post-connect-hooks 'jabber-autoaway-start)
;; create a gtalk group chat
(defun egh:jabber-google-groupchat-create ()
  (interactive)
  (let ((group (apply 'format "private-chat-%x%x%x%x%x%x%x%x-%x%x%x%x-%x%x%x%x-%x%x%x%x-%x%x%x%x%x%x%x%x%x%x%x%x@groupchat.google.com"
                      (mapcar (lambda (x) (random x)) (make-list 32 15))))
        (account (jabber-read-account)))
    (jabber-groupchat-join account group (jabber-muc-read-my-nickname account group) t)))

;; Using notification-deamon
(defvar libnotify-program "/usr/bin/notify-send")

(defun notify-send (title message)
  (start-process "notify" "notify"
                 libnotify-program "--expire-time=4000" title message))

(defun libnotify-jabber-notify (from buf text proposed-alert)
  "Notify of new Jabber chat message via libnotify"
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if (jabber-muc-sender-p from)
        (notify-send (format "(PM) %s"
                             (jabber-jid-displayname (jabber-jid-user from)))
                     (format "%s: %s" (jabber-jid-resource from) text)))
    (notify-send (format "%s" (jabber-jid-displayname from))
                 text)))
(add-hook 'jabber-alert-message-hooks 'libnotify-jabber-notify)

(provide 'my-jabber)

