;; my org settings
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/org-8.2.2/lisp"))
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/org-8.2.2/contrib/lisp"))

(require 'org-install)

;;(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; (add-hook 'org-mode-hook 'turn-on-front-lock)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-log-into-drawer t)
(setq org-log-done 'time)
(setq org-agenda-files (list (expand-file-name "~/Dropbox/org/todo.org")))
(setq org-deadline-warning-days 7)
(setq org-clock-idle-time 10)
(setq org-directory (expand-file-name "~/Dropbox/org"))
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline org-default-notes-file "Tasks")
         "* TODO %?\n %i\n %a")
        ("j" "Journal" entry (file+datetree org-default-notes-file)
         "* %?\nEntered on %U\n %i\n %a")))
(setq org-feed-alist
      '(("Slashdot"
         "http://rss.slashdot.org/Slashdot/slashdot"
         (expand-file-name "~/Dropbox/org/feeds.org") "Slashdot Entries")))

(add-hook 'message-mode-hook 'turn-on-orgstruct)
(add-hook 'message-mode-hook 'turn-on-orgstruct++)
(add-hook 'message-mode-hook 'turn-on-orgtbl)

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
;; (setq org-support-shift-select t)
;; (setq org-agenda-span 'day)

;; enable fly spell mode
(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode 1)))

;; add cdlatex mode
(require 'cdlatex)
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

                                        ; allow for export=>beamer by placing

;; #+LaTeX_CLASS: beamer in org files
; (require 'org-latex)
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
             ;; beamer class, for presentations
             '("beamer"
               "\\documentclass[11pt]{beamer}\n
                \\mode<{{{beamermode}}}>\n
                \\usetheme{{{{beamertheme}}}}\n
                \\usecolortheme{{{{beamercolortheme}}}}\n
                \\beamertemplateballitem\n
                \\setbeameroption{show notes}
                \\usepackage[utf8]{inputenc}\n
                \\usepackage[T1]{fontenc}\n
                \\usepackage{hyperref}\n
                \\usepackage{color}
                \\usepackage{listings}
                \\lstset{numbers=none,language=[ISO]C++,tabsize=4,
                frame=single,
                basicstyle=\\small,
                showspaces=false,showstringspaces=false,
                showtabs=false,
                keywordstyle=\\color{blue}\\bfseries,
                commentstyle=\\color{red},
                }\n
                \\usepackage{verbatim}\n
                \\institute{{{{beamerinstitute}}}}\n          
                \\subject{{{{beamersubject}}}}\n"

               ("\\section{%s}" . "\\section*{%s}")
               
               ("\\begin{frame}[fragile]\\frametitle{%s}"
                "\\end{frame}"
                "\\begin{frame}[fragile]\\frametitle{%s}"
                "\\end{frame}")))

;; letter class, for formal letters

(add-to-list 'org-export-latex-classes
             '("letter"
               "\\documentclass[11pt]{letter}\n
      \\usepackage[utf8]{inputenc}\n
      \\usepackage[T1]{fontenc}\n
      \\usepackage{color}"
               
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; required to embed sh code
(require 'ob-sh)

;; add Eric Schulte's org-S5, which export html as slide show 
(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/org-S5"))
(require 'org-export-as-s5)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-lisp/o-blog"))
(require 'o-blog)

(provide 'my-org)
