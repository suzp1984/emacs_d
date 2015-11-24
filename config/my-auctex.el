;;(load "auctex.el" nil t t)
;;(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;;(setq tex-output-view-style '(("^pdf$" "." "evince  %o %(outpage)")))

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (add-to-list 'TeX-output-view-style '(("^pdf$" "." "evince  %o %(outpage)")))
            (setq TeX-engine 'xetex
                  TeX-command-default "XeLaTeX"
                  TeX-show-compilation t)))


(provide 'my-auctex)
