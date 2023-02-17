(setq home-dir (concat (getenv "HOME") "/"))
(setq latex-template-dir (concat home-dir "Documents/LaTeX/Templates/"))

(defun mm/latex-compile ()
  (interactive)
  (call-process-shell-command
   (concat "pdflatex " buffer-file-name)
   nil "*Shell Command Output*" t))

;; Compile and open the output in a buffer
(defun mm/latex-compile-and-view ()
  (interactive)
  (my-latex-compile)
    (find-file-other-window (concat (file-name-sans-extension buffer-file-name) ".pdf")))

(defun mm/new-latex-note (filename)
  (interactive "FFind file: ")
  (find-file filename)
  (insert-file (concat latex-template-dir "note_template.tex")))
