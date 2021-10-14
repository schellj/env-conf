(defun gosmacs-previous-window ()
  "Select the window above or to the left of the window now selected.
From the window at the upper left corner, select the one at the lower right."
  (interactive)
  (select-window (previous-window)))

(defun gosmacs-next-window ()
  "Select the window below or to the right of the window now selected.
From the window at the lower right corner, select the one at the upper left."
  (interactive)
  (select-window (next-window)))

(defun scroll-one-line-up (&optional arg)
  "Scroll the selected window up (forward in the text) one line (or N lines)."
  (interactive "p")
  (scroll-up (or arg 1)))

(defun scroll-one-line-down (&optional arg)
  "Scroll the selected window down (backward in the text) one line (or N)."
  (interactive "p")
  (scroll-down (or arg 1)))

(defun backward-upcase-word (&optional arg)
  (interactive "p")
  (upcase-word (- (or arg 1))))
(defun backward-downcase-word (&optional arg)
  (interactive "p")
  (downcase-word (- (or arg 1))))
(defun backward-capitalize-word (&optional arg)
  (interactive "p")
  (capitalize-word (- (or arg 1))))

(defun ffap-gits (name)
  (setq start (point))
  (re-search-backward "=== \\([a-zA-Z0-9-_]+\\) ===" nil t 1)
  (setq repo (match-string 1))
  (goto-char start)
  (message "ffap-gits: %s" repo)
  repo)

(defun ffap-gits-current (name)
  (concat (ffap-gits name) "/" name))

(defun ffap-gits-src (name)
  (concat "~/GT/repo/" (ffap-gits name) "/" name))

(defun what-face (pos)
    (interactive "d")
        (let ((face (or (get-char-property (point) 'read-face-name)
            (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(require 'cl)
(defun kill-matching-buffers-no-ask (regexp)
  (cl-letf (((symbol-function 'kill-buffer-ask) #'kill-buffer))
    (kill-matching-buffers regexp)))

(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat "-/" output)))
    output))

(defun smerge-try-smerge ()
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^<<<<<<< " nil t)
      (require 'smerge-mode)
      (smerge-mode 1))))

(defun json-condense (beg end)
  "Collapse prettified json in region between BEG and END to a single line"
  (interactive "r")
  (if (use-region-p)
      (save-excursion
        (save-restriction
          (narrow-to-region beg end)
          (goto-char (point-min))
          (while (re-search-forward "[[:space:]\n]+" nil t)
            (replace-match " "))))
    (print "This function operates on a region")))

(defun jschell/vterm (&optional buffer-name)
  "Create a new vterm.

If called with an argument BUFFER-NAME, the name of the new buffer will
be set to BUFFER-NAME, otherwise it will be `vterm'"
  (interactive)
  (let ((buffer (generate-new-buffer (or buffer-name "vterm"))))
    (with-current-buffer buffer
      (vterm-mode))
    buffer))

(defun assert-vterm ()
  "Switch to vterm window. If prefix is nil, find existing vterm window or create one. If prefix is non-nil create a new vterm window regardless of if one exists."
  (interactive)
  (let ((vterm-buffer
         (or
          (and current-prefix-arg (jschell/vterm))
          (get-buffer "vterm")
          (jschell/vterm))))
    (display-buffer vterm-buffer)
    (select-window (get-buffer-window vterm-buffer))))

(defun jschell/display-number-as-char (&optional undo)
  "Display number as character, for example, display 24 as C-x.

Why? Becuase I find the output of 'C-h v help-map' is hard to
read."
  (interactive "P")
  (if undo
      (remove-overlays nil nil 'chunyang-show-number-as-char t)
    (save-excursion
      (goto-char (point-min))
      (let (ov)
        (while (re-search-forward "[0-9]+" nil :no-error)
          (setq ov (make-overlay (match-beginning 0) (match-end 0)))
          (overlay-put ov 'display (single-key-description
                                    (string-to-number (match-string 0))))
          (overlay-put ov 'chunyang-show-number-as-char t))))))
