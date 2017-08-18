(global-set-key (kbd "C-SPC") 'set-mark-command)

(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-z") 'scroll-one-line-up)
(global-set-key (kbd "C--") 'undo)
(global-unset-key (kbd "C-h"))
(global-set-key (kbd "C-h") 'backward-delete-char)

(global-set-key (kbd "M-c") 'backward-capitalize-word)
(global-set-key (kbd "M-l") 'backward-downcase-word)
(global-set-key (kbd "M-u") 'backward-upcase-word)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "M-z") 'scroll-one-line-down)
(global-set-key (kbd "M-'") 'dabbrev-expand)
(global-set-key (kbd "M-C-'") 'dabbrev-completion)
(global-set-key (kbd "M-%") 'query-replace-regexp)

(global-set-key (kbd "C-x l") 'goto-line)
(global-set-key (kbd "C-x n") 'gosmacs-next-window)
(global-set-key (kbd "C-x p") 'gosmacs-previous-window)
(global-set-key (kbd "C-x RET") 'shell)
;; (global-set-key (kbd "C-x RET") 'term/shell)

(global-set-key (kbd "M-C-m") 'magit-status)

(global-unset-key [f2])
(define-prefix-command 'f2-map)
(global-set-key (kbd "<f2>") 'f2-map)
(global-set-key (kbd "<f2> l") 'goto-line)

(global-unset-key [f3])
(define-prefix-command 'f3-map)
(global-set-key (kbd "<f3>") 'f3-map)
(global-set-key (kbd "<f3> l") 'goto-line)

(global-set-key (kbd "s-s") 'copy-to-register)
(global-set-key (kbd "s-r") 'copy-rectangle-to-register)
(global-set-key (kbd "s-i") 'insert-register)
(global-set-key (kbd "s-SPC") 'point-to-register)
(global-set-key (kbd "s-j") 'jump-to-register)
(global-set-key (kbd "s-w") 'window-configuration-to-register)
(global-set-key (kbd "s-f") 'frameset-to-register)
(global-set-key (kbd "s-n") 'number-to-register)
(global-set-key (kbd "s-+") 'increment-register)
(global-set-key (kbd "s-a") 'append-to-register)
(global-set-key (kbd "s-p") 'prepend-to-register)
(global-set-key (kbd "s-k") 'kmacro-to-register)

(define-prefix-command 'help)
(global-set-key (kbd "C-/") 'help)
(global-set-key (kbd "C-c C-/") 'help)
(eval-after-load 'cperl-mode
  '(progn
     (define-key cperl-mode-map (kbd "C-/ f") 'cperl-info-on-current-command)
     (define-key cperl-mode-map (kbd "C-c C-/ F") 'cperl-info-on-command)
     (define-key cperl-mode-map (kbd "C-c C-/ P") 'cperl-perldoc-at-point)
     (define-key cperl-mode-map (kbd "C-c C-/ a") 'cperl-toggle-autohelp)
     (define-key cperl-mode-map (kbd "C-c C-/ f") 'cperl-info-on-command)
     (define-key cperl-mode-map (kbd "C-c C-/ p") 'cperl-perldoc)
     (define-key cperl-mode-map (kbd "C-c C-/ v") 'cperl-get-help)
     (define-key cperl-mode-map (kbd "C-h") nil)))

(eval-after-load "shell"
  '(progn
     (define-key shell-mode-map (kbd "C-c c") 'dirs)
     (define-key shell-mode-map (kbd "C-c f") 'find-file-at-point)
     (define-key shell-mode-map (kbd "C-j") 'term-switch-to-shell-mode)))

(eval-after-load 'term-mode
  '(progn
     (define-key term-raw-map (kbd "C-j") 'term-switch-to-shell-mode)))
