(setq file-list
      (list
       "tohru_upscaled_emacs_logo.png"
       "flute-gnu.png"
       "bunny-girl.png"
       "kaguya-emacs-scaled.png"
       ))

(defun random-dashboard-image-path ()
  (setq picture-dir "/home/michal/.emacs.d/dashboard-pictures/")
  (concat picture-dir (nth (random (length file-list)) file-list)))
