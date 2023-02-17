(defun mm/kill-everything ()
  (interactive)
  (dolist (cur (buffer-list))
    (kill-buffer cur)))

(defun mm/match-lsp-formatting ()
  (interactive)
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (clang-format-buffer)
    (lsp-format-buffer)))

(defun mm/fix-file-indent ()
  (interactive)
  (goto-char (point-min))
  (while (not (save-excursion (end-of-line) (eobp)))
    (move-beginning-of-line nil)
    (company-indent-or-complete-common t)
    (forward-line 1)))

(defun mm/save-point ()
  "Save the current frame, window and point in a buffer"
  (interactive)
  (setq my-saved-frame (selected-frame))
  (setq my-saved-window (frame-selected-window))
  (setq my-saved-mark (point-marker))
  (message "Saved mark %s" my-saved-mark))

(defun mm/save-point-and-fn (arg-fn)
  "Execute my-save-point and then execute arg-fn"
  (interactive)
  (mm/save-point)
  (funcall arg-fn))

(defun mm/go-to-saved-point ()
  "Select frame from my-saved-frame, select window
from my-saved-window,
set mark from my-saved-mark"
  (interactive)
  (select-frame my-saved-frame)
  (select-window my-saved-window)
  (set-mark my-saved-mark)
  (exchange-point-and-mark)
  (message "Moved to mark %s" my-saved-mark)
  (keyboard-escape-quit))

(defun mm/toggle-vterm-below ()
  (interactive)
  (let ((vterm-buffer (get-buffer "*vterm*"))
        (vterm-size -15))
    (cond
     ;; Doesn't exist
     ((eq vterm-buffer nil)
      (progn
        (split-window-below vterm-size)
        (other-window 1)
        (vterm)))
     ;; Visible
     ((or (eq vterm-buffer (window-buffer (selected-window))) (get-buffer-window vterm-buffer))
        (delete-window (get-buffer-window vterm-buffer)))
     ;; Not visible
     (t
      (progn
        (split-window-below vterm-size)
        (other-window 1)
        (switch-to-buffer vterm-buffer))))))
