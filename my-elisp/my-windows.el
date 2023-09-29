(defun mm/split-window-horizontally-and-focus ()
  (interactive)
  (split-window-right)
  (other-window 1))

(defun mm/split-window-vertically-and-focus ()
  (interactive)
  (split-window-below)
  (other-window 1))

(defun mm/split-window-horizontally-and-focus-vterm ()
  (interactive)
  (mm/split-window-horizontally-and-focus)
  (vterm))

