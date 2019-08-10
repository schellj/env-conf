(defvar perltidy-mode nil
  "Automatically `perltidy' when saving.")
(make-variable-buffer-local 'perltidy-mode)

(defun perltidy-write-hook ()
  "Perltidys a buffer during `write-file-hooks' for
`perltidy-mode'. If perltidy returns nil then the buffer isn't saved."
  (if perltidy-mode
      (perltidy-buffer)))

(defun perltidy-mode (&optional arg)
  "Perltidy minor mode."
  (interactive "P")

  (setq perltidy-mode (if (null arg)
                          (not perltidy-mode)
                        (> (prefix-numeric-value arg) 0)))

  (funcall (if perltidy-mode #'add-hook #'remove-hook)
           'write-file-hooks 'perltidy-write-hook))

; Add this to the list of minor modes.
(if (not (assq 'perltidy-mode minor-mode-alist))
    (setq minor-mode-alist
          (cons '(perltidy-mode " Perltidy")
                minor-mode-alist)))

(provide 'perltidy-mode)
