(defun my-latex-compile ()
  (shell-command (concat "pdflatex " buffer-file-name "&")))

;; buffer-file-name

