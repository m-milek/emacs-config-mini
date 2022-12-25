(defun my-split-window-horizontally-and-focus ()
  (interactive)
  (split-window-right)
  (other-window 1))

(defun my-split-window-vertically-and-focus ()
  (interactive)
  (split-window-below)
  (other-window 1))

(defun my-split-window-horizontally-and-focus-vterm ()
  (interactive)
  (split-window-right)
  (other-window 1)
  (vterm))


;;(my-split-window-vertically-and-focus)
;;(my-split-window-horizontally-and-focus)
;;(my-split-window-horizontally-and-focus-vterm)
