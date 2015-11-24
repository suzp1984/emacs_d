;; add load path
;(add-to-list 'load-path "/home/zxsu/.emacs.d/emacs-lisp/android-kit/")

;; android-comman.el android-compile.el android-host.el come from Google source code.
;; By default, google provide those cmd in Android development. but not for app developer.
;; provide android-compile interactive cmd, used in compile Android Source code
;(require 'android-compile)
;; 
;; By default the following key bindings are active:
;; C-x a a android-adb-root
;; C-x a r android-adb-remount
;; C-x a s android-adb-sync
;; C-x a b android-adb-shell-reboot-bootloader
;; C-x a f android-fastboot-flashall
;(require 'android-host)

;; following android-mode-* provided by app developer folks
;; providered following cmd
;; android-start-ddms
;; android-start-emulator
;; android-logcat
;; android-ant-clean
;; android-ant-compile
;; android-ant-install
;; android-ant-reinstall
;; android-ant-uninstall
;; have a keymap prefix "C-c C-c"
;(require 'android-mode-autoloads)

;; this package provided by anthor folks
;; android-jdb
;; android-emulate
;; android-install-app
;; android-uninstall-app
;; android-start-activity
;; android-debug-activity
;(require 'android)

;; android-mode configure
(setq android-mode-sdk-dir (expand-file-name "~/software/adt-bundle-mac-x86_64-20130917/sdk"))
;(setq android-mode-avd "")

(provide 'my-android)
