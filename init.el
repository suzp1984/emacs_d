
;; emacs control-key settings for Mac OS X, uncomment following two lines for MacOS
;; (setq mac-option-modifier 'control)
;; (setq mac-command-modifier 'meta)

;; set your own personal info
(setq user-full-name "zxsu")
(setq user-mail-address "suzp1984@gmail.com")

(setq visible-bell t)
(setq inhibit-startup-message t)
(setq column-number-mode t)
(setq mouse-yank-at-point t)

;; (setq kill-ring-max 200)

(add-hook 'term-setup-hook 'zone)
;(add-hook 'auto-save-hook 'zone)

(auto-image-file-mode)
(mouse-avoidance-mode 'animate)

;; set env PATH and exec-path variable
(add-to-list 'exec-path "/opt/local/bin/")
(add-to-list 'exec-path "/usr/local/bin/")
(setenv "PATH" 
        (concat "/opt/local/bin/:/usr/local/bin/:"
                (getenv "PATH")))

;; add custome config file into load-path
(add-to-list 'load-path (expand-file-name "~/.emacs.d/config"))
;; add rare third-part lib
(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp"))

(defun load-my-config ()
  (require 'my-cedet)
  (require 'my-misc)
  (require 'my-scon)
  (require 'my-slime)
  (require 'my-jdibug)
  (require 'my-jdee)
  ;;(require 'my-malabar)
  (require 'wangyin-setting)
  (require 'my-yasnippet)
  (require 'my-auto-complete)
  (require 'my-java-auto-complete)
  ;;(require 'my-ecb)
  (require 'my-org)
  ;;(require 'my-mew)
  (require 'my-gnuplot)
  (require 'my-emms)
  (require 'my-auctex)
  (require 'my-android)
  (require 'my-python)
  (require 'my-package)
  ;(require 'my-ess)
  ;;(require 'my-dict)

  (require 'my-bbdb)
  (require 'my-eshell)
  (require 'my-jabber)
  (require 'my-tts)
  ;(require 'my-dictem)
  (require 'my-ruby)
  (require 'my-js)
  (require 'my-el-get)
  (require 'my-auto-insert)
  (require 'my-fs-mode)
  (require 'my-elnode)
  (require 'my-ensime)
  (require 'my-groovy)
  (require 'my-markdown)

  ;(require 'xcscope)
  ;(add-hook 'java-mode-hook (function cscope:hook))
  ;(add-hook 'jde-mode-hook (function cscope:hook))
)

;; load cutome config file after init 
(add-hook 'after-init-hook 
          'load-my-config)


;; global convenient navigation jump settings
(global-set-key [(control ?\.)] 'ska-point-to-register)
(global-set-key [(control ?\,)] 'ska-jump-to-register)


(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. 
 Use ska-jump-to-register to jump back to the stored 
 position."
  (interactive)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
 that was stored with ska-point-to-register."
  (interactive)
  (let ((tmp (point-marker)))
    (jump-to-register 8)
    (set-register 8 tmp)))

(require 'ctypes)
(ctypes-auto-parse-mode 1)

;; custome settings 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auto-insert (quote other))
 '(auto-insert-directory (expand-file-name "~/.emacs.d/insert-template/"))
 '(case-fold-search t)
 '(custom-enabled-themes (quote (deeper-blue)))
 '(ecb-options-version "2.40")
 '(elnode-do-init t)
 '(elnode-init-host "0.0.0.0")
 '(elnode-init-port 8702)
 '(erc-modules (quote (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring smiley sound stamp spelling track)))
 '(frame-background-mode (quote dark))
 '(org-drill-optimal-factor-matrix nil)
 '(rst-level-face-base-color "grey")
 '(send-mail-function (quote smtpmail-send-it))
 '(session-use-package t nil (session)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'erase-buffer 'disabled nil)

