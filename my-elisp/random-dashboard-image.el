(setq file-list
      (list
;;       "tohru_upscaled.png"
;;       "tohru_upscaled_emacs_logo.png"
       "bunny-girl.png"
       ))

(defun random-dashboard-image-path ()
  (setq picture-dir "/home/michal/.emacs.d/dashboard-pictures/")
  (concat picture-dir (nth (random (length file-list)) file-list)))
