;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(setq load-prefer-newer t)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;; Emacs 26.2 bug workaround
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(unless (package-installed-p 'auto-compile)
  (package-refresh-contents)
  (package-install 'auto-compile))

(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/lisp")
(setq custom-theme-load-path
      (append '( "~/.emacs.d/themes" ) custom-theme-load-path))

(if (memq window-system '(mac ns))
    (progn
      (use-package exec-path-from-shell
        :config
        (exec-path-from-shell-initialize)
        (exec-path-from-shell-copy-env "SSH_AGENT_PID")
        (exec-path-from-shell-copy-env "SSH_AUTH_SOCK"))
      (set-scroll-bar-mode nil)
      (load-theme 'schellj-gui t)
      (fringe-mode '(2 . 0)))
  (load-theme 'schellj-terminal t))

(require 'gt-perl)
(defalias 'perl-mode 'cperl-mode)

(load-library "keys.el")
(load-library "functions.el")

;;; backup/autosave
(defvar backup-dir (expand-file-name "~/.emacs.d/backup"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave"))
(setq backup-directory-alist (list (cons ".*" backup-dir))
      auto-save-list-file-prefix autosave-dir
      auto-save-file-name-transforms `((".*" ,autosave-dir t))
      create-lockfiles nil)

(use-package emacs
  :config
  (setq-default indent-tabs-mode nil)
  (setq tab-bar-show 1
        tab-bar-position t
        window-divider-default-right-width 1
        window-divider-default-bottom-width 1
        debug-on-error nil
        perl-indent-parens-as-block t
        pcomplete-ignore-case t
        vc-git-diff-switches "-b"
        vc-diff-switches "-b"

        c-basic-offset 4
        c-subword-mode t
        case-fold-search t
        case-replace t
        comint-prompt-read-only nil
        comint-scroll-to-bottom-on-input t
        complete-ignore-case t
        completion-ignore-case t
        completions-format '(vertical)

        read-buffer-completion-ignore-case t
        read-file-name-completion-ignore-case t
        show-trailing-whitespace nil
        tab-width 4
        transient-mark-mode t
        truncate-partial-width-windows nil
        visible-bell nil
        flymake-perl-lib-dir "/Users/schellj/gtperl"
        vc-make-backup-files t
        backup-by-copying t
        delete-old-versions t
        kept-new-versions 10
        kept-old-versions 0
        version-control t
        shr-color-visible-luminance-min 90
        vc-follow-symlinks nil)
  (global-font-lock-mode t)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (desktop-save-mode +1)
  (window-divider-mode +1)
  (tab-bar-mode +1)
  (set-display-table-slot standard-display-table 'wrap ?·))

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t
        auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package default-text-scale
  :config
  (default-text-scale-mode))

(use-package smerge-mode
  :after hydra
  :config
  (add-hook 'find-file-hook 'smerge-try-smerge)
  (add-hook 'after-revert-hook 'smerge-try-smerge)
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
    ("l" smerge-keep-lower "Keep Lower")))

(use-package ffap
  :config
  (add-to-list 'ffap-alist '(shell-mode . ffap-gits-src))
  (add-to-list 'ffap-alist '(shell-mode . ffap-gits-current))
  (add-to-list 'ffap-alist '(term-mode . ffap-gits-src))
  (add-to-list 'ffap-alist '(term-mode . ffap-gits-current)))

(use-package projectile
  :after ivy
  :config
  (setq
   projectile-indexing-method 'native
   projectile-enable-caching t
   projectile-completion-system 'ivy)
  (projectile-mode))

(use-package xterm-color
  :config
  (progn (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
       (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))))

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

(use-package magit
  :config
  ;; TODO: Figure out why we have to do these requires manually
  (require 'magit-patch)
  (require 'magit-subtree)
  (require 'magit-ediff)
  (require 'magit-gitignore)
  (require 'magit-extras)
  (require 'git-rebase)
  (require 'magit-imenu)
  (require 'magit-bookmark)
  (setq magit-branch-arguments nil
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
        magit-revision-show-gravatars (quote ("^Author:     " . "^Commit:     "))))

(use-package ivy
  :config
  (setq
   ivy-extra-directories nil
   ivy-wrap t
   ivy-use-virtual-buffers t
   ivy-count-format "(%d/%d) "
   ivy-re-builders-alist '((t . ivy--regex-ignore-order))
   ivy-read-action-function #'ivy-hydra-read-action))

(use-package ivy-hydra
  :after ivy)

(use-package beacon
  :config
  (beacon-mode 1)
  (setq
   beacon-blink-when-focused t
   beacon-blink-when-window-scrolls nil
   beacon-color "#555555"
   beacon-mode t
   beacon-size 15))

(use-package volatile-highlights
  :config
  (volatile-highlights-mode t)
  (run-with-idle-timer 1 t #'vhl/clear-all))

(use-package rainbow-delimiters
  :config
  (setq rainbow-delimiters-max-face-count 6)
  :custom-face
  '(rainbow-delimiters-base-face ((t (:inherit default))))
  '(rainbow-delimiters-depth-1-face ((t (:inherit rainbow-delimiters-base-face :background "#ccf8f8"))))
  '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :background "#f8aaf8"))))
  '(rainbow-delimiters-depth-3-face ((t (:inherit rainbow-delimiters-base-face :background "#f8f8cc"))))
  '(rainbow-delimiters-depth-4-face ((t (:inherit rainbow-delimiters-base-face :background "#aaf8f8"))))
  '(rainbow-delimiters-depth-5-face ((t (:inherit rainbow-delimiters-base-face :background "#f8ccf8"))))
  '(rainbow-delimiters-depth-6-face ((t (:inherit rainbow-delimiters-base-face :background "#f8f8aa"))))
  :hook
  ((cperl-mode emacs-lisp-mode js2-mode js-mode) . rainbow-delimiters-mode))

(use-package hydra)

(use-package git-gutter
  :after hydra
  :config
  (setq
   git-gutter-fr:added-sign "+"
   git-gutter-fr:deleted-sign "-"
   git-gutter-fr:diff-option "-w"
   git-gutter-fr:hide-gutter t
   git-gutter-fr:modified-sign "!"
   git-gutter-fr:unchanged-sign " "
   git-gutter-fr:visual-line t
   git-gutter:added-sign "+"
   git-gutter:deleted-sign "-"
   git-gutter:diff-option "-w"
   git-gutter:hide-gutter t
   git-gutter:modified-sign "!"
   git-gutter:unchanged-sign " "
   git-gutter:visual-line t)
  (defun git-gutter-enable-unless-remote ()
    (unless (file-remote-p buffer-file-name)
      (git-gutter-mode +1)))
  (add-hook 'find-file-hook 'git-gutter-enable-unless-remote)
  :bind
  ("s-d" . hydra-git-gutter/body)
  :init
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

(use-package git-gutter-fringe)

(use-package paren
  :init
  (setq show-paren-delay 0)
  :config
  (show-paren-mode +1))

(use-package cperl-mode
  :mode ("/t/.*\\.t\\'" "\\.pm\\'" "\\.pl\\'")
  :interpreter ("perl")
  :hook
  (cperl-mode . (lambda () (add-hook 'before-save-hook 'whitespace-cleanup nil t)))
  :config
  (setq
   cperl-indent-level 4
   cperl-break-one-line-blocks-when-indent nil
   cperl-fix-hanging-brace-when-indent nil
   cperl-indent-comment-at-column-0 t
   cperl-indent-parens-as-block t
   cperl-indent-subs-specially nil
   cperl-tab-always-indent t
   cperl-close-paren-offset -4
   cperl-continued-statement-offset 4
   cperl-tab-always-indent t
   cperl-continued-brace-offset 4
   cperl-indent-wrt-brace t
   cperl-lineup-step t
   cperl-info-on-command-no-prompt t
   cperl-invalid-face (quote default)
   cperl-lazy-help-time 10000
   cperl-merge-trailing-else nil
   cperl-under-as-char nil))

(use-package js2-mode
  :mode ("/architect.*view" "\\.js\\'")
  :hook (js2-mode . (lambda() (add-hook 'before-save-hook 'whitespace-cleanup nil t)))
  :config
  (setq js2-mode-show-parse-errors nil
        js2-mode-show-strict-warnings nil))

(use-package js2-refactor
  :hook (js2-mode . js2-refactor-mode)
  :config
  (global-unset-key (kbd "s-f"))
  (js2r-add-keybindings-with-prefix "s-f"))

(use-package php-mode
  :mode "\\.php\\'"
  :hook (php-mode . (lambda() (add-hook 'before-save-hook 'whitespace-cleanup nil t))))

(use-package csharp-mode
  :mode "\\.cs\\'"
  :hook (csharp-mode . (lambda() (add-hook 'before-save-hook 'whitespace-cleanup nil t))))

(use-package go-mode
  :mode "\\.go\\'"
  :hook
  (go-mode . (lambda()
               (setq indent-tabs-mode t)
               (add-hook 'before-save-hook 'gofmt-before-save))))

(use-package markdown-mode
  :mode "\\.md\\'"
  :hook (markdown-mode . (lambda() (setq indent-tabs-mode t))))

(use-package yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'")
  :hook (yaml-mode . highlight-indent-guides-mode))

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
  :bind
  ("s-j o" . dumb-jump-go-other-window)
  ("s-j j" . dumb-jump-go)
  ("s-j i" . dumb-jump-go-prompt)
  ("s-j x" . dumb-jump-go-prefer-external)
  ("s-j z" . dumb-jump-go-prefer-external-other-window)
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
  :config
  (require 'spaceline-config)
  (spaceline-define-segment buffer-line-count
    "<CURRENT_LINE>/<BUFFER_LINES> <COLUMN_NUMBER>"
    (format "%%l/%d %%c" (count-lines (point-min) (point-max))))
  ;; (defvar spaceline-time)
  ;; (defun set-spaceline-time ()
  ;;   (with-current-buffer (get-buffer "*scratch*")
  ;;     (setq spaceline-time (shell-command-to-string "echo -n $(TZ='America/Los_Angeles' date '+%I:%M%p')"))))
  ;; (run-with-timer 0 15 'set-spaceline-time)
  ;; (spaceline-define-segment datetime
  ;;   spaceline-time)
  (setq
   ;; spaceline-time "12:00AM"
   spaceline-byte-compile t
   powerline-default-separator "rounded"
   spaceline-separator-dir-left '(left . left)
   spaceline-separator-dir-right '(right . right)
   spaceline-highlight-face-func 'spaceline-highlight-face-modified
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
    '((buffer-modified :priority 98 :face highlight-face)
      (buffer-line-count :priority 97)
      (remote-host :priority 94)
      (projectile-root :priority 93)
      (buffer-id :priority 95)
      (version-control :priority 70))
    '((selection-info :priority 95)
      (flycheck-info :priority 75)
      (flycheck-warning :priority 76)
      (flycheck-error :priority 77)
      (major-mode :priority 50)
      (global :when active :priority 94)
      (battery :priority 98)))
  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-jschell-mode))))
  :custom-face
  (mode-line ((t (:background "#444477"))))
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

(use-package fancy-battery
  :config
  (fancy-battery-mode))

(use-package column-enforce-mode
  :init
  (setq column-enforce-column 100)
  :config
  (global-column-enforce-mode)
  :custom-face
  (column-enforce-face ((t (:background "#333333")))))

(use-package persistent-scratch
  :config
  (persistent-scratch-setup-default))

(use-package company
  :custom-face
  (company-tooltip ((t (:inherit default :background "#222244"))))
  (company-tooltip-selection ((t (:inherit default :background "#442222"))))
  (company-tooltip-search ((t (:inherit default :background "#224422"))))
  (company-tooltip-search-selection ((t (:inherit default :background "#662222"))))
  (company-scrollbar-fg ((t (:inherit default :background "#555577"))))
  (company-scrollbar-bg ((t (:inherit default :background "#444466"))))
  :config
  (defun js/company-tooltip-frontend-unless-just-one-manual-frontend (command)
    "Only display tooltip if manually requested"
    (when company--manual-action
      (company-pseudo-tooltip-unless-just-one-frontend command)))
  (setq company-idle-delay 0.1
        company-tooltip-align-annotations t
        company-frontends '(js/company-tooltip-frontend-unless-just-one-manual-frontend
                            company-preview-if-just-one-frontend
                            company-echo-metadata-frontend))
  ;; TODO: this should go in keys.el, but doesn't work with lazy loading and eval-after-load
  (define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
  (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)
  (define-key company-active-map (kbd "M-'") 'company-complete-selection))

(use-package flycheck
  :after hydra
  :hook
  (cperl-mode . flycheck-mode)
  :custom-face
  (flycheck-error ((t (:background "#552255" :box (:line-width -1 :color "#662266")))))
  (flycheck-warning ((t (:background "#222255" :box (:line-width -1 :color "#222266")))))
  (flycheck-info ((t (:background "#333333" :box (:line-width -1 :color "#444444")))))
  (flycheck-fringe-error ((t (:foreground "#ff00ff" :background "#ff00ff"))))
  (flycheck-fringe-warning ((t (:foreground "#0000ff" :background "#0000ff"))))
  (flycheck-fringe-info ((t (:foreground "#aaaaaa" :background "#aaaaaa"))))
  :init
  (defhydra
    hydra-flycheck
    (:quit-key "C-g")
    "Flycheck"
    ("p" flycheck-previous-error "Previous Error")
    ("n" flycheck-next-error "Next Error")
    ("b" flycheck-buffer "Check Buffer")
    ("c" flycheck-compile "Compile Buffer")
    ("l" counsel-flycheck "List Errors"))
  :bind
  ("s-e" . hydra-flycheck/body)
  :config
  (setq-default flycheck-perl-include-path '("/Users/jschell/gtperl" "/Users/jschell/gtperl/external_deps/lib/perl5")))

(use-package eldoc)

(use-package tide
  :after (js2-mode company flycheck eldoc)
  :config
  (add-hook 'js2-mode-hook 'tide-setup t)
  (add-hook 'js2-mode-hook 'flycheck-mode t)
  (add-hook 'js2-mode-hook 'tide-hl-identifier-mode t)
  (add-hook 'js2-mode-hook 'eldoc-mode t)
  (add-hook 'js2-mode-hook 'company-mode t)
  (add-hook 'before-save-hook 'tide-format-before-save t)
  (add-hook 'js2-mode-hook (lambda () (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)) t)
  (setq flycheck-check-syntax-automatically '(save mode-enabled)
        tide-default-mode "JS"))

(use-package highlight-symbol
  :hook (prog-mode . highlight-symbol-mode)
  :custom
  (highlight-symbol-idle-delay 0.3))

(use-package fira-code
  :ensure nil
  :hook
  (cperl-mode . fira-code-mode)
  (js2-mode . fira-code-mode)
  (php-mode . fira-code-mode)
  (csharp-mode . fira-code-mode)
  (go-mode . fira-code-mode)
  (markdown-mode . fira-code-mode)
  (csharp-mode . fira-code-mode)
  (emacs-lisp-mode . fira-code-mode)
  (lisp-mode . fira-code-mode))

(use-package json-mode
  :mode ("\\.json\\'"))

(use-package highlight-indent-guides)
