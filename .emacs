;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq load-prefer-newer t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

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
(require 'gt-perl)
(defalias 'perl-mode 'cperl-mode)

(load-library "keys.el")
(load-library "functions.el")

(setq-default indent-tabs-mode nil)
(setq
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
 completions-format (quote vertical)

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
 vc-follow-symlinks nil
 smerge-command-prefix (kbd "s-m"))

;;; backup/autosave
(defvar backup-dir (expand-file-name "~/.emacs.d/backup"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave"))
(setq backup-directory-alist (list (cons ".*" backup-dir))
      auto-save-list-file-prefix autosave-dir
      auto-save-file-name-transforms `((".*" ,autosave-dir t))
      create-lockfiles nil)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package default-text-scale
  :init
  (default-text-scale-mode))

(use-package ffap
  :config
  (add-to-list 'ffap-alist '(shell-mode . ffap-gits-src))
  (add-to-list 'ffap-alist '(shell-mode . ffap-gits-current))
  (add-to-list 'ffap-alist '(term-mode . ffap-gits-src))
  (add-to-list 'ffap-alist '(term-mode . ffap-gits-current)))

(use-package projectile
  :config
  (setq projectile-file-exists-local-cache-expire (* 5 60))
  :init
  (projectile-mode))

(use-package xterm-color
  :init
  (progn (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
       (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))))

(use-package tramp
  :config
  (setq tramp-connection-timeout 10
        tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='~/.ssh/sockets/tramp.%%r@%%h:%%p' -o ControlPersist=600"
        remote-file-name-inhibit-cache nil
        vc-ignore-dir-regexp (format "%s\\|%s"
                                     vc-ignore-dir-regexp
                                     tramp-file-name-regexp)))

(use-package magit
  :config
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
   projectile-completion-system 'ivy
   ivy-re-builders-alist '((t . ivy--regex-ignore-order))))

(use-package auto-dim-other-buffers
  :config
  (auto-dim-other-buffers-mode t))

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

(use-package git-gutter
  :bind
  ("s-d M" . git-gutter-mode)
  ("s-d =" . git-gutter:popup-hunk)
  ("s-d n" . git-gutter:next-hunk)
  ("s-d p" . git-gutter:previous-hunk)
  ("s-d e" . git-gutter:end-of-hunk)
  ("s-d k" . git-gutter:revert-hunk)
  ("s-d s" . git-gutter:stage-hunk)
  ("s-d m" . git-gutter:mark-hunk)
  ("s-d r" . git-gutter:set-start-revision)
  ("s-d S" . git-gutter:statistic)
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
  (defhydra hydra-git-gutter (global-map "s-d" :pre (ignore-errors (git-gutter:popup-hunk)) :post (kill-matching-buffers-no-ask "*git-gutter:diff*"))
    "git-gutter"
    ("=" git-gutter:popup-hunk "hunk at cursor")
    ("n" git-gutter:next-hunk "next hunk")
    ("p" git-gutter:previous-hunk "previous hunk")
    ("k" git-gutter:revert-hunk "kill hunk"))
  (defun git-gutter-enable-unless-remote ()
    (unless (file-remote-p buffer-file-name)
      (git-gutter-mode +1)))
  (add-hook 'find-file-hook 'git-gutter-enable-unless-remote))

(use-package git-gutter-fringe)

(use-package smartparens
  :bind
  (("M-p" . sp-backward-sexp)
   ("M-n" . sp-forward-sexp))
  :config
  (setq sp-show-pair-from-inside t
        sp-autoinsert-pair nil)
  :init
  (smartparens-global-mode)
  (show-smartparens-global-mode))

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
  (setq js2-mode-show-parse-errors t
        js2-mode-show-strict-warnings nil))


(use-package php-mode
  :mode "\\.php\\'"
  :hook (php-mode . (lambda() (add-hook 'before-save-hook 'whitespace-cleanup nil t))))

(use-package csharp-mode
  :mode "\\.cs\\'"
  :hook (csharp-mode . (lambda() (add-hook 'before-save-hook 'whitespace-cleanup nil t))))

(use-package go-mode
  :mode "\\.go\\'"
  :hook (go-mode . (lambda() (setq indent-tabs-mode t))))

(use-package markdown-mode
  :mode "\\.md\\'"
  :hook (markdown-mode . (lambda() (setq indent-tabs-mode t))))

(use-package yaml-mode
  :mode ("\\.yml\\'" "\\.yaml\\'"))

(use-package csharp-mode
  :mode "\\.cs\\'")

(use-package counsel-projectile
  :config
  (setq
   counsel-find-file-ignore-regexp nil
   counsel-projectile-switch-project-action
   (quote (1
           ("o" counsel-projectile-switch-project-action "jump to a project buffer or file")
           ("f" counsel-projectile-switch-project-action-find-file "jump to a project file")
           ("d" counsel-projectile-switch-project-action-find-dir "jump to a project directory")
           ("D" counsel-projectile-switch-project-action-dired "open project in dired")
           ("b" counsel-projectile-switch-project-action-switch-to-buffer "jump to a project buffer")
           ("m" counsel-projectile-switch-project-action-find-file-manually "find file manually from project root")
           ("S" counsel-projectile-switch-project-action-save-all-buffers "save all project buffers")
           ("k" counsel-projectile-switch-project-action-kill-buffers "kill all project buffers")
           ("K" counsel-projectile-switch-project-action-remove-known-project "remove project from known projects")
           ("c" counsel-projectile-switch-project-action-compile "run project compilation command")
           ("C" counsel-projectile-switch-project-action-configure "run project configure command")
           ("E" counsel-projectile-switch-project-action-edit-dir-locals "edit project dir-locals")
           ("v" counsel-projectile-switch-project-action-vc "open project in vc-dir / magit / monky")
           ("sg" counsel-projectile-switch-project-action-grep "search project with grep")
           ("si" counsel-projectile-switch-project-action-git-grep "search project with git grep")
           ("ss" counsel-projectile-switch-project-action-ag "search project with ag")
           ("sr" counsel-projectile-switch-project-action-rg "search project with rg")
           ("xs" counsel-projectile-switch-project-action-run-shell "invoke shell from project root")
           ("xe" counsel-projectile-switch-project-action-run-eshell "invoke eshell from project root")
           ("xt" counsel-projectile-switch-project-action-run-term "invoke term from project root")
           ("Oc" counsel-projectile-switch-project-action-org-capture "capture into project")
           ("Oa" counsel-projectile-switch-project-action-org-agenda "open project agenda"))))
  :init (counsel-projectile-mode))

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
  :init
  (which-key-mode))

(use-package spaceline
  :config
  (require 'spaceline-config)
  (spaceline-define-segment buffer-line-count
    "<CURRENT_LINE>/<BUFFER_LINES> <COLUMN_NUMBER>"
    (format "%%l/%d %%c" (count-lines (point-min) (point-max))))
  (defvar spaceline-time)
  (defun set-spaceline-time ()
    (with-current-buffer (get-buffer "*scratch*")
      (setq spaceline-time (shell-command-to-string "echo -n $(TZ='America/Los_Angeles' date '+%I:%M%p')"))))
  (run-with-timer 0 15 'set-spaceline-time)
  (spaceline-define-segment datetime
    spaceline-time)
  (setq
   spaceline-time "12:00AM"
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
  (spaceline-compile "jschell"
    '((buffer-modified :priority 98 :face highlight-face)
      (buffer-line-count :priority 97)
      (remote-host :priority 94)
      (projectile-root :priority 93)
      (buffer-id :priority 95)
      (version-control :priority 78))
    '((selection-info :priority 95)
      (major-mode :priority 79)
      (global :when active :priority 94)
      (datetime :priority 92)))
  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-jschell))))
  :custom-face
  (mode-line ((t (:background "#444477"))))
  (mode-line-inactive ((t (:foreground "#bbbbbb" :background "#444444"))))
  (powerline-active1 ((t (:background "#666699"))))
  (powerline-active2 ((t (:background "#111111"))))
  (powerline-inactive1 ((t (:foreground "#bbbbbb" :background "#555555"))))
  (powerline-inactive2 ((t (:foreground "#bbbbbb" :background "#222222"))))
  (spaceline-modified ((t (:foreground "#000000" :background "#ccaa33"))))
  (spaceline-read-only ((t (:foreground "#000000" :background "#dd0101"))))
  (spaceline-unmodified ((t (:foreground "#000000" :background "#8888bb")))))

(use-package persistent-scratch
  :init
  (persistent-scratch-setup-default))

(global-font-lock-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(desktop-save-mode 1)
(window-divider-mode t)

(set-display-table-slot standard-display-table 'wrap ?·)

(if (memq window-system '(mac ns))
    (progn
      (require 'exec-path-from-shell)
      (exec-path-from-shell-initialize)
      (exec-path-from-shell-copy-env "SSH_AGENT_PID")
      (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
      (set-scroll-bar-mode nil)
      (load-theme 'schellj-gui t)
      (fringe-mode '(2 . 0)))
  (load-theme 'schellj-terminal t))

(add-hook 'find-file-hook 'smerge-try-smerge)
(add-hook 'after-revert-hook 'smerge-try-smerge)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

