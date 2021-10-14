(server-start)

(setq debug-on-error t)

(require 'package)
(setq package-enable-at-startup nil)
(setq package-native-compile t)

(custom-set-default 'package-selected-packages
 '(
   all-the-icons
   all-the-icons-ivy
   all-the-icons-ivy-rich
   anzu
   auto-compile
   auto-dim-other-buffers
   auto-package-update
   column-enforce-mode
   command-log-mode
   company
   company-box
   company-fuzzy
   company-posframe
   company-prescient
   counsel-projectile
   csharp-mode
   dap-mode
   dbc
   default-text-scale
   dumb-jump
   exec-path-from-shell
   expand-region
   fancy-battery
   flx
   flycheck
   flycheck-posframe
   fringe-helper
   git-gutter-fringe
   go-mode
   highlight
   highlight-indent-guides
   highlight-symbol
   highlight-thing
   hydra
   ivy
   ivy-hydra
   ivy-posframe
   ivy-prescient
   ivy-yasnippet
   js2-mode
   js2-refactor
   json-mode
   keycast
   lsp-ivy
   lsp-mode
   lsp-ui
   magit
   major-mode-hydra
   markdown-mode
   minibuffer-line
   persistent-scratch
   php-mode
   prescient
   projectile
   smartparens
   spaceline
   spaceline-all-the-icons
   use-package
   use-package-hydra
   volatile-highlights
   vterm
   which-key
   xml-format
   xterm-color
   yaml-mode
   ))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(add-to-list 'load-path "~/.emacs.d/lisp")

(eval-after-load 'gnutls
  '(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t
      use-package-always-demand t)

(unless (package-installed-p 'auto-compile)
  (package-install 'auto-compile))

(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

(package-autoremove)
(package-install-selected-packages)

;; (native-compile-async "~/.emacs.d/elpa" t t)

;; Why do I have to require these manually here?
;; (require 'hydra)
;; (require 'flycheck)

(use-package emacs
  :bind
  ;; move to tab-line-mode specific bindings
  ("s-}" . tab-line-switch-to-next-tab)
  ("s-{" . tab-line-switch-to-prev-tab)
  ("M-0" . jschell/select-kgpw-window)
  ("M-1" . jschell/select-main-frame)
  ("M-3" . jschell/select-terminal-frame)
  ("M-5" . jschell/select-bgdispatch-log-window)
  ("s-1" . jschell/select-1st-tab-line-buffer)
  ("s-2" . jschell/select-2nd-tab-line-buffer)
  ("s-3" . jschell/select-3rd-tab-line-buffer)
  ("s-4" . jschell/select-4th-tab-line-buffer)
  ("s-5" . jschell/select-5th-tab-line-buffer)
  ("s-6" . jschell/select-6th-tab-line-buffer)
  ("s-7" . jschell/select-7th-tab-line-buffer)
  ("s-8" . jschell/select-8th-tab-line-buffer)
  ("s-9" . jschell/select-9th-tab-line-buffer)
  ("s-0" . jschell/select-last-tab-line-buffer)
  :custom
  (blink-cursor-blinks -1)
  (window-divider-default-right-width 1)
  (window-divider-default-bottom-width 1)
  (pcomplete-ignore-case t)
  (vc-git-diff-switches "-b")
  (vc-diff-switches "-b")
  (case-fold-search t)
  (case-replace t)
  (comint-prompt-read-only nil)
  (comint-scroll-to-bottom-on-input t)
  (completions-format 'vertical)
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (show-trailing-whitespace nil)
  (tab-width 4)
  (transient-mark-mode t)
  (truncate-partial-width-windows nil)
  (visible-bell nil)
  (vc-make-backup-files t)
  (backup-by-copying t)
  (delete-old-versions t)
  (kept-new-versions 10)
  (kept-old-versions 0)
  (version-control t)
  (vc-follow-symlinks nil)
  (backup-directory-alist (list (cons ".*" (expand-file-name "~/.emacs.d/backup"))))
  (auto-save-list-file-prefix (expand-file-name "~/.emacs.d/autosave"))
  (auto-save-file-name-transforms `((".*" ,(expand-file-name "~/.emacs.d/autosave") t)))
  (create-lockfiles nil)
  (indent-tabs-mode nil)
  (fill-column 100)
  (comment-auto-fill-only-comments t)
  (display-buffer-alist
   '(("^magit: " (jschell/display-buffer-right))
     ("^vterm" (jschell/display-buffer-left))))
  (tab-line-tabs-function #'jschell/tab-line-buffers)
  (tab-line-tab-name-function #'jschell/tab-line-tab-name-buffer)
  (tab-line-new-button-show nil)
  (tab-line-close-button-show nil)
  (tab-line-switch-cycling t)
  (desktop-restore-in-current-display nil)
  (desktop-files-not-to-save ".*")
  (recentf-max-saved-items 50)
  (find-file-suppress-same-file-warnings t)
  (find-file-visit-truename t)
  (dabbrev-abbrev-char-regexp "[0-9a-zA-Z_]")
  (scroll-bar-mode nil)
  (switch-to-buffer-preserve-window-point nil)
  (term-buffer-maximum-size 20000)
  (vc-follow-symlinks t)
  (vc-git-diff-switches "-b")
  (whitespace-style
   '(face trailing tabs empty indentation::space indentation space-after-tab::tab space-after-tab::space space-after-tab space-before-tab::tab space-before-tab::space space-before-tab))
  (ansi-color-faces-vector
   [default default default italic underline success warning error])
  ;; -- wtf did i have these?
  ;; (auto-compression-mode nil)
  ;; (auto-encryption-mode nil)
  ;; --
  (c-tab-always-indent t)
  (clean-buffer-list-delay-general 2)
  (column-highlight-mode nil)
  (comint-scroll-to-bottom-on-input t)
  (mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control))))
  (ns-antialias-text t)
  (ns-auto-hide-menu-bar nil)
  (ns-use-native-fullscreen t)
  (py-tab-indent t)
  (safe-local-variable-values
   '((projectile-project-run-cmd . "mkdir -p build; cd build; cmake ..; make run")
     (projectile-project-compilation-cmd . "mkdir -p build; cd build; cmake ..; make")
     (eval font-lock-add-keywords nil
           `((,(concat "("
                       (regexp-opt
                        '("sp-do-move-op" "sp-do-move-cl" "sp-do-put-op" "sp-do-put-cl" "sp-do-del-op" "sp-do-del-cl")
                        t)
                       "\\_>")
              1 'font-lock-variable-name-face)))))
  :custom-face
  (tab-line ((t (:foreground nil :background "#333333"))))
  (tab-line-tab ((t (:foreground nil :background "#7777AA"))))
  (tab-line-tab-current ((t (:foreground nil :background "#7777AA"))))
  (tab-line-tab-inactive ((t (:foreground nil :background "#555588"))))
  :init
  (global-font-lock-mode t)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (window-divider-mode +1)
  ;; (desktop-save-mode +1)
  (set-display-table-slot standard-display-table 'wrap ?·)
  :config
  (add-hook 'xwidget-webkit-mode-hook #'jschell/xwidget-webkit-mode-hook)
  (defun jschell/xwidget-webkit-mode-hook ()
    ""
    (local-unset-key (kbd "SPC"))
    (local-unset-key (kbd "DEL"))
    (local-unset-key (kbd "-"))
    (local-unset-key (kbd "0"))
    (local-unset-key (kbd "1"))
    (local-unset-key (kbd "2"))
    (local-unset-key (kbd "3"))
    (local-unset-key (kbd "4"))
    (local-unset-key (kbd "5"))
    (local-unset-key (kbd "6"))
    (local-unset-key (kbd "7"))
    (local-unset-key (kbd "8"))
    (local-unset-key (kbd "9"))
    (local-unset-key (kbd "<"))
    (local-unset-key (kbd ">"))
    (local-unset-key (kbd "?"))
    (local-unset-key (kbd "g"))
    (local-unset-key (kbd "h"))
    (local-unset-key (kbd "q"))
    (local-unset-key (kbd "S-SPC")))
  (defun jschell/xwidget-webkit-send-key (key)
    ""
    (interactive)
    (message "sending key %s" key)
    (xwidget-webkit-execute-script
     (xwidget-webkit-current-session)
     (format "
element.dispatchEvent(new KeyboardEvent('keydown',{'key':'%s'}));
element.dispatchEvent(new KeyboardEvent('keyup',{'key':'%s'}));
" key key)))
  (defun jschell/xwidget-webkit-send-spc ()
    ""
    (interactive)
    (jschell/xwidget-webkit-send-key "SPC"))
  (defun jschell/xwidget-webkit-send-del ()
    ""
    (interactive)
    (jschell/xwidget-webkit-send-key "DEL"))
  (defun jschell/xwidget-webkit-send-a ()
    ""
    (interactive)
    (jschell/xwidget-webkit-send-key "a"))
  (defun jschell/display-buffer (buffer side)
    "Select SIDE window for BUFFER if two non-minibuffer windows are visible."
    (if (one-window-p)
        (split-window nil nil side))
    (if (equal side 'left)
        (set-window-buffer (frame-first-window) buffer)
      (set-window-buffer (previous-window (frame-first-window)) buffer)))
  (defun jschell/display-buffer-left (buffer &optional alist)
    "Select left window for BUFFER."
    (jschell/display-buffer buffer 'left))
  (defun jschell/display-buffer-right (buffer &optional alist)
    "Select right window for BUFFER."
    (jschell/display-buffer buffer 'right))
  (defun jschell/tab-line-buffers ()
    "List of tab-line buffers for current frame"
    (let* ((frame-name (frame-parameter nil 'name))
           (all-buffers (buffer-list))
           (this-window (selected-window))
           (this-buffer (window-buffer this-window))
           (buffers-to-show (or (and (string-match "terminal" frame-name)
                                     (seq-sort (lambda (a b) (string< (buffer-name a) (buffer-name b)))
                                               (seq-filter (lambda (b) (string-match "^term" (buffer-name b))) all-buffers)))
                                all-buffers)))
      buffers-to-show))
  (defvar jschell/tab-height 16)
  (require 'powerline)
  (defvar jschell/tab-left (powerline-rounded-right 'tab-line nil jschell/tab-height))
  (defvar jschell/tab-right (powerline-rounded-left nil 'tab-line jschell/tab-height))
  (defun jschell/tab-line-tab-name-buffer (buffer &optional _buffers)
    (powerline-render (list jschell/tab-left (format " %s " (buffer-name buffer)) jschell/tab-right)))
  (defvar jschell/frame-to-focus nil)
  (defun jschell/after-focus-change-function ()
    "Prevent MacOS from subverting the intended frame to focus"
    (when (and jschell/frame-to-focus (not (string= (cdr (assq 'name (frame-parameters (selected-frame)))) jschell/frame-to-focus)))
      (select-frame-by-name jschell/frame-to-focus))
    (setq jschell/frame-to-focus nil))
  (add-function :after after-focus-change-function 'jschell/after-focus-change-function)
  (defun jschell/select-nth-tab-line-buffer (n)
    "Select the Nth tab line buffer"
    (switch-to-buffer (nth n (jschell/tab-line-buffers))))
  (defun jschell/select-last-tab-line-buffer ()
    "Select the last tab line buffer"
    (interactive)
    (let ((buffer-list (jschell/tab-line-buffers)))
      (switch-to-buffer (nth (- (safe-length buffer-list) 1) buffer-list))))
  (defun jschell/select-1st-tab-line-buffer ()
    "Select the 1st tab line buffer"
    (interactive)
    (jschell/select-nth-tab-line-buffer 0))
  (defun jschell/select-2nd-tab-line-buffer ()
    "Select the 1st tab line buffer"
    (interactive)
    (jschell/select-nth-tab-line-buffer 1))
  (defun jschell/select-3rd-tab-line-buffer ()
    "Select the 1st tab line buffer"
    (interactive)
    (jschell/select-nth-tab-line-buffer 2))
  (defun jschell/select-4th-tab-line-buffer ()
    "Select the 1st tab line buffer"
    (interactive)
    (jschell/select-nth-tab-line-buffer 3))
  (defun jschell/select-5th-tab-line-buffer ()
    "Select the 1st tab line buffer"
    (interactive)
    (jschell/select-nth-tab-line-buffer 4))
  (defun jschell/select-6th-tab-line-buffer ()
    "Select the 1st tab line buffer"
    (interactive)
    (jschell/select-nth-tab-line-buffer 5))
  (defun jschell/select-7th-tab-line-buffer ()
    "Select the 1st tab line buffer"
    (interactive)
    (jschell/select-nth-tab-line-buffer 6))
  (defun jschell/select-8th-tab-line-buffer ()
    "Select the 1st tab line buffer"
    (interactive)
    (jschell/select-nth-tab-line-buffer 7))
  (defun jschell/select-9th-tab-line-buffer ()
    "Select the 1st tab line buffer"
    (interactive)
    (jschell/select-nth-tab-line-buffer 8))
  (defun jschell/select-buffer (frame-name buffer-name)
    "Select visible buffer with NAME"
    (interactive)
    (select-frame-by-name frame-name)
    (set-frame-selected-window nil (get-buffer-window buffer-name) t))
  (defun jschell/select-hangouts-window ()
    "Select hangouts chat window"
    (interactive)
    (jschell/select-buffer "static" "hangouts"))
  (defun jschell/select-music-window ()
    "Select music window"
    (interactive)
    (jschell/select-buffer "static" "music"))
  (defun jschell/select-bgdispatch-log-window ()
    "Select music window"
    (interactive)
    (jschell/select-buffer "static" "bgdispatch-log"))
  (defun jschell/select-bgdispatch-log-window-external ()
    "Select music window"
    (interactive)
    (setq jschell/frame-to-focus "static")
    (jschell/select-buffer "static" "bgdispatch-log"))
  (defun jschell/select-kgpw-window ()
    "Select kgpw window"
    (interactive)
    (jschell/select-buffer "static" "kgpw"))
  (defun jschell/select-terminal-frame ()
    "Select terminal frame"
    (interactive)
    (select-frame-by-name "terminal"))
  (defun jschell/select-terminal-frame-external ()
    "Select terminal frame"
    (interactive)
    (setq jschell/frame-to-focus "terminal")
    (select-frame-by-name jschell/frame-to-focus))
  (defun jschell/select-main-frame ()
    "Select main frame"
    (interactive)
    (select-frame-by-name "main"))
  (defun jschell/select-main-frame-external ()
    "Select main frame"
    (interactive)
    (setq jschell/frame-to-focus "main")
    (select-frame-by-name jschell/frame-to-focus))
  (defun jschell/select-static-frame ()
    "Select static frame"
    (interactive)
    (select-frame-by-name "static"))
  (defun jschell/toggle-window-dedicated ()
    "Control whether or not Emacs is allowed to display another buffer in current window."
    (interactive)
    (message
     (if (let (window (get-buffer-window (current-buffer)))
           (set-window-dedicated-p window (not (window-dedicated-p window))))
         "%s now dedicated to this window"
       "%s no longer dedicated to this window")
     (current-buffer)))
  (epa-file-enable)
  (setq
   xwidget-webkit-mode-hook nil
   custom-file null-device
   comp-speed 2
   comp-deferred-compilation nil
   load-prefer-newer t
   debug-on-error t
   perl-indent-parens-as-block t
   c-basic-offset 4
   c-subword-mode t
   complete-ignore-case t
   completion-ignore-case t
   shr-color-visible-luminance-min 90
   desktop-path '("~/.emacs.d")
   xwidget-webkit-mode-map (make-sparse-keymap))
  (setq-default auto-fill-function 'do-auto-fill)

;; Emacs 26.2 bug workaround
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

  (setq custom-theme-load-path
	(append '( "~/.emacs.d/themes" ) custom-theme-load-path))

  (if (memq window-system '(mac ns))
      (progn
	(setq
	 mac-command-modifier 'super
	 mac-option-modifier 'meta)
	(set-scroll-bar-mode nil)
	(load-theme 'schellj-gui t)
	(fringe-mode '(2 . 0)))
    (load-theme 'schellj-terminal t))

  (require 'gt-perl)
  (defalias 'perl-mode 'cperl-mode)

  (load-library "keys.el")
  (load-library "functions.el")
  )

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "SSH_AGENT_PID")
  (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
  (exec-path-from-shell-copy-env "DBR_PRISTINE")
  (exec-path-from-shell-copy-env "DBR_SANDBOX")
  (exec-path-from-shell-copy-env "DBR_CONF_FILE"))

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t
        auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package default-text-scale
  :config
  (default-text-scale-mode))

(use-package anzu
  :custom-face
  (anzu-mode-line ((t (:inherit 'powerline-active1)))))

(use-package hydra)

(use-package smerge-mode
  :after hydra
  :hook ((find-file . smerge-try-smerge)
         (after-revert . smerge-try-smerge))
  :bind
  ("s-m" . hydra-smerge/body)
  :init
  (defhydra
    hydra-smerge
    (:quit-key "C-g")
    "smerge"
    ("n" smerge-next "Next")
    ("p" smerge-previous "Previous")
    ("u" smerge-keep-upper "Keep Upper")
    ("l" smerge-keep-lower "Keep Lower")
    ("b" smerge-keep-all "Keep Both")))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package ffap
  :config
  (add-to-list 'ffap-alist '(shell-mode . ffap-gits-src))
  (add-to-list 'ffap-alist '(shell-mode . ffap-gits-current))
  (add-to-list 'ffap-alist '(term-mode . ffap-gits-src))
  (add-to-list 'ffap-alist '(term-mode . ffap-gits-current))
  (add-to-list 'ffap-alist '(vterm-mode . ffap-gits-src))
  (add-to-list 'ffap-alist '(vterm-mode . ffap-gits-current)))

(use-package projectile
  :after ivy
  :init
  (global-unset-key (kbd "s-p"))
  (global-set-key (kbd "s-p") 'projectile-command-map)
  :config
  (setq
   projectile-switch-project-action 'projectile-ag
   projectile-indexing-method 'native
   projectile-enable-caching t
   projectile-completion-system 'ivy)
  (projectile-mode))

(use-package xterm-color
  :config
  (setq compilation-environment '("TERM=xterm-256color"))
  (defun jschell/advice-compilation-filter (f proc string)
    (funcall f proc (xterm-color-filter string)))
  (advice-add 'compilation-filter :around #'jschell/advice-compilation-filter))

(use-package tramp
  :config
  (setq tramp-connection-timeout 10
        tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='~/.ssh/sockets/tramp.%%r@%%h:%%p' -o ControlPersist=600"
        remote-file-name-inhibit-cache nil
        vc-ignore-dir-regexp (format "%s\\|%s"
                                     vc-ignore-dir-regexp
                                     tramp-file-name-regexp))
  (add-to-list 'tramp-methods
               '("kexec"
                (tramp-login-program "kubectl")
                (tramp-login-args (("exec" "-it") ("%h") ("-c" "workbench") ("sh")))
                (tramp-remote-shell "bash")
                (tramp-remote-shell-args ("-i" "-c")))))

(use-package vterm
  :load-path  "/Users/jschell/src_ext/emacs-libvterm/"
  :custom
  (vterm-min-window-width 30)
  :init
  (setq vterm-copy-mode-map (let ((map (make-sparse-keymap)))
                         (define-key map (kbd "M-p")      #'vterm-copy-mode)
                         (define-key map [return]         #'vterm-copy-mode-done)
                         (define-key map (kbd "RET")      #'vterm-copy-mode-done)
                         (define-key map (kbd "H-c C-r")  #'vterm-reset-cursor-point)
                         (define-key map (kbd "C-a")      #'vterm-beginning-of-line)
                         (define-key map (kbd "C-e")      #'vterm-end-of-line)
                         (define-key map (kbd "H-c C-n")  #'vterm-next-prompt)
                         (define-key map (kbd "H-c C-p")  #'vterm-previous-prompt)
                         (define-key map (kbd "H-c C-f")  #'ffap)
                         map))
  (defun jschell/vterm-mode-hook ()
    ""
    (setq-local key-translation-map
                (copy-keymap key-translation-map))
    (define-key key-translation-map [?\C-c] (kbd "H-c"))
    (local-set-key (kbd "H-c") 'vterm-send-C-c)
    (when (string-match "^term" (buffer-name))
      (tab-line-mode)))
  (add-hook 'vterm-mode-hook 'jschell/vterm-mode-hook)
  (defun jschell/create-named-vterm (name)
    "Create vterm process with name NAME"
    (interactive "sVterm process name: ")
    (if (string-equal "" name)
        (vterm)
      (vterm name)))
  :config
  (setq
   vterm-mode-map (let ((map (make-sparse-keymap)))
                    (vterm--exclude-keys map '("C-x" "M-x"))
                    (define-key map (kbd "M-p")                 #'vterm-copy-mode)
                    (define-key map (kbd "M-<")                 #'vterm--self-insert)
                    (define-key map (kbd "M->")                 #'vterm--self-insert)
                    (define-key map [tab]                       #'vterm-send-tab)
                    (define-key map (kbd "TAB")                 #'vterm-send-tab)
                    (define-key map [backtab]                   #'vterm--self-insert)
                    (define-key map [backspace]                 #'vterm-send-backspace)
                    (define-key map (kbd "DEL")                 #'vterm-send-backspace)
                    (define-key map [delete]                    #'vterm-send-delete)
                    (define-key map [M-backspace]               #'vterm-send-meta-backspace)
                    (define-key map (kbd "M-DEL")               #'vterm-send-meta-backspace)
                    (define-key map [return]                    #'vterm-send-return)
                    (define-key map (kbd "RET")                 #'vterm-send-return)
                    (define-key map [left]                      #'vterm-send-left)
                    (define-key map [right]                     #'vterm-send-right)
                    (define-key map [up]                        #'vterm-send-up)
                    (define-key map [down]                      #'vterm-send-down)
                    (define-key map [prior]                     #'vterm-send-prior)
                    (define-key map [next]                      #'vterm-send-next)
                    (define-key map [home]                      #'vterm--self-insert)
                    (define-key map [end]                       #'vterm--self-insert)
                    (define-key map [escape]                    #'vterm--self-insert)
                    (define-key map (kbd "C-SPC")               #'vterm--self-insert)
                    (define-key map (kbd "S-SPC")               #'vterm-send-space)
                    (define-key map (kbd "s-v")                 #'vterm-yank)
                    (define-key map (kbd "s-c")                 #'kill-ring-save)
                    (define-key map (kbd "C--")                 #'vterm-undo)
                    (define-key map (kbd "C-_")                 #'vterm--self-insert)
                    (define-key map (kbd "M-.")                 #'vterm-send-meta-dot)
                    (define-key map (kbd "C-\\")                #'vterm-send-ctrl-slash)
                    (define-key map [remap self-insert-command]  #'vterm--self-insert)
                    (define-key map (kbd "C-x H-c")             #'save-buffers-kill-terminal)
                    map)
   vterm-max-scrollback 100000
   vterm-use-vterm-prompt-detection-method nil))

(use-package magit
  :config
  ;; TODO: Figure out why we have to do these requires manually
  ;; (require 'magit-patch)
  ;; (require 'magit-subtree)
  ;; (require 'magit-ediff)
  ;; (require 'magit-gitignore)
  ;; (require 'magit-extras)
  ;; (require 'git-rebase)
  ;; (require 'magit-imenu)
  ;; (require 'magit-bookmark)
  (setq git-commit-summary-max-length 100
        magit-branch-arguments nil
        magit-commit-arguments nil
        magit-commit-ask-to-stage t
        magit-commit-extend-override-date nil
        magit-commit-reword-override-date nil
        magit-diff-argument (quote
                             ("--ignore-space-change" "--ignore-all-space" "--no-ext-diff"))
        magit-diff-expansion-threshold 1.0
        magit-diff-refine-hunk (quote all)
        magit-diff-section-arguments (quote ("--no-ext-diff"))
        magit-popup-show-common-commands t
        magit-popup-use-prefix-argument (quote default)
        magit-process-popup-time -1
        magit-revert-buffers (quote silent)
        magit-revision-show-gravatars (quote ("^Author:     " . "^Commit:     ")))
  (local-unset-key (kbd "M-0"))
  (local-set-key (kbd "M-0") 'jschell/select-kgpw-window)
  (local-unset-key (kbd "M-1"))
  (local-set-key (kbd "M-1") 'jschell/select-main-frame)
  (local-unset-key (kbd "M-2"))
  (local-unset-key (kbd "M-3"))
  (local-set-key (kbd "M-3") 'jschell/select-terminal-frame)
  (local-unset-key (kbd "M-4"))
  (local-unset-key (kbd "M-5"))
  (local-set-key (kbd "M-5") 'jschell/select-bgdispatch-log-window)
  (local-unset-key (kbd "M-6"))
  (local-unset-key (kbd "M-7")))

(use-package ivy
  :custom-face
  (ivy-current-match ((t (:foreground nil :background "#444477"))))
  :init
  (global-unset-key (kbd "s-i"))
  (define-prefix-command 's-i-map)
  (global-set-key (kbd "s-i") 's-i-map)
  (global-set-key (kbd "s-i r") 'ivy-resume)
  :config
  (defun jschell/ivy-string-length-compare (x y)
    "Compare string lengths"
    (< (length x) (length y)))
  (add-to-list 'ivy-sort-functions-alist
               '(counsel-projectile-find-file . jschell/ivy-string-length-compare))
  (setq
   ivy-extra-directories nil
   ivy-wrap t
   ivy-use-virtual-buffers t
   ivy-count-format "%d/%d "
   ivy-re-builders-alist '((t . ivy--regex-ignore-order))
   ivy-read-action-function #'ivy-hydra-read-action))

(use-package ivy-hydra
  :after (hydra ivy))

(use-package swiper
  :ensure t
  :after ivy
  :custom
  (swiper-stay-on-quit nil)
  :custom-face
  (swiper-match-face-1 ((t (:inverse-video t))))
  (swiper-match-face-2 ((t (:inherit swiper-match-face-1))))
  (swiper-match-face-3 ((t (:inherit swiper-match-face-1))))
  (swiper-match-face-4 ((t (:inherit swiper-match-face-1))))
  (swiper-background-match-face-1 ((t (:foreground nil :background "#555555"))))
  (swiper-background-match-face-2 ((t (:inherit swiper-background-match-face-1))))
  (swiper-background-match-face-3 ((t (:inherit swiper-background-match-face-1))))
  (swiper-background-match-face-4 ((t (:inherit swiper-background-match-face-1))))
  (swiper-line-face ((t (:foreground nil :background "#444477"))))
  :bind (("C-s" . swiper-isearch)
         ("C-r" . swiper-isearch-backward)))

(use-package volatile-highlights
  :config
  (volatile-highlights-mode t)
  (run-with-idle-timer 1 t #'vhl/clear-all))

(use-package git-gutter-fringe
  :after hydra
  :hook
  (find-file . #'git-gutter-enable-unless-remote)
  :custom
  (git-gutter-fr:added-sign "+")
  (git-gutter-fr:deleted-sign "-")
  (git-gutter-fr:modified-sign "!")
  (git-gutter-fr:unchanged-sign " ")
  (git-gutter:diff-option "-w")
  (git-gutter:hide-gutter t)
  (git-gutter:visual-line t)
  :bind
  ("s-d" . hydra-git-gutter/body)
  :init
  (defun git-gutter-enable-unless-remote ()
    (unless (file-remote-p buffer-file-name)
      (git-gutter-mode +1)))
  (defhydra
    hydra-git-gutter
    (:quit-key "C-g" :pre (ignore-errors (git-gutter:popup-hunk)) :post (kill-matching-buffers-no-ask "*git-gutter:diff*"))
    "git-gutter"
    ("p" git-gutter:previous-hunk "Previous")
    ("n" git-gutter:next-hunk "Next")
    ("=" git-gutter:popup-hunk "At Cursor")
    ("e" git-gutter:end-of-hunk "End of Current")
    ("k" git-gutter:revert-hunk "Kill")
    ("m" git-gutter:mark-hunk "Mark")
    ("s" git-gutter:stage-hunk "Stage")
    ("M" git-gutter-mode "Git Gutter Mode")
    ("S" git-gutter:statistic "Stats")))

(use-package paren
  :init
  (setq show-paren-delay 0)
  :config
  (show-paren-mode +1))

(use-package cperl-mode
  :after flycheck
  :after fira-code-mode
  :mode ("/t/.*\\.t\\'" "\\.pm\\'" "\\.pl\\'")
  :interpreter ("perl")
  :custom
  (cperl-indent-level 4)
  (cperl-break-one-line-blocks-when-indent nil)
  (cperl-fix-hanging-brace-when-indent nil)
  (cperl-indent-comment-at-column-0 t)
  (cperl-indent-parens-as-block t)
  (cperl-indent-subs-specially nil)
  (cperl-tab-always-indent t)
  (cperl-close-paren-offset -4)
  (cperl-continued-statement-offset 4)
  (cperl-tab-always-indent t)
  (cperl-continued-brace-offset 4)
  (cperl-indent-wrt-brace t)
  (cperl-lineup-step t)
  (cperl-info-on-command-no-prompt t)
  (cperl-invalid-face 'default)
  (cperl-lazy-help-time 1)
  (cperl-merge-trailing-else nil)
  :init
  (add-hook 'cperl-mode-hook (lambda () (add-hook 'before-save-hook 'whitespace-cleanup 0 t))))

(use-package js2-mode
  :after flycheck
  :mode
  ("/architect.*view" "\\.js\\'")
  :config
  (add-hook 'before-save-hook 'lsp-format-buffer 0 t)
  (setq js2-mode-show-parse-errors nil
        js2-mode-show-strict-warnings nil))

(use-package js2-refactor
  :hook (js2-mode . js2-refactor-mode)
  :config
  (global-unset-key (kbd "s-f"))
  (js2r-add-keybindings-with-prefix "s-f"))

(use-package php-mode
  :mode "\\.php\\'"
  :init
  (add-hook 'php-mode-hook (lambda() (add-hook 'before-save-hook 'whitespace-cleanup 0 t))))

(use-package csharp-mode
  :mode "\\.cs\\'"
  :init
  (add-hook 'csharp-mode-hook (lambda() (add-hook 'before-save-hook 'whitespace-cleanup 0 t))))

(use-package go-mode
  :mode "\\.go\\'"
  :init
  (add-hook 'go-mode-hook (lambda()
                       (setq indent-tabs-mode t)
                       (add-hook 'before-save-hook 'lsp-format-buffer 0 t))))

(use-package markdown-mode
  :mode "\\.md\\'"
  :init
  (add-hook 'markdown-mode-hook (lambda() (setq indent-tabs-mode nil))))

(use-package yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'")
  :init
  (add-hook 'yaml-mode-hook #'highlight-indent-guides-mode))

(use-package csharp-mode
  :mode "\\.cs\\'")

(use-package counsel-projectile
  :after projectile
  :config
  (setq
   counsel-find-file-ignore-regexp nil)
  (counsel-projectile-modify-action 'counsel-projectile-switch-project-action '((default 2)))
  (counsel-projectile-mode))

(use-package dumb-jump
  :init
  (global-unset-key (kbd "s-j"))
  (define-prefix-command 's-j-map)
  (global-set-key (kbd "s-j") 's-j-map)
  (bind-key "s-j b" 'dumb-jump-back)
  (bind-key "s-j i" 'dumb-jump-go-prompt)
  (bind-key "s-j j" 'dumb-jump-go)
  (bind-key "s-j o" 'dumb-jump-go-other-window)
  (bind-key "s-j x" 'dumb-jump-go-prefer-external)
  (bind-key "s-j z" 'dumb-jump-go-prefer-external-other-window)
  :config
  (setq
   dumb-jump-selector 'ivy
   dumb-jump-default-project "~/GT/repo"
   dumb-jump-force-searcher 'rg
   dumb-jump-use-visible-window t))

(use-package which-key
  :config
  (setq which-key-idle-delay 2.0)
  (which-key-mode))

(use-package spaceline
  :after (fancy-battery vterm)
  :config
  ;; (require 'spaceline-config)
  (spaceline-define-segment buffer-line-count
    "<CURRENT_LINE>/<BUFFER_LINES> <COLUMN_NUMBER>"
    (format "%%l/%d %%c" (count-lines (point-min) (point-max))))
  (spaceline-define-segment jschell/all-the-icons-time
    "An `all-the-icons' segment to to display the time and a clock icon"
    (let* ((time (string-to-number (format-time-string "%I")))
           (time-icon (all-the-icons-wicon (format "time-%s" time) :v-adjust 0.0)))
      (propertize
       (concat
        (propertize (format-time-string "%I:%M%p ") 'face `(:height ,(spaceline-all-the-icons--height 0.9) :inherit) 'display '(raise 0.1))
        (propertize time-icon
                    'face `(:height ,(spaceline-all-the-icons--height 0.9) :family ,(all-the-icons-wicon-family) :inherit)
                    'display '(raise 0.1))
        (propertize " " 'display '(space . (:width 1))))
       'help-echo (format-time-string "%c")
       'mouse-face (spaceline-all-the-icons--highlight)))
    :enabled t)
  (spaceline-define-segment jschell/all-the-icons-region-info
    "An `all-the-icons' indicator of the currently highlighted region"
    (let ((lines (count-lines (region-beginning) (region-end)))
          (words (count-words (region-beginning) (region-end)))
          (characters (- (region-end) (region-beginning)))

          (height (if spaceline-all-the-icons-slim-render 0.9 0.8))
          (display (if spaceline-all-the-icons-slim-render 0.1 0.2))
          (region-format (if spaceline-all-the-icons-slim-render "%s:%s:%s" "(%s, %s, %s)")))
      (concat
       (propertize (format "%s " (all-the-icons-octicon "pencil" :v-adjust 0.1))
                   'face `(:family ,(all-the-icons-octicon-family) :inherit))
       (propertize (format region-format lines words characters)
                   'face `(:height ,height :inherit)
                   'display `(raise ,display))))
    :when mark-active :tight t)
  (spaceline-define-segment jschell/vterm-copy-mode
    "Indicate vterm copy mode in modeline"
    (when vterm-copy-mode
        "VCM"))
  (setq
   spaceline-byte-compile nil
   anzu-cons-mode-line-p nil
   powerline-height 18
   powerline-default-separator "rounded"
   spaceline-separator-dir-left '(left . left)
   spaceline-separator-dir-right '(right . right)
   spaceline-highlight-face-func 'spaceline-highlight-face-modified
   spaceline-all-the-icons-icon-set-modified 'circle
   spaceline-all-the-icons-slim-render t
   ring-bell-function `(lambda ()
                         (invert-face 'mode-line)
                         (run-with-timer 0.01 nil 'invert-face 'mode-line)
                         (invert-face 'powerline-active1)
                         (run-with-timer 0.01 nil 'invert-face 'powerline-active1)
                         (invert-face 'powerline-active2)
                         (run-with-timer 0.01 nil 'invert-face 'powerline-active2)
                         (invert-face 'spaceline-modified)
                         (run-with-timer 0.01 nil 'invert-face 'spaceline-modified)
                         (invert-face 'spaceline-read-only)
                         (run-with-timer 0.01 nil 'invert-face 'spaceline-read-only)
                         (invert-face 'spaceline-unmodified)
                         (run-with-timer 0.01 nil 'invert-face 'spaceline-unmodified)))
  (spaceline-compile "jschell-mode"
    '((("" all-the-icons-modified "")
       :tight t
       :skip-alternate t
       :priority 98
       :face highlight-face
       :priority 100)
      (buffer-line-count :tight nil :when active :priority 98)
      ((all-the-icons-mode-icon buffer-id) :tight nil :priority 99)
      ((remote-host projectile-root) :tight nil :priority 97)
      ((all-the-icons-vc-status
        all-the-icons-git-status) :tight nil :priority 91)
      (jschell/all-the-icons-region-info :tight nil :skip-alternate t :when mark-active :priority 96)
      (jschell/vterm-copy-mode :skip-alternate t))
    '(((flycheck-info flycheck-warning flycheck-error) :tight nil :skip-alternate t :when active :priority 95)
      (all-the-icons-battery-status :tight nil :when active :priority 92)
      (jschell/all-the-icons-time :tight nil :priority 93)))
  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-jschell-mode))))
  :custom-face
  (mode-line ((t (:height 110 :background "#444477"))))
  (mode-line-inactive ((t (:foreground "#bbbbbb" :background "#444444"))))
  (powerline-active1 ((t (:background "#666699"))))
  (powerline-active2 ((t (:background "#222222"))))
  (powerline-inactive1 ((t (:foreground "#bbbbbb" :background "#666666"))))
  (powerline-inactive2 ((t (:foreground "#bbbbbb" :background "#333333"))))
  (spaceline-modified ((t (:foreground "#000000" :background "#ccaa33"))))
  (spaceline-read-only ((t (:foreground "#000000" :background "#dd0101"))))
  (spaceline-unmodified ((t (:foreground "#000000" :background "#8888bb"))))
  (spaceline-flycheck-error ((t (:foreground "#ff0000" :weight bold))))
  (spaceline-flycheck-warning ((t (:foreground "#ffff00" :weight bold))))
  (spaceline-flycheck-info ((t (:foreground "#0000ff")))))

(use-package spaceline-all-the-icons
  :after spaceline)

(use-package fancy-battery
  :custom
  (fancy-battery-mode-line "")
  :config
  (fancy-battery-mode))

(use-package column-enforce-mode
  :init
  (setq column-enforce-column 101)
  :config
  (global-column-enforce-mode)
  :custom-face
  (column-enforce-face ((t (:background "#333333")))))

(use-package persistent-scratch
  :config
  (persistent-scratch-setup-default))

(use-package company
  :custom-face
  (company-tooltip ((t (:inherit default :background "#26262F"))))
  (company-tooltip-annotation ((t (:inherit company-tooltip :foreground "#AAAAAA"))))
  (company-tooltip-annotation-selection ((t (:inherit company-tooltip-annotation :background "#444477"))))
  (company-tooltip-common ((t (:inherit company-tooltip :foreground "#AAAAFF"))))
  (company-tooltip-common-selection ((t (:inherit company-tooltip-common :background "#444477"))))
  (company-tooltip-selection ((t (:inherit default :background "#444477"))))
  (company-tooltip-search ((t (:inherit default :foreground "#CCCCCC"))))
  (company-tooltip-search-selection ((t (:inherit default :foreground "#00FF00"))))
  (company-scrollbar-fg ((t (:inherit default :background "#222255"))))
  (company-scrollbar-bg ((t (:inherit default :background "#111144"))))
  :custom
  (company-show-numbers nil)
  (company-tooltip-flip-when-above t)
  (company-idle-delay 0)
  (company-tooltip-align-annotations t)
  (company-selection-wrap-around t)
  (company-minimum-prefix-length 1)
  (company-dabbrev-downcase nil)
  :init
  (global-unset-key (kbd "s-c"))
  (define-prefix-command 's-c-map)
  (global-set-key (kbd "s-c") 's-c-map)
  (global-set-key (kbd "s-c c") 'company-manual-begin)
  :config
  ;; (defun jschell/company-tooltip-frontend-unless-just-one-manual-frontend (command)
  ;;   "Only display tooltip if manually requested"
  ;;   (when company--manual-action
  ;;     (company-pseudo-tooltip-unless-just-one-frontend command)))
  ;; (setq company-frontends
  ;;       '(jschell/company-tooltip-frontend-unless-just-one-manual-frontend
  ;;         company-preview-if-just-one-frontend
  ;;         company-echo-metadata-frontend))
  ;; TODO: this should go in keys.el, but doesn't work with lazy loading and eval-after-load
  ;; (define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
  ;; (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
  ;; (require 'company-ispell)
  (define-key company-active-map (kbd "M-'") 'company-complete-selection))

(use-package company-box
  :custom-face
  (company-box-candidate ((t (:inherit default)))))

(use-package all-the-icons)

(use-package all-the-icons-ivy-rich
  :config
  (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :custom
  (ivy-rich-display-transformers-list
   '(ivy-switch-buffer
     (:columns
      ((all-the-icons-ivy-rich-buffer-icon)
       (ivy-rich-candidate
        (:width 50))
       (ivy-rich-switch-buffer-size
        (:width 7))
       (ivy-rich-switch-buffer-indicators
        (:width 4 :face error :align right))
       (ivy-rich-switch-buffer-major-mode
        (:width 12 :face warning))
       (ivy-rich-switch-buffer-project
        (:width 15 :face success))
       (ivy-rich-switch-buffer-path
        (:width
         (lambda
           (x)
           (ivy-rich-switch-buffer-shorten-path x
                                                (ivy-rich-minibuffer-width 0.3))))))
      :predicate
      (lambda
        (cand)
        (get-buffer cand))
      :delimiter "	")
     ivy-switch-buffer-other-window
     (:columns
      ((all-the-icons-ivy-rich-buffer-icon)
       (ivy-rich-candidate
        (:width 50))
       (ivy-rich-switch-buffer-size
        (:width 7))
       (ivy-rich-switch-buffer-indicators
        (:width 4 :face error :align right))
       (ivy-rich-switch-buffer-major-mode
        (:width 12 :face warning))
       (ivy-rich-switch-buffer-project
        (:width 15 :face success))
       (ivy-rich-switch-buffer-path
        (:width
         (lambda
           (x)
           (ivy-rich-switch-buffer-shorten-path x
                                                (ivy-rich-minibuffer-width 0.3))))))
      :predicate
      (lambda
        (cand)
        (get-buffer cand))
      :delimiter "	")
     counsel-switch-buffer
     (:columns
      ((all-the-icons-ivy-rich-buffer-icon)
       (ivy-rich-candidate
        (:width 30))
       (ivy-rich-switch-buffer-size
        (:width 7))
       (ivy-rich-switch-buffer-indicators
        (:width 4 :face error :align right))
       (ivy-rich-switch-buffer-major-mode
        (:width 12 :face warning))
       (ivy-rich-switch-buffer-project
        (:width 15 :face success))
       (ivy-rich-switch-buffer-path
        (:width
         (lambda
           (x)
           (ivy-rich-switch-buffer-shorten-path x
                                                (ivy-rich-minibuffer-width 0.3))))))
      :predicate
      (lambda
        (cand)
        (get-buffer cand))
      :delimiter "	")
     counsel-switch-buffer-other-window
     (:columns
      ((all-the-icons-ivy-rich-buffer-icon)
       (ivy-rich-candidate
        (:width 30))
       (ivy-rich-switch-buffer-size
        (:width 7))
       (ivy-rich-switch-buffer-indicators
        (:width 4 :face error :align right))
       (ivy-rich-switch-buffer-major-mode
        (:width 12 :face warning))
       (ivy-rich-switch-buffer-project
        (:width 15 :face success))
       (ivy-rich-switch-buffer-path
        (:width
         (lambda
           (x)
           (ivy-rich-switch-buffer-shorten-path x
                                                (ivy-rich-minibuffer-width 0.3))))))
      :predicate
      (lambda
        (cand)
        (get-buffer cand))
      :delimiter "	")
     persp-switch-to-buffer
     (:columns
      ((all-the-icons-ivy-rich-buffer-icon)
       (ivy-rich-candidate
        (:width 30))
       (ivy-rich-switch-buffer-size
        (:width 7))
       (ivy-rich-switch-buffer-indicators
        (:width 4 :face error :align right))
       (ivy-rich-switch-buffer-major-mode
        (:width 12 :face warning))
       (ivy-rich-switch-buffer-project
        (:width 15 :face success))
       (ivy-rich-switch-buffer-path
        (:width
         (lambda
           (x)
           (ivy-rich-switch-buffer-shorten-path x
                                                (ivy-rich-minibuffer-width 0.3))))))
      :predicate
      (lambda
        (cand)
        (get-buffer cand))
      :delimiter "	")
     counsel-M-x
     (:columns
      ((all-the-icons-ivy-rich-function-icon)
       (counsel-M-x-transformer
        (:width 40))
       (ivy-rich-counsel-function-docstring
        (:face font-lock-doc-face))))
     counsel-describe-function
     (:columns
      ((all-the-icons-ivy-rich-function-icon)
       (counsel-describe-function-transformer
        (:width 40))
       (ivy-rich-counsel-function-docstring
        (:face font-lock-doc-face))))
     counsel-describe-variable
     (:columns
      ((all-the-icons-ivy-rich-variable-icon)
       (counsel-describe-variable-transformer
        (:width 40))
       (ivy-rich-counsel-variable-docstring
        (:face font-lock-doc-face))))
     counsel-set-variable
     (:columns
      ((all-the-icons-ivy-rich-variable-icon)
       (counsel-describe-variable-transformer
        (:width 40))
       (ivy-rich-counsel-variable-docstring
        (:face font-lock-doc-face))))
     counsel-apropos
     (:columns
      ((all-the-icons-ivy-rich-symbol-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-info-lookup-symbol
     (:columns
      ((all-the-icons-ivy-rich-symbol-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-descbinds
     (:columns
      ((all-the-icons-ivy-rich-keybinding-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-find-file
     (:columns
      ((all-the-icons-ivy-rich-file-icon)
       (ivy-read-file-transformer))
      :delimiter "	")
     counsel-file-jump
     (:columns
      ((all-the-icons-ivy-rich-file-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-dired
     (:columns
      ((all-the-icons-ivy-rich-file-icon)
       (ivy-read-file-transformer))
      :delimiter "	")
     counsel-dired-jump
     (:columns
      ((all-the-icons-ivy-rich-file-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-el
     (:columns
      ((all-the-icons-ivy-rich-symbol-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-fzf
     (:columns
      ((all-the-icons-ivy-rich-file-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-git
     (:columns
      ((all-the-icons-ivy-rich-file-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-recentf
     (:columns
      ((all-the-icons-ivy-rich-file-icon)
       (ivy-rich-candidate
        (:width 0.8))
       (ivy-rich-file-last-modified-time
        (:face font-lock-comment-face)))
      :delimiter "	")
     counsel-buffer-or-recentf
     (:columns
      ((all-the-icons-ivy-rich-file-icon)
       (counsel-buffer-or-recentf-transformer
        (:width 0.8))
       (ivy-rich-file-last-modified-time
        (:face font-lock-comment-face)))
      :delimiter "	")
     counsel-bookmark
     (:columns
      ((all-the-icons-ivy-rich-bookmark-type)
       (all-the-icons-ivy-rich-bookmark-name
        (:width 40))
       (all-the-icons-ivy-rich-bookmark-info))
      :delimiter "	")
     counsel-bookmarked-directory
     (:columns
      ((all-the-icons-ivy-rich-file-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-package
     (:columns
      ((all-the-icons-ivy-rich-package-icon)
       (ivy-rich-candidate
        (:width 30))
       (all-the-icons-ivy-rich-package-version
        (:width 16 :face font-lock-comment-face))
       (all-the-icons-ivy-rich-package-archive-summary
        (:width 7 :face font-lock-builtin-face))
       (all-the-icons-ivy-rich-package-install-summary
        (:face font-lock-doc-face)))
      :delimiter "	")
     counsel-fonts
     (:columns
      ((all-the-icons-ivy-rich-font-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-major
     (:columns
      ((all-the-icons-ivy-rich-function-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-find-library
     (:columns
      ((all-the-icons-ivy-rich-library-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-load-library
     (:columns
      ((all-the-icons-ivy-rich-library-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-load-theme
     (:columns
      ((all-the-icons-ivy-rich-theme-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-world-clock
     (:columns
      ((all-the-icons-ivy-rich-world-clock-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-tramp
     (:columns
      ((all-the-icons-ivy-rich-tramp-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-git-checkout
     (:columns
      ((all-the-icons-ivy-rich-git-branch-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-list-processes
     (:columns
      ((all-the-icons-ivy-rich-process-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-projectile-switch-project
     (:columns
      ((all-the-icons-ivy-rich-file-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-projectile-find-file
     (:columns
      ((all-the-icons-ivy-rich-file-icon)
       (counsel-projectile-find-file-transformer))
      :delimiter "	")
     counsel-projectile-find-dir
     (:columns
      ((all-the-icons-ivy-rich-project-icon)
       (counsel-projectile-find-dir-transformer))
      :delimiter "	")
     counsel-minor
     (:columns
      ((all-the-icons-ivy-rich-mode-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     counsel-imenu
     (:columns
      ((all-the-icons-ivy-rich-imenu-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     package-install
     (:columns
      ((all-the-icons-ivy-rich-package-icon)
       (ivy-rich-candidate
        (:width 30))
       (ivy-rich-package-version
        (:width 16 :face font-lock-comment-face))
       (ivy-rich-package-archive-summary
        (:width 7 :face font-lock-builtin-face))
       (ivy-rich-package-install-summary
        (:face font-lock-doc-face)))
      :delimiter "	")
     package-reinstall
     (:columns
      ((all-the-icons-ivy-rich-package-icon)
       (ivy-rich-candidate
        (:width 30))
       (ivy-rich-package-version
        (:width 16 :face font-lock-comment-face))
       (ivy-rich-package-archive-summary
        (:width 7 :face font-lock-builtin-face))
       (ivy-rich-package-install-summary
        (:face font-lock-doc-face)))
      :delimiter "	")
     package-delete
     (:columns
      ((all-the-icons-ivy-rich-package-icon)
       (ivy-rich-candidate))
      :delimiter "	")
     treemacs-projectile
     (:columns
      ((all-the-icons-ivy-rich-file-icon)
       (ivy-rich-candidate))
      :delimiter "	"))
   Original value was
   (ivy-switch-buffer
    (:columns
     ((ivy-switch-buffer-transformer
       (:width 30))
      (ivy-rich-switch-buffer-size
       (:width 7))
      (ivy-rich-switch-buffer-indicators
       (:width 4 :face error :align right))
      (ivy-rich-switch-buffer-major-mode
       (:width 12 :face warning))
      (ivy-rich-switch-buffer-project
       (:width 15 :face success))
      (ivy-rich-switch-buffer-path
       (:width
        (lambda
          (x)
          (ivy-rich-switch-buffer-shorten-path x
                                               (ivy-rich-minibuffer-width 0.3))))))
     :predicate
     (lambda
       (cand)
       (get-buffer cand)))
    counsel-find-file
    (:columns
     ((ivy-read-file-transformer)
      (ivy-rich-counsel-find-file-truename
       (:face font-lock-doc-face))))
    counsel-M-x
    (:columns
     ((counsel-M-x-transformer
       (:width 40))
      (ivy-rich-counsel-function-docstring
       (:face font-lock-doc-face))))
    counsel-describe-function
    (:columns
     ((counsel-describe-function-transformer
       (:width 40))
      (ivy-rich-counsel-function-docstring
       (:face font-lock-doc-face))))
    counsel-describe-variable
    (:columns
     ((counsel-describe-variable-transformer
       (:width 40))
      (ivy-rich-counsel-variable-docstring
       (:face font-lock-doc-face))))
    counsel-recentf
    (:columns
     ((ivy-rich-candidate
       (:width 0.8))
      (ivy-rich-file-last-modified-time
       (:face font-lock-comment-face))))
    package-install
    (:columns
     ((ivy-rich-candidate
       (:width 30))
      (ivy-rich-package-version
       (:width 16 :face font-lock-comment-face))
      (ivy-rich-package-archive-summary
       (:width 7 :face font-lock-builtin-face))
      (ivy-rich-package-install-summary
       (:face font-lock-doc-face))))))
  :config
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
  (ivy-rich-mode 1))

(use-package lsp-mode
  :hook ((lsp-mode . lsp-enable-which-key-integration)
         (js2-mode . lsp-mode)
         (go-mode . lsp-mode))
  :commands lsp lsp-deferred
  :config
  (setq
   gc-cons-threshold 1600000
   read-process-output-max (* 1024 1024))
  (add-to-list 'lsp-language-id-configuration '(cperl-mode . "perl"))
  :custom
  (lsp-keymap-prefix "s-l")
  (lsp-auto-guess-root nil)
  (lsp-enable-semantic-highlighting nil)
  (lsp-semantic-highlighting-warn-on-missing-face nil)
  (lsp-semantic-tokens-apply-modifiers nil)
  (lsp-document-sync-method nil)
  (lsp-eldoc-enable-hover t)
  (lsp-log-io nil)
  (lsp-eldoc-render-all nil)
  (lsp-eslint-server-command '("node" "/Users/jschell/src/env-conf/.emacs.d/.extension/vscode/eslint/extension/server/out/eslintServer.js" "--stdio"))
  (lsp-enable-on-type-formatting nil)
  (lsp-prefer-capf t)
  (lsp-keep-workspace-alive nil)
  (lsp-enable-xref t)
  (lsp-enable-completion-at-point t)
  (lsp-enable-on-type-formatting t)
  (lsp-before-save-edits t)
  (lsp-enable-dap-auto-configure nil))

(use-package lsp-ivy)

(use-package dap-mode
  :after hydra
  :hook ((go-mode . dap-mode)
         (dap-stopped . (lambda (arg) (call-interactively #'dap-hydra))))
  :bind
  ("s-g" . hydra-dap/body)
  :init
  (defhydra
    hydra-dap
    (:quit-key "C-g")
    "DAP"
    ("t" dap-breakpoint-toggle "Toggle Breakpoint at Line")
    ("a" dap-breakpoint-add "Toggle Breakpoint at Line")
    ("d" dap-breakpoint-delete "Toggle Breakpoint at Line")
    ("b" dap-ui-breakpoints-list "List Breakpoints")
    ("r" dap-debug-recent "Recent Sessions")
    ("l" dap-debug-last "Last Session")
    ("n" dap-debug "New Session"))
  :config
  (setq
   dap-print-io t
   dap-auto-configure-features '(sessions locals controls tooltip))
  ;; (require 'dap-ui)
  (dap-ui-mode))

;; (use-package dap-hydra
;;   :after dap-mode)

(use-package pkg-info)

;; (use-package yasnippet
;;   :custom
;;   (yas-snippet-dirs '("~/.emacs.d/snippets"))
;;   :hook (after-init . yas-global-mode))

(use-package flycheck
  :after (hydra pkg-info)
  :hook ((cperl-mode . flycheck-mode)
         (js2-mode . flycheck-mode)
         (php-mode . flycheck-mode))
  :custom
  (global-flycheck-mode nil)
  (flycheck-check-syntax-automatically '(save idle-change mode-enabled))
  (flycheck-idle-change-delay 5)
  :custom-face
  (flycheck-error ((t (:background "#552255" :box (:line-width -1 :color "#662266")))))
  (flycheck-warning ((t (:background "#222255" :box (:line-width -1 :color "#222266")))))
  (flycheck-info ((t (:background "#333333" :box (:line-width -1 :color "#444444")))))
  (flycheck-fringe-error ((t (:foreground "#FF00FF" :background "#FF00FF"))))
  (flycheck-fringe-warning ((t (:foreground "#0000FF" :background "#0000FF"))))
  (flycheck-fringe-info ((t (:foreground "#AAAAAA" :background "#AAAAAA"))))
  :init
  (defhydra
    hydra-flycheck
    (:quit-key "C-g")
    "Flycheck"
    ("f" flycheck-first-error "First Error")
    ("p" flycheck-previous-error "Previous Error")
    ("n" flycheck-next-error "Next Error")
    ("b" flycheck-buffer "Check Buffer")
    ("c" flycheck-compile "Compile Buffer")
    ("l" counsel-flycheck "List Errors"))
  :bind
  ("s-e" . hydra-flycheck/body)
  :config
  (setq-default flycheck-perl-include-path '("/Users/jschell/gtperl" "/Users/jschell/gtperl/external_deps/lib/perl5")))

(use-package eldoc
  :config
  (global-eldoc-mode))

(defun jschell/eslint-before-save-hook ()
  (interactive)
  (let* ((this-buffer (current-buffer))
         (this-buffer-file (buffer-file-name))
         (my-command "eslint")
         (temp-results-buffer (generate-new-buffer "*eslint-fmt*"))
         (temp-output-file
          (s-concat
           (make-temp-name (file-name-sans-extension this-buffer-file))
           "-eslint-fmt."
           (file-name-extension this-buffer-file)))
         (temp-stderr-file (make-temp-file "eslint-fmt" nil ".stderr"))
         (default-process-coding-system '(utf-8-unix . utf-8-unix)))
    (with-current-buffer this-buffer
      (let ((this-buffer-content (buffer-substring-no-properties (point-min) (point-max))))
        (with-temp-file temp-output-file
          (insert this-buffer-content))))
    (condition-case err
        (unwind-protect
            (let ((status
                   (progn
                     (apply
                      #'call-process-region nil nil my-command nil
                      `(,temp-results-buffer ,temp-stderr-file) nil
                      `("--fix" ,temp-output-file))))
                  (stdout
                   (with-current-buffer temp-results-buffer
                     (buffer-substring-no-properties (point-min) (point-max))))
                  (stderr
                   (with-temp-buffer
                     (unless (zerop (cadr (insert-file-contents temp-stderr-file)))
                       (insert ": "))
                     (buffer-substring-no-properties
                      (point-min) (point-max)))))
              (when (stringp status)
                (message "eslint-fmt status: %s" status))
              (when (stringp stdout)
                (message "eslint-fmt stderr: %s" stderr))
              (when (stringp stdout)
                (message "eslint-fmt stdout: %s" stdout))
              (when (zerop status)
                ;; Include the stdout as a message,
                ;; useful to check on how the program runs.
                (with-temp-buffer
                  (insert-file-contents temp-output-file)
                  (let ((output-content (buffer-substring-no-properties (point-min) (point-max)))
                        (temp-buffer (current-buffer)))
                    (with-current-buffer this-buffer
                      (replace-buffer-contents temp-buffer)))))))
      (error (message "%s" (error-message-string err))))
    (delete-file temp-output-file)
    (delete-file temp-stderr-file)
    (when (buffer-name temp-results-buffer)
      (kill-buffer temp-results-buffer))))



;; (use-package tide
;;   :after (js2-mode)
;;   :hook
;;   (js2-mode . tide-setup)
;;   (js2-mode . tide-hl-identifier-mode)
;;   (js2-mode . company-mode)
;;   (js2-mode . jschell/add-eslint-before-save-hook)
;;   :config
;;   (defun jschell/eslint-before-save-hook ()
;;     (interactive)
;;     (let* ((this-buffer (current-buffer))
;;           (this-buffer-file (buffer-file-name))
;;           (my-command "eslint")
;;           (temp-results-buffer (generate-new-buffer "*eslint-fmt*"))
;;           (temp-output-file
;;            ;; TODO: this needs to create the temporary file in the current-buffer dir
;;            (make-temp-file
;;             (s-concat "eslint-fmt-" (file-name-base this-buffer-file))
;;             nil
;;             (file-name-extension this-buffer-file)))
;;           (temp-stderr-file (make-temp-file "eslint-fmt" nil ".stderr"))
;;           ;; Always use 'utf-8-unix' & ignore the buffer coding system.
;;           (default-process-coding-system '(utf-8-unix . utf-8-unix)))
;;       (with-current-buffer this-buffer
;;         (let ((this-buffer-content (buffer-substring-no-properties (point-min) (point-max))))
;;           (with-temp-file temp-output-file
;;             (insert this-buffer-content))))
;;       (condition-case err
;;           (unwind-protect
;;               (let ((status
;;                      (progn
;;                        (apply
;;                         #'call-process-region nil nil my-command nil
;;                         `(,temp-results-buffer ,temp-stderr-file) nil
;;                         `("--fix" "--debug" ,temp-output-file))))
;;                     (stdout
;;                      (with-current-buffer temp-results-buffer
;;                        (buffer-substring-no-properties (point-min) (point-max))))
;;                     (stderr
;;                      (with-temp-buffer
;;                        (unless (zerop (cadr (insert-file-contents temp-stderr-file)))
;;                          (insert ": "))
;;                        (buffer-substring-no-properties
;;                         (point-min) (point-max)))))
;;                 (cond
;;                  ((stringp status)
;;                   (error "(eslint-fmt killed by signal %s%s%s)" status stdout stderr))
;;                  ((not (zerop status))
;;                   (error "(eslint-fmt failed with code %d%s%s)" status stdout stderr))
;;                  (t
;;                   ;; Include the stdout as a message,
;;                   ;; useful to check on how the program runs.
;;                   (when (stringp stdout)
;;                     (message "%s" stdout))
;;                   (with-temp-buffer
;;                     (insert-file-contents temp-output-file)
;;                     (let ((output-content (buffer-substring-no-properties (point-min) (point-max)))
;;                           (temp-buffer (current-buffer)))
;;                       (with-current-buffer this-buffer
;;                         (replace-buffer-contents temp-buffer))))))))
;;         (error (message "%s" (error-message-string err))))
;;       (delete-file temp-output-file)
;;       (delete-file temp-stderr-file)
;;       (when (buffer-name temp-results-buffer)
;;         (kill-buffer temp-results-buffer))))
;;   (defun jschell/add-eslint-before-save-hook ()
;;      (add-hook 'before-save-hook 'jschell/eslint-before-save-hook 0 t))
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled)
;;         flycheck-javascript-standard-executable "semistandard"
;;         js2-basic-offset 4
;;         tide-default-mode "JS"))

;; (use-package highlight-symbol
;;   :hook (prog-mode . highlight-symbol-mode)
;;   :custom
;;   (highlight-symbol-idle-delay 0.3))

(use-package fira-code
  :load-path "~/.emacs.d/lisp"
  ;; :hook ((emacs-lisp-mode . fira-code-mode)
  ;;        (lisp-mode . fira-code-mode)
  ;;        (js2-mode . fira-code-mode)
  ;;        (php-mode . fira-code-mode)
  ;;        (csharp-mode . fira-code-mode)
  ;;        (go-mode . fira-code-mode)
  ;;        (markdown-mode . fira-code-mode))
  :hook (prog-mode . fira-code-mode))

(use-package json-mode
  :mode ("\\.json\\'"))

(use-package highlight-indent-guides)

(use-package xml-format)

(defun jschell/setup-desktop ()
  "Startup routine to setup desired windows and frames"
  (interactive)
  (if (one-window-p t t)
      (progn
        (set-frame-name "main")
        (split-window-horizontally)
        (let ((terminal-frame (make-frame '((name . "terminal")))))
          (select-frame terminal-frame)
          (vterm "term1: db")
          (tab-line-mode)
          (vterm-send-string "kubectl attach -it workbench-jschell -c workbench\n")
          (vterm "term2: wb")
          (tab-line-mode)
          (vterm-send-string "kubectl attach -it workbench-jschell -c bgworker-perl\n")
          (vterm "term3: staging")
          (tab-line-mode)
          (vterm-send-string "cd ~/src_staging\n")
          (vterm "term4: ops")
          (tab-line-mode)
          (vterm-send-string "cd ~/src_staging/prod-deploy/charts/release/ops\n")
          (vterm "term5")
          (tab-line-mode)
          (vterm-send-string "cd\n")
          (tab-line-mode))
        (let ((static-frame (make-frame '((name . "static")))))
          (select-frame static-frame)
          (vterm "kgpw")
          (jschell/toggle-window-dedicated)
          (vterm-send-string "~/src/env-conf/kgpw.pl -i 5\n")
          (let ((new-window-1 (split-window-horizontally 40)))
            (select-window new-window-1)
            (let ((new-window-2 (split-window-vertically 54)))
              (select-window new-window-2)
              (vterm "bgdispatch-log")
              (jschell/toggle-window-dedicated)
              (vterm-send-string "ktail -l app=bgdispatch --timestamps --since-start | grep -v '\\-\\-closed connection\\-\\-'\n"))
            (select-window new-window-1)
              (xwidget-webkit-browse-url "https://app.datadoghq.com/dashboard/e4p-tyf-khi/ops"))))
    (message "Multiple windows already exist; not setting up desktop")))

;; (use-package minibuffer-line
;;   :demand t
;;   :hook
;;   (after-init . #'jschell/minibuffer-line-config)
;;   :init
;;   (defun jschell/minibuffer-line-justify-right (text)
;;     "Return a string of `window-width' length with TEXT right-aligned."
;;     (with-selected-window (minibuffer-window)
;;       (format (format "%%%ds" (1- (window-width)))
;;               text)))
;;   (defun jschell/minibuffer-line-config ()
;;     "Require and configure the `minibuffer-line' library."
;;     (when (require 'minibuffer-line nil :noerror)
;;       (setq minibuffer-line-refresh-interval 5
;;             minibuffer-line-format
;;             '((:eval (format-mode-line global-mode-string))))
;;       (set-face-attribute 'minibuffer-line nil :inherit 'default)
;;       (minibuffer-line-mode 1))))

(use-package command-log-mode)
