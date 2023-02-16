(defun my-kill-everything ()
  (interactive)
  (dolist (cur (buffer-list))
    (kill-buffer cur)))

(defun my-match-lsp-formatting ()
  (interactive)
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (clang-format-buffer)
    (lsp-format-buffer)))

(defun my-fix-file-indent ()
  (interactive)
  (goto-char (point-min))
  (while (not (save-excursion (end-of-line) (eobp)))
    (move-beginning-of-line nil)
    (company-indent-or-complete-common t)
    (forward-line 1)))

(defun my-save-point ()
  "Save the current frame, window and point in a buffer"
  (interactive)
  (setq my-saved-frame (selected-frame))
  (setq my-saved-window (frame-selected-window))
  (setq my-saved-mark (point-marker))
  (message "Saved mark %s" my-saved-mark))

(defun my-save-point-and-fn (arg-fn)
  "Execute my-save-point and then execute arg-fn"
  (interactive)
  (my-save-point)
  (funcall arg-fn))

(defun my-go-to-saved-point ()
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

(setq my-vterm-toggled nil)
(setq my-vterm-window nil)
(defun my-toggle-vterm-below ()
  (interactive)
  (if (eq my-vterm-toggled t)
      (progn
        (delete-window my-vterm-window)
        (setq my-vterm-toggled nil))
    (progn
      (setq my-vterm-window (split-window-below -15))
      (setq my-vterm-toggled t)
      (other-window 1)
      (vterm))))

