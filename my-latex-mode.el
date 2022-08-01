(defun my-latex-compile ()
  (interactive)
  (call-process-shell-command
   (concat "pdflatex " buffer-file-name)
   nil "*Shell Command Output*" t))
  ;;(concat (file-name-sans-extension) "pdf"))

;; Compile and open the output in a buffer
(defun my-latex-compile-and-view ()
  (interactive)
  (my-latex-compile)
  ;;(with-help-window "*latex-preview*"
    (find-file-other-window (concat (file-name-sans-extension buffer-file-name) ".pdf")))
