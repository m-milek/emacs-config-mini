(defun map-to-sorted-list (map)
  "Return MAP converted to a list of pairs sorted by values, ascending."
  (let ((yy nil))
    (maphash
     (lambda (k v) (push (list k v) yy)) map)
    (sort yy (lambda (a b) (> (nth 1 a) (nth 1 b))))))

(defun char-summary ()
  "Count character occurences in current buffer."
  (interactive)
  (save-excursion
    (let ((char-map (make-hash-table :test 'equal)))
      (goto-char (point-min))
      (while (not (eobp))
        (let* ((current-char (string (char-after)))
               (current-count (gethash current-char char-map)))
          (if (not (eq current-count nil))
              (puthash current-char (+ current-count 1) char-map)
            (puthash current-char 1 char-map))
          (forward-char 1)))
      (with-output-to-temp-buffer (format "*char-summary for %s*" (buffer-name))
        (mapcar
         (lambda (el) (princ (format "%s  %s\n" (nth 0 el) (nth 1 el))))
         (seq-filter (lambda (c) (string-match "[[:graph:]]" (nth 0 c))) (map-to-sorted-list char-map)))))))
