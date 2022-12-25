(defun my-kill-everything ()
  (interactive)
  (dolist (cur (buffer-list))
    (kill-buffer cur)))

(defun fix-file-indent ()
  (interactive)
  (goto-char (point-min))
  (while (not (save-excursion (end-of-line) (eobp)))
    (move-beginning-of-line nil)
    (company-indent-or-complete-common t)
    (forward-line 1)))
