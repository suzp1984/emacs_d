(add-to-list 'load-path (expand-file-name "~/.emacs.d/malabar-1.4.0/lisp/"))
;; load following line after load my-cedet
(require 'cedet)

(require 'semantic)
(semantic-load-enable-minimum-features)
;;(setq semantic-default-submodes '())

(require 'malabar-mode)
(setq malabar-groovy-lib-dir (expand-file-name "~/.emacs.d/malabar-1.4.0/lib/")
      malabar-load-source-from-sibling-projects t)
;; add source/JAR path to malabar, for example android development.
;;(setq malabar-extra-source-locations '())
;;(add-to-list 'malabar-extra-source-locations "/Users/jacobsu/software/adt-linux/adt-bundle-linux-x86_64-20130717/sdk/platforms/android-18/android.jar")
(add-to-list 'malabar-extra-source-locations (expand-file-name "~/software/adt-linux/adt-bundle-linux-x86_64-20130717/sdk/sources/android-18/"))

(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))

(defun my-java-malabar-mode-hook ()
  (define-key c-mode-base-map "\C-\M-g" 'malabar-jump-to-thing)
  (global-set-key "\M-n" 'semantic-ia-complete-symbol))
(add-hook 'c-mode-common-hook 'my-java-malabar-mode-hook)

;; compile the file on save make malabar display the errors
;; (add-hook 'malabar-mode-hook
;;           (lambda () 
;;             (add-hook 'after-save-hook 'malabar-compile-file-silently
;;                       nil t)))

;; jdibug settings
(setq jdibug-connect-hosts (quote ("localhost:5005"))
      jdibug-use-jde-source-paths nil)
;; if you are debug android source code, maybe add android souce code into following path
;;(add-to-list 'jdibug-source-paths )

;; key binding settings
;; jdibug-step-into jdibug-step-over jdibug-step-out jdibug-connect
;; (defun my-jdibug-mode-hook ()
;;   (define-key c-mode-base-map [(f7)] 'jdibug-step-into)
;;   (define-key c-mode-base-map [(f8)] 'jdibug-step-over)
;;   (define-key c-mode-base-map [(f9)] 'jdibug-step-out))

;; http://www.skybert.net/emacs/using-malabar-for-java-development/
;; Make Emace understand Ant's and mvn's output
(require 'compile)
(setq compilation-error-regexp-alist
      (append (list
               ;; works for jikes
               '("^\\s-*\\[[^]]*\\]\\s-*\\(.+\\):\\([0-9]+\\):\\([0-9]+\\):[0-9]+:[0-9]+:" 1 2 3)
               ;; works for javac
               '("^\\s-*\\[[^]]*\\]\\s-*\\(.+\\):\\([0-9]+\\):" 1 2)
               ;; works for maven 2.x
               '("^\\(.*\\):\\[\\([0-9]*\\),\\([0-9]*\\)\\]" 1 2 3)
               ;; works for maven 3.x
               '("^\\(\\[ERROR\\] \\)?\\(/[^:]+\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\]" 2 3 4)
               '("^\\(\\[WARNING\\] \\)?\\(/[^:]+\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\]" 2 3 4)
               )
              compilation-error-regexp-alist))

(provide 'my-malabar)
