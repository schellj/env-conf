;; (add-to-list 'default-frame-alist '(height . 67))
;; (add-to-list 'default-frame-alist '(width . 237))


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")
(setq custom-theme-load-path 
      (append '( "~/.emacs.d/themes" ) custom-theme-load-path))
(require 'gt-perl)
(defalias 'perl-mode 'cperl-mode)
(load-library "functions.el")
(load-library "keys.el")
(eval-after-load 'magit '(load-library "setup-magit.el"))

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (package-initialize))

;; (add-to-list 'c-offsets-alist '(arglist-close . c-lineup-close-paren))
(add-to-list 'auto-mode-alist '("/architect.*view" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("/t/.*\\.t\\'" . perl-mode))
(add-to-list 'auto-mode-alist '("/rop-console-ios/.*\\.[hm]\\'" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

(setq 
 debug-on-error nil
 perl-indent-parens-as-block t
 cperl-font-lock t
 cperl-electric-lbrace-space nil
 cperl-electric-parens nil
 cperl-electric-linefeed nil
 cperl-electric-keywords nil
 cperl-info-on-command-no-prompt t
 cperl-clobber-lisp-bindings nil
 cperl-lazy-help-time 10000
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
 cperl-font-lock t

 cperl-close-paren-offset -4
 cperl-continued-statement-offset 4
 cperl-tab-always-indent t

 cperl-continued-brace-offset 4
 ;; cperl-indent-region-fix-constructs 1
 cperl-indent-wrt-brace t
 ;; cperl-label-offset -4
 cperl-lineup-step t
 ;; cperl-min-label-indent 0

 cperl-info-on-command-no-prompt t
 cperl-invalid-face (quote default)
 cperl-lazy-help-time 10000
 cperl-merge-trailing-else nil
 cperl-under-as-char nil
 js2-mode-show-parse-errors t
 js2-mode-show-strict-warnings nil
 read-buffer-completion-ignore-case t
 read-file-name-completion-ignore-case t
 show-trailing-whitespace nil
 tab-width 4
 transient-mark-mode t
 truncate-partial-width-windows nil
 visible-bell nil
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-blinks -1)
 '(cperl-break-one-line-blocks-when-indent nil)
 '(cperl-fix-hanging-brace-when-indent nil)
 '(cperl-indent-comment-at-column-0 t)
 '(cperl-indent-level 4)
 '(cperl-indent-parens-as-block t)
 '(cperl-indent-subs-specially nil)
 '(custom-safe-themes
   (quote
    ("cfccfee425958e436350031685a10cd6aa57556af78c6030e7d8f640c9e11eca" "1011e3a1284a771b3cedd0a151d2aa0aee331e18fa16e97cbd5e66d82cc4ca3f" "2f209bf70f3e7db1318a918e7ca96853b2479fea34099768657538f74501984d" "b038e5703838757ad1fb53f389e0d5bc2752aa609af8cab87814c10737fc4342" "8c285861ff09a59100dc343bbd1910541ccf46c8300fe43a3fcefaad40909fca" "6953ef9d809755080e5892c7cd520263cfe56ba8777c1797733ccea5469af553" "89c552817af45d88bd20dc19bf0ed04a0b924b3fd6f75b65b239e30613241d02" "07622b7f47e9ff112439bda64da7591015634d4558ddf1f13a7751e6d527db2d" "fa53251842abb9f2c55caf3454a6fd1d681086b35718995467559cc7d6b5d697" "6f7bef43b031da5a1be3d79b974e3813f0bd66dce61e951a69a6965c999d57d7" "8ef8219578f32fad8d0223463d7f23731027af202859e06ec5c57cffca94883c" "31eee636fd72dac6223abd847a800b6a26a0608d7c3e8576e944dfbd6d7f6476" "a6fa10b5583a520a82ecb13c1058871db244123cdea4b645ff8c09c9798d938b" "d275e09b4d53dc753324e32690b4e3279e1a407b292fdb2f4a42e89b491e3449" "a1df36e4d43f2452133e9b015d41869ddd49dfcc45277a1ca5089c920bd4950c" "3586825e7ddad049a04ef36d573f226ee9df2124b81164bf9aedbd1562b4487d" "a687d2eb3e97dca84b842178c8154c08725a5ff59ac09c943c0678a9fd991358" "c81df9c14a4793143d04b9af9f3c80207922f9a3f38ade7b55fa95eb25f7a678" "1c5ffd9e809e6da5f421206b5ea4bfee8015dd8d6781625d49d2c84723a56256" "61faab7500cec648f6dbe77fa6a6b36b96913ae51cced47e63f85f312549a6ed" "75be5c4b8f9c38d1c865dcffd9271c0c92836d09e2397c30017c6f9a175f9810" "0cd9f708df2a944f301003c1980bdaa7315f706264d965f51da1a5e40954ef15" "7263d172afc1f3db5290ed35f7af47325e6bb5a655ad2663aaaa65ee4f482796" "0ff6e3e526c57501b580d7d73dd07327b0bc7d8178837a1fa0eb70312b799ccd" "b848abceb7cfb5e07abdcff49be82a99e1a30e6836473b9e11f36975929616df" "f9092c98f5335b65f61dcbc473f388a49bfbea7ced847757f0aa3f5f88856629" "771e786dfaab907f7933f76a52fd8a00b5aa5872ee0d6e698c4bf3c9eba08f4b" "fb5752fd6db922cf0280cb7d8f6237f2a7564e17973d9f5bd225aa00a608106c" "47284f31629397cef09b5f763093b05cc3a016219e7050aa4490f328398e99bd" "02f066d23cd9faa37b40487802969855595f1fcc8d3a31a3ca795daa37201f21" "971fdfbab524c3e896797255e67185f0a7386bc9875f07d0e5a4fbbdebb1c498" "f55abc032de4012ab8ad7eb105081b842e0e33a6ac76b768de302aac00970e4a" "8d2bfaae8e1fd2407ed91693b51c9d8549e088e6e7782e8f6a494c7324bb2391" "798d590d01a6f8f3a3d271d6174a4015b67cc56052d8e9504c26c5d135c717ce" "f3bb8d4b4eb19b0bf37220c75290ae2414fe17609aa8f6aef7789fc6a1618e78" "d5377f0e4c9e8552dbf37871833733d4f28024aa98f9b83706cd6c74ce383eca" "1d6a3012bc692ef38b81793d45032db33eab37645dcedc4f1bf7d0b7cf022d1b" "5bfd841dd5155e98e8e5ed30f2000b986858213b290af5e4f41fb1a981a35ac2" "eeebb8760eb584567f5bcd8508b75b369ba67817c8f7ec6d5093a1aa8c55779b" "425870cc1663c91047203407036bf159587244591e6ac9acc15cb5bd8f37dbd5" "edd734a436b02d77ef75c47d7afbb6ca1ae5897a6a5c1b95423ce100bf9d3117" "a65f7d2bf7805747ac8b6d8a3a5f612310a768b8eced07f74b4c5baa2abee0dd" "802e7a1f59c36b0bebdc07efc6cd31d89bd4f864f153a6ef0b7d4eae617d5eab" "e5860e977cb41771eba4d046812f8983852d9ce50af0eb861b1d17f1725e6a8d" "66d17580694f557810782323f7300d0141b3e7b75980bf58dbd20285fab263f9" "f1a730c87b8cce29da188a5b7ce0e10b8486a610ff86e9a8e3e3b182f3be4528" "07cda797d373fb8ebe95e6523917206a1ade362cdf09cadddb26d229c09e7a55" "aa328acdf023066492e4584e8b586ff97596af29f1fc9f6804fb2097f2c76bf3" "60742fbe4bc1777ab92e37bb892cfac216092fd2ca66161fbacadffd0884bdd4" "5086409627a354e868a669fb02b1b00c3febc790efba49e69b2afcafc1d616b4" "5f18a938ab14286b2da7764974cfe8e1215dc12a2fc17fa7ba8b3bd0f2256613" "9fad772a1ad13df74806c13504c6b5df2cc222c91ee8f883fed77cc1c4ac2f5b" "2d8a894998f931237e4d3b774e080092450b7b01d449cb777b558ecaedb0a49b" "24cef59ef50cd46504ec7bd443ab45b5b062448c1a3be31723a0433315e285c4" "f0b8f0479d7b9ec451d215fd731f583e410e5a58907338531cf6c282abd6f4c1" "cd3a9ef301a54f4b27b106fd0ba9702d826c08a03d0ba1c6fb182dece503b526" "e2b8e449040fdbcaab8343af919cc93cd00c9a32f6bb15e574b6fc226bcc2529" "ec013d20292a08448fc6cc8917f4db308a3ff75cc059eec84eaedb3480e78a88" "31be917e7ac0b4a2b715c4a2858b46658630c6cbe1a1092b594d84ea30923d0e" "ccd03a22a0a66d11b275148ee7b3c358295117d5d17dce4965d38e2ce9370196" "e6bd2df77fd1edd2cefc7f5d29db00d4640c677da0f1934cc3445818d1b0784b" "cb9f954ea4193568593072ca39fdcb680205f80f8b3c7711e490cf9ef9ef83ba" "44704a58a4e81e4c4159f4045484515ab5ac472af2d6f40da3b580ca9639c3e9" "ce59b2696a8cac082069e45dc609850a4c696f370e64f2a7cf2bb416528b979f" "6c3fa5ae2483817a63f4d96af79250e8df48aa43dfd8db31bf805bba7b0e3d17" "a872cd5d932186e242fa4036a07f862e62694666438d42d06eb62497b84e757f" "e76da062cd34b227bbf2ce68dd7007301d4c56d8fe026c2460b7b27c4bb1db9e" "fddf128e283fa3440cd9bdf8873c65f2a8e82da46ac32837d623e854570a5a67" "185e6964ae820be6f9c6072a56fbd083a625ab35095a10a47455623ca5b2d383" "8f034ff240bfe21257f557c61ea444c300450e84e187885802dc9fee7d12fa5d" default)))
 '(display-buffer-alist (quote (("shell" display-buffer-same-window (nil)))))
 '(flycheck-perl-include-path (quote ("~/gtperl")))
 '(indent-tabs-mode nil)
 '(package-selected-packages
   (quote
    (exec-path-from-shell spinner perlcritic flymake-perlcritic flycheck php-mode magit js2-mode cperl-mode)))
 '(switch-to-buffer-preserve-window-point t))

(set-scroll-bar-mode nil)

;; (defadvice cperl-backward-to-start-of-continued-exp (after indentation-fix)
;;   (and (not (memq char-after '(?\) ?\})))
;;        (looking-back "^[ \t]+")
;;        (> (current-column) cperl-continued-statement-offset)
;;        (backward-char cperl-continued-statement-offset)))

;; (defun cperl-backward-to-start-of-continued-exp (lim)
;;   (goto-char containing-sexp)
;;   (let ((sexp-start (following-char)))
;;     (forward-char)
;;     (skip-chars-forward " \t\n")
;;     (if (and (> (current-column) cperl-continued-statement-offset)
;;              (memq sexp-start (append "([" nil)))
;;         (backward-char cperl-continued-statement-offset))))

;; (defun cperl-backward-to-start-of-continued-exp (lim)
;;   (if (memq (preceding-char) (append ")]}\"'`" nil))
;;       (forward-sexp -1))
;;   (beginning-of-line)
;;   (if (or (<= (point) lim) (< 0 cperl-continued-statement-offset))
;;       (goto-char (1+ lim)))
;;   (skip-chars-forward " \t"))

(defun beep-on-alert-char (str)
 (if (string-match-p "\x7" str) (ding)))
(add-hook 'comint-output-filter-functions 'beep-on-alert-char)

(setq ring-bell-function `(lambda ()
;			    (unless (fsm-frame-x-active-window-p (selected-frame)) ding)
;			    (ding)
			    (invert-face 'mode-line)
			    (run-with-timer 0.01 nil 'invert-face 'mode-line)
			    ))

(require 'dbus)

(defun fsm-x-active-window ()
  "Return the window ID of the current active window in X, as
  given by the _NET_ACTIVE_WINDOW of the root window set by the
  window-manager, or nil if not able to"
  (if (eq (window-system) 'x)
      (let ((x-active-window (x-window-property "_NET_ACTIVE_WINDOW" nil "WINDOW" 0 nil t)))
	(string-to-number (format "%x00%x" (car x-active-window) (cdr x-active-window)) 16))
    nil))

(defun fsm-frame-outer-window-id (frame)
  "Return the frame outer-window-id property, or nil if FRAME not of the correct type"
  (if (framep frame)
      (string-to-number
       (frame-parameter frame 'outer-window-id))
    nil))

(defun fsm-frame-x-active-window-p (frame)
  "Check if FRAME is is the X active windows
  Returns t if frame has focus or nil if"
  (if (framep frame)
      (progn
	(if (eq (fsm-frame-outer-window-id frame)
		(fsm-x-active-window))
	    t
	  nil))
    nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#1b1d1e" :foreground "#f8f8f0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "apple" :family "Monaco"))))
 '(bold ((t (:weight normal))))
 '(comint-highlight-prompt ((t nil)))
 '(eshell-prompt ((t nil)) t))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
 (add-hook 'eshell-preoutput-filter-functions
           'ansi-color-filter-apply)

(global-font-lock-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)

(load-theme 'schellj-gui t)

(setq-default
  mode-line-format
   '(
        (:propertize "%4l " face mode-line-position-face)
           mode-line-client
           ""
           (:eval
            (cond (buffer-read-only
                   (propertize " RO " 'face 'mode-line-read-only-face))
                  ((buffer-modified-p)
                   (propertize " ** " 'face 'mode-line-modified-face))
                  (t "    ")))
           " "
           (:propertize (:eval (shorten-directory default-directory 30))
                        face mode-line-folder-face)
           (:propertize "%b"
                        face mode-line-filename-face)
           " %n "
           (vc-mode vc-mode)
           " %["
           (:propertize mode-name
                        face mode-line-mode-face)
           "%] "
           (:eval (propertize (format-mode-line minor-mode-alist)
                              'face 'mode-line-minor-mode-face))
           (:propertize mode-line-process
                        face mode-line-process-face)
           (global-mode-string global-mode-string)
           " %p "
           ))

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

;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)

(set-face-attribute 'mode-line-read-only-face nil
                    :inherit 'mode-line-face
                    :foreground "red")
(set-face-attribute 'mode-line-modified-face nil
                    :inherit 'mode-line-face
                    :foreground "black"
                    :background "green")
(set-face-attribute 'mode-line-folder-face nil
                    :inherit 'mode-line-face
                    :foreground "white")
(set-face-attribute 'mode-line-filename-face nil
                    :inherit 'mode-line-face
                    :foreground "yellow")
(set-face-attribute 'mode-line-position-face nil
                    :inherit 'mode-line-face
                    :foreground "white")
(set-face-attribute 'mode-line-mode-face nil
                    :inherit 'mode-line-face
                    :foreground "white")
(set-face-attribute 'mode-line-minor-mode-face nil
                    :inherit 'mode-line-mode-face
                    :foreground "white")
(set-face-attribute 'mode-line-process-face nil
                    :inherit 'mode-line-face
                    :foreground "yellow")
(set-face-attribute 'mode-line-80col-face nil
                    :inherit 'mode-line-position-face
                    :foreground "black" :background "red")
(set-face-attribute 'mode-line-80col-face nil
                    :inherit 'mode-line-position-face
                    :foreground "black" :background "red")
(set-face-attribute 'minibuffer-prompt nil
                    :foreground "cyan" :background "black")

(defun what-face (pos)
    (interactive "d")
        (let ((face (or (get-char-property (point) 'read-face-name)
            (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(set-display-table-slot standard-display-table 'wrap ?·)
;; (set-display-table-slot standard-display-table 'vertical-border ?│)

(require 'compile)
(add-hook 'perl-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (concat "perl -c " (file-name-nondirectory buffer-file-name)))))

(add-hook 'after-init-hook #'global-flycheck-mode)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(fringe-mode '(4 . 4))
(desktop-save-mode 1)
