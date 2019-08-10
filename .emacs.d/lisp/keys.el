(global-set-key (kbd "<backtab>") 'indent-rigidly)
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
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)

(global-set-key (kbd "C-x l") 'goto-line)
(global-set-key (kbd "C-x n") 'gosmacs-next-window)
(global-set-key (kbd "C-x p") 'gosmacs-previous-window)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
;; (global-set-key (kbd "C-x RET") 'term-shell)
(global-set-key (kbd "C-x RET") 'shell)

(global-set-key (kbd "M-C-m") 'magit-status)
(global-set-key (kbd "M-C-b") 'magit-blame)

(global-unset-key (kbd "s-i"))
(define-prefix-command 's-i-map)
(global-set-key (kbd "s-i") 's-i-map)
(global-set-key (kbd "s-i r") 'ivy-resume)

(global-unset-key (kbd "s-j"))
(define-prefix-command 's-j-map)
(global-set-key (kbd "s-j") 's-j-map)

(global-unset-key (kbd "s-r"))
(define-prefix-command 's-r-map)
(global-set-key (kbd "s-r") 's-r-map)
(global-set-key (kbd "s-r s") 'copy-to-register)
(global-set-key (kbd "s-r r") 'copy-rectangle-to-register)
(global-set-key (kbd "s-r i") 'insert-register)
(global-set-key (kbd "s-r SPC") 'point-to-register)
(global-set-key (kbd "s-r j") 'jump-to-register)
(global-set-key (kbd "s-r w") 'window-configuration-to-register)
(global-set-key (kbd "s-r f") 'frameset-to-register)
(global-set-key (kbd "s-r n") 'number-to-register)
(global-set-key (kbd "s-r +") 'increment-register)
(global-set-key (kbd "s-r a") 'append-to-register)
(global-set-key (kbd "s-r p") 'prepend-to-register)
(global-set-key (kbd "s-r k") 'kmacro-to-register)

(global-unset-key (kbd "s-m"))
(define-prefix-command 's-smerge-map)
(global-set-key (kbd "s-m") 's-smerge-map)

(global-unset-key (kbd "s-d"))
(define-prefix-command 's-d-map)
(global-set-key (kbd "s-d") 's-d-map)

(global-unset-key (kbd "s-g"))
(define-prefix-command 's-g-map)
(global-set-key (kbd "s-g") 's-g-map)
(global-set-key (kbd "s-g g") 'grep)
(global-set-key (kbd "s-g r") 'rgrep)

(global-unset-key (kbd "s-t"))
(define-prefix-command 's-t-map)
(global-set-key (kbd "s-t") 's-g-map)
(global-set-key (kbd "s-t d") 'perltidy-dwim-safe)

(global-unset-key (kbd "s-p"))
(global-set-key (kbd "s-p") 'projectile-command-map)

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

;; (eval-after-load "term"
;;   '(progn
;;      (define-key term-raw-map (kbd "C-x C-j") 'term-toggle-input-mode)
;;      (define-key term-raw-map (kbd "s-v") 'term-paste)
;;      (define-key term-mode-map (kbd "C-x C-j") 'term-toggle-input-mode)
;;      (define-key term-mode-map (kbd "C-c f") 'find-file-at-point)))
