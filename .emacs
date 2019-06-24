;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-enable-at-startup nil)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
  ;; (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (package-initialize))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(require 'recentf)
(setq recentf-auto-cleanup 'never)
(recentf-mode 1)

(require 'xterm-color)
(progn (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
       (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions)))

(add-to-list 'load-path "~/.emacs.d/lisp")
(setq custom-theme-load-path
      (append '( "~/.emacs.d/themes" ) custom-theme-load-path))
(require 'gt-perl)
(require 'perltidy)
;; (require 'perltidy-mode)
(defalias 'perl-mode 'cperl-mode)
(load-library "functions.el")

(use-package projectile
  :config (projectile-mode +1))

(load-library "keys.el")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#111111" :foreground "#f8f8f0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Monaco"))))
 '(auto-dim-other-buffers-face ((t (:foreground "#bbbbbb" :background "#222222"))))
 '(bold ((t (:weight normal))))
 '(comint-highlight-prompt ((t nil)))
 '(eshell-prompt ((t nil)))
 '(powerline-active1 ((t (:background "#666699"))))
 '(powerline-active2 ((t (:background "#111111"))))
 '(mode-line ((t (:background "#444477"))))
 '(powerline-inactive1 ((t (:foreground "#bbbbbb" :background "#555555"))))
 '(powerline-inactive2 ((t (:foreground "#bbbbbb" :background "#222222"))))
 '(mode-line-inactive ((t (:foreground "#bbbbbb" :background "#444444"))))
 '(spaceline-read-only ((t (:foreground "#000000" :background "#dd2222"))))
 '(spaceline-modified ((t (:foreground "#000000" :background "#ccbb00"))))
 '(spaceline-unmodified ((t (:foreground "#000000" :background "#8888bb"))))
 '(rainbow-delimiters-depth-1-face ((t (:inherit rainbow-delimiters-base-face :foreground "#ffffff"))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :foreground "#bbbbbb"))))
 '(rainbow-delimiters-depth-3-face ((t (:inherit rainbow-delimiters-base-face :foreground "#eeeeee"))))
 '(rainbow-delimiters-depth-4-face ((t (:inherit rainbow-delimiters-base-face :foreground "#aaaaaa"))))
 '(rainbow-delimiters-depth-5-face ((t (:inherit rainbow-delimiters-base-face :foreground "#dddddd"))))
 '(rainbow-delimiters-depth-6-face ((t (:inherit rainbow-delimiters-base-face :foreground "#999999"))))
 '(rainbow-delimiters-depth-7-face ((t (:inherit rainbow-delimiters-base-face :foreground "#66bbbb"))))
 '(rainbow-delimiters-depth-8-face ((t (:inherit rainbow-delimiters-base-face :foreground "#dddddd"))))
 '(rainbow-delimiters-depth-9-face ((t (:inherit rainbow-delimiters-base-face :foreground "#888888"))))
 '(sp-show-pair-enclosing ((t (:inherit highlight)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#1E2029" "#ff5555" "#50fa7b" "#f1fa8c" "#61bfff" "#ff79c6" "#8be9fd" "#f8f8f2"])
 '(beacon-blink-when-focused t)
 '(beacon-blink-when-window-scrolls nil)
 '(beacon-color "Purple")
 '(beacon-mode t)
 '(beacon-size 200)
 '(blink-cursor-blinks -1)
 '(c-tab-always-indent t)
 '(clean-buffer-list-delay-general 7)
 '(column-enforce-column 100)
 '(column-highlight-mode nil)
 '(column-number-mode t)
 '(comint-scroll-to-bottom-on-input t)
 '(counsel-find-file-ignore-regexp nil)
 '(counsel-projectile-mode t nil (counsel-projectile))
 '(counsel-projectile-switch-project-action
   (quote
    (1
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
 '(cperl-break-one-line-blocks-when-indent nil)
 '(cperl-fix-hanging-brace-when-indent nil)
 '(cperl-indent-comment-at-column-0 t)
 '(cperl-indent-level 4)
 '(cperl-indent-parens-as-block t)
 '(cperl-indent-subs-specially nil)
 '(cperl-tab-always-indent t)
 '(cursor-type (quote box))
 '(custom-safe-themes
   (quote
    ("8b25fb56bd5ce3fb800ca2c08b21d94d76c0eea6ed40908b424213dd90603644" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "481c48e85a8a6725c27c08f9522e7dd72994f8a992d0f9cb46d3ff29596c2e42" "04523be52a37fa87645a88651d5c84999dcb309342413a2ea1aa784d6e43e5cb" "ad0dc71edef09a2b525769cbf1074c22ae29faafeb58c51b8d10f19cb61a6c44" "ca8d5d7cc992bd211844a46575b731188916b07972dbb0e70d5f50074015bf7b" "554c317cc577517211a1098026321708a1be697ca293e26daf45ec835ec577e8" "c8ff9489a52c65e3cd352370b8ba92c30f18073226702530b454c9cb6c0de98d" "c51f3e6a00a16be3700a7bd2f43e31b056037fa0078aebb5f376e8139c36e838" "a7b1b1c160aa1b7121be3146c1d254a10feffaa64ae7162e9c5736dd27aee51f" "ae6ef8b3e9b13f50d9c729b2a2e15342b9f5a528e5aa6d5688c6487f581b5d17" "95b6e71bb2ce80419358e4a85d5e5462e87504bad131bbf343b76ae8a2763e31" "6e6c195ffae51d6726fd9c682b7783092d53374877cc8dcdb130d3e763a5fcaf" "70da72dc4870c502924e2b0d667c09a1f0aa3bf060eb28865a4d912cf09010fb" "f6a2abd0984126a60140fe12269e34558c37e361a27bb5cb5fe4938887215aa4" "b554a7ac30030b79bfe0962891fba29b95e129b347ecdfbd75bc9d7b269a8dc3" "ca903b1f33566989f10f2df7075c95dd276e1d1cbead914b50cdeae70b0309b5" "cb346bf12e04872fd2934ff25bd48ce8f9cd090660cba4d8145522211962184a" "476b189375caba4ffd5841f9f1ea4d9028945a47420b4aee00217084fc97e7b3" "6585f319e56195939f0a2f52705ce92000e78ad67f482920602a7f28a6592b1c" "74a252b58f833cf5ca58dc29b7e817dd1096770dfa083fb8fea34ced5850dd07" "5ed77e2164b330b3228dd0f55babc9472f86160637ff78d798923da231c6e2f0" "df2a5188a221cd3adc391d4bf18211513fa76d4c950596572b7806e43d611737" "04759e4e59e060a753e0774b22b62e633dbbbba80a7c7fe9f04343fb198af0bf" "09e3481e72945f2d2abe9a43aaa0199b1f29e48a27f847ce9e153a28f17ac2e9" "b8ba3c1661827c2b52fb17e90457b23b55eca8e6f5faae810b4cdda79b627d21" "19ac470fd80356b8e7e479d660da1c23f050b86f00c02cb8503e97ab57bf54fe" "6edebea9a9207d27600d9f24cefff71a512087b7a1a9c15cccc8bcf3371bc3e5" "d1b16d52c094bb500bda74807f15fbe0c8fc7d1f805b64907c4984f444467310" "5e26b4ddaeb020f17cb05730ade2d70ad077b8708cfa90e46b99afad873e9982" "120fbb0aa7dac972001b63f05994ac7d8723e1a320a11cf7a2fe5a4116170a10" "0a65bf1151932a4b7b45bfee0c23223b5ae2c87b370dc4102c2789df10dd2687" "4440fa3d0aaabcb27433dec4e25d387577626e4edf21ce115ae31bfd7c033cf5" "e259eb2776095c5545be894e1bf8924f7ccd161925b7455112a4e72030161fe5" "d7445971daf269e7a998fcd5f2e5888a1286a9d9a919f73fa63e9c2722b68a80" "3935a8f75d9c6b48508c61fc110ed21f60a20e78a09647216eb08b80705a9f98" "5a43d88aec40a820034949fd87cf2435b31680134062bfa288569a9d1b54cb81" "2214f118823232b9cb67ab7efee814fd4f8c6a7ff1129ae812730ef42dfa63a1" "f36f1114fd0c8c3256a01f778cfff4c42f11164d1c078b28dd76c5ec22c3e96e" "b54249205cf62ee5f7486adadb22147e34d534812889d8c8f3655283136d8e1c" "97846b744c29259a892fcc34e6c4491b5a45aea44942c00842f2231abb8238da" "e985232da392939348c9a8e9c842b0a00a7e705670290ed78deeafe0ace9d152" "cfccfee425958e436350031685a10cd6aa57556af78c6030e7d8f640c9e11eca" "1011e3a1284a771b3cedd0a151d2aa0aee331e18fa16e97cbd5e66d82cc4ca3f" "2f209bf70f3e7db1318a918e7ca96853b2479fea34099768657538f74501984d" "b038e5703838757ad1fb53f389e0d5bc2752aa609af8cab87814c10737fc4342" "8c285861ff09a59100dc343bbd1910541ccf46c8300fe43a3fcefaad40909fca" "6953ef9d809755080e5892c7cd520263cfe56ba8777c1797733ccea5469af553" "89c552817af45d88bd20dc19bf0ed04a0b924b3fd6f75b65b239e30613241d02" "07622b7f47e9ff112439bda64da7591015634d4558ddf1f13a7751e6d527db2d" "fa53251842abb9f2c55caf3454a6fd1d681086b35718995467559cc7d6b5d697" "6f7bef43b031da5a1be3d79b974e3813f0bd66dce61e951a69a6965c999d57d7" "8ef8219578f32fad8d0223463d7f23731027af202859e06ec5c57cffca94883c" "31eee636fd72dac6223abd847a800b6a26a0608d7c3e8576e944dfbd6d7f6476" "a6fa10b5583a520a82ecb13c1058871db244123cdea4b645ff8c09c9798d938b" "d275e09b4d53dc753324e32690b4e3279e1a407b292fdb2f4a42e89b491e3449" "a1df36e4d43f2452133e9b015d41869ddd49dfcc45277a1ca5089c920bd4950c" "3586825e7ddad049a04ef36d573f226ee9df2124b81164bf9aedbd1562b4487d" "a687d2eb3e97dca84b842178c8154c08725a5ff59ac09c943c0678a9fd991358" "c81df9c14a4793143d04b9af9f3c80207922f9a3f38ade7b55fa95eb25f7a678" "1c5ffd9e809e6da5f421206b5ea4bfee8015dd8d6781625d49d2c84723a56256" "61faab7500cec648f6dbe77fa6a6b36b96913ae51cced47e63f85f312549a6ed" "75be5c4b8f9c38d1c865dcffd9271c0c92836d09e2397c30017c6f9a175f9810" "0cd9f708df2a944f301003c1980bdaa7315f706264d965f51da1a5e40954ef15" "7263d172afc1f3db5290ed35f7af47325e6bb5a655ad2663aaaa65ee4f482796" "0ff6e3e526c57501b580d7d73dd07327b0bc7d8178837a1fa0eb70312b799ccd" "b848abceb7cfb5e07abdcff49be82a99e1a30e6836473b9e11f36975929616df" "f9092c98f5335b65f61dcbc473f388a49bfbea7ced847757f0aa3f5f88856629" "771e786dfaab907f7933f76a52fd8a00b5aa5872ee0d6e698c4bf3c9eba08f4b" "fb5752fd6db922cf0280cb7d8f6237f2a7564e17973d9f5bd225aa00a608106c" "47284f31629397cef09b5f763093b05cc3a016219e7050aa4490f328398e99bd" "02f066d23cd9faa37b40487802969855595f1fcc8d3a31a3ca795daa37201f21" "971fdfbab524c3e896797255e67185f0a7386bc9875f07d0e5a4fbbdebb1c498" "f55abc032de4012ab8ad7eb105081b842e0e33a6ac76b768de302aac00970e4a" "8d2bfaae8e1fd2407ed91693b51c9d8549e088e6e7782e8f6a494c7324bb2391" "798d590d01a6f8f3a3d271d6174a4015b67cc56052d8e9504c26c5d135c717ce" "f3bb8d4b4eb19b0bf37220c75290ae2414fe17609aa8f6aef7789fc6a1618e78" "d5377f0e4c9e8552dbf37871833733d4f28024aa98f9b83706cd6c74ce383eca" "1d6a3012bc692ef38b81793d45032db33eab37645dcedc4f1bf7d0b7cf022d1b" "5bfd841dd5155e98e8e5ed30f2000b986858213b290af5e4f41fb1a981a35ac2" "eeebb8760eb584567f5bcd8508b75b369ba67817c8f7ec6d5093a1aa8c55779b" "425870cc1663c91047203407036bf159587244591e6ac9acc15cb5bd8f37dbd5" "edd734a436b02d77ef75c47d7afbb6ca1ae5897a6a5c1b95423ce100bf9d3117" "a65f7d2bf7805747ac8b6d8a3a5f612310a768b8eced07f74b4c5baa2abee0dd" "802e7a1f59c36b0bebdc07efc6cd31d89bd4f864f153a6ef0b7d4eae617d5eab" "e5860e977cb41771eba4d046812f8983852d9ce50af0eb861b1d17f1725e6a8d" "66d17580694f557810782323f7300d0141b3e7b75980bf58dbd20285fab263f9" "f1a730c87b8cce29da188a5b7ce0e10b8486a610ff86e9a8e3e3b182f3be4528" "07cda797d373fb8ebe95e6523917206a1ade362cdf09cadddb26d229c09e7a55" "aa328acdf023066492e4584e8b586ff97596af29f1fc9f6804fb2097f2c76bf3" "60742fbe4bc1777ab92e37bb892cfac216092fd2ca66161fbacadffd0884bdd4" "5086409627a354e868a669fb02b1b00c3febc790efba49e69b2afcafc1d616b4" "5f18a938ab14286b2da7764974cfe8e1215dc12a2fc17fa7ba8b3bd0f2256613" "9fad772a1ad13df74806c13504c6b5df2cc222c91ee8f883fed77cc1c4ac2f5b" "2d8a894998f931237e4d3b774e080092450b7b01d449cb777b558ecaedb0a49b" "24cef59ef50cd46504ec7bd443ab45b5b062448c1a3be31723a0433315e285c4" "f0b8f0479d7b9ec451d215fd731f583e410e5a58907338531cf6c282abd6f4c1" "cd3a9ef301a54f4b27b106fd0ba9702d826c08a03d0ba1c6fb182dece503b526" "e2b8e449040fdbcaab8343af919cc93cd00c9a32f6bb15e574b6fc226bcc2529" "ec013d20292a08448fc6cc8917f4db308a3ff75cc059eec84eaedb3480e78a88" "31be917e7ac0b4a2b715c4a2858b46658630c6cbe1a1092b594d84ea30923d0e" "ccd03a22a0a66d11b275148ee7b3c358295117d5d17dce4965d38e2ce9370196" "e6bd2df77fd1edd2cefc7f5d29db00d4640c677da0f1934cc3445818d1b0784b" "cb9f954ea4193568593072ca39fdcb680205f80f8b3c7711e490cf9ef9ef83ba" "44704a58a4e81e4c4159f4045484515ab5ac472af2d6f40da3b580ca9639c3e9" "ce59b2696a8cac082069e45dc609850a4c696f370e64f2a7cf2bb416528b979f" "6c3fa5ae2483817a63f4d96af79250e8df48aa43dfd8db31bf805bba7b0e3d17" "a872cd5d932186e242fa4036a07f862e62694666438d42d06eb62497b84e757f" "e76da062cd34b227bbf2ce68dd7007301d4c56d8fe026c2460b7b27c4bb1db9e" "fddf128e283fa3440cd9bdf8873c65f2a8e82da46ac32837d623e854570a5a67" "185e6964ae820be6f9c6072a56fbd083a625ab35095a10a47455623ca5b2d383" "8f034ff240bfe21257f557c61ea444c300450e84e187885802dc9fee7d12fa5d" default)))
 '(dabbrev-abbrev-char-regexp "[0-9a-zA-Z_]")
 '(default-text-scale-mode t nil (default-text-scale))
 '(dimmer-fraction 0.4)
 '(dimmer-use-colorspace :cielab)
 '(display-buffer-alist (quote (("shell" display-buffer-same-window (nil)))))
 '(fci-rule-color "#6272a4")
 '(find-file-run-dired nil)
 '(find-file-suppress-same-file-warnings t)
 '(find-file-visit-truename t)
 '(flycheck-check-syntax-automatically (quote (save mode-enabled)))
 '(flycheck-perl-include-path
   (quote
    ("/Users/schellj/gtperl" "~/gtperl" "/Users/schellj/src/gt-core/lib" "~/src/gt-core/lib")))
 '(git-commit-summary-max-length 100)
 '(git-gutter-fr:added-sign "+")
 '(git-gutter-fr:deleted-sign "-")
 '(git-gutter-fr:diff-option "-w")
 '(git-gutter-fr:hide-gutter t)
 '(git-gutter-fr:modified-sign "!")
 '(git-gutter-fr:unchanged-sign " ")
 '(git-gutter-fr:visual-line t)
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:diff-option "-w")
 '(git-gutter:hide-gutter t)
 '(git-gutter:modified-sign "!")
 '(git-gutter:unchanged-sign " ")
 '(git-gutter:visual-line t)
 '(global-column-enforce-mode t)
 '(global-flycheck-mode nil)
 '(helm-mode nil)
 '(ivy-extra-directories nil)
 '(jdee-db-active-breakpoint-face-colors (cons "#1E2029" "#bd93f9"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1E2029" "#50fa7b"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1E2029" "#565761"))
 '(line-number-mode nil)
 '(magit-branch-arguments nil)
 '(magit-commit-arguments nil)
 '(magit-commit-ask-to-stage t)
 '(magit-commit-extend-override-date nil)
 '(magit-commit-reword-override-date nil)
 '(magit-diff-arguments
   (quote
    ("--ignore-space-change" "--ignore-all-space" "--no-ext-diff")))
 '(magit-diff-expansion-threshold 1.0)
 '(magit-diff-refine-hunk (quote all))
 '(magit-diff-section-arguments (quote ("--no-ext-diff")))
 '(magit-popup-show-common-commands t)
 '(magit-popup-use-prefix-argument (quote default))
 '(magit-process-popup-time -1)
 '(magit-revert-buffers (quote silent) t)
 '(magit-revision-show-gravatars (quote ("^Author:     " . "^Commit:     ")))
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 1) ((control)))))
 '(ns-antialias-text t)
 '(ns-auto-hide-menu-bar nil)
 '(ns-use-native-fullscreen t)
 '(package-selected-packages
   (quote
    (spaceline which-key hydra csharp-mode general dumb-jump auto-dim-other-buffers flx use-package smartparens rainbow-delimiters volatile-highlights beacon dimmer ivy-hydra git-gutter-fringe counsel-projectile counsel swiper ivy yaml-mode default-text-scale markdown-mode+ markdown-mode column-enforce-mode edit-server xterm-color w3m ucs-utils ucs-cmds flim apel go-mode python-mode highlight-numbers exec-path-from-shell spinner flycheck php-mode js2-mode cperl-mode magit forge)))
 '(projectile-mode t nil (projectile))
 '(projectile-switch-project-action (quote projectile-ag))
 '(py-tab-indent t)
 '(rainbow-delimiters-max-face-count 6)
 '(scroll-bar-mode nil)
 '(send-mail-function (quote mailclient-send-it))
 '(smerge-command-prefix (kbd "s-m"))
 '(sp-show-pair-from-inside t)
 '(switch-to-buffer-preserve-window-point t)
 '(tab-width 4)
 '(term-buffer-maximum-size 20000)
 '(vc-annotate-background "#282a36")
 '(vc-annotate-color-map
   (list
    (cons 20 "#50fa7b")
    (cons 40 "#85fa80")
    (cons 60 "#bbf986")
    (cons 80 "#f1fa8c")
    (cons 100 "#f5e381")
    (cons 120 "#face76")
    (cons 140 "#ffb86c")
    (cons 160 "#ffa38a")
    (cons 180 "#ff8ea8")
    (cons 200 "#ff79c6")
    (cons 220 "#ff6da0")
    (cons 240 "#ff617a")
    (cons 260 "#ff5555")
    (cons 280 "#d45558")
    (cons 300 "#aa565a")
    (cons 320 "#80565d")
    (cons 340 "#6272a4")
    (cons 360 "#6272a4")))
 '(vc-annotate-very-old-color nil)
 '(vc-follow-symlinks t)
 '(vc-git-diff-switches "-b")
 '(vline-idle-time 0.5)
 '(vline-visual nil)
 '(whitespace-style
   (quote
    (face trailing tabs empty indentation::space indentation space-after-tab::tab space-after-tab::space space-after-tab space-before-tab::tab space-before-tab::space space-before-tab))))

(when (>= emacs-major-version 24)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-autoremove)
  (package-install-selected-packages))

(setq-default indent-tabs-mode nil)
(setq
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

 js2-mode-show-parse-errors t
 js2-mode-show-strict-warnings nil
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

;;; backup/autosave
(defvar backup-dir (expand-file-name "~/.emacs.d/backup"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave"))
(setq backup-directory-alist (list (cons ".*" backup-dir))
      auto-save-list-file-prefix autosave-dir
      auto-save-file-name-transforms `((".*" ,autosave-dir t))
      create-lockfiles nil)

(require 'ffap)
(add-to-list 'ffap-alist '(shell-mode . ffap-gits-src))
(add-to-list 'ffap-alist '(shell-mode . ffap-gits-current))
(add-to-list 'ffap-alist '(term-mode . ffap-gits-src))
(add-to-list 'ffap-alist '(term-mode . ffap-gits-current))

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
;               (unless (fsm-frame-x-active-window-p (selected-frame)) ding)
;               (ding)
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

;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; (add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
;;  (add-hook 'eshell-preoutput-filter-functions
;;            'ansi-color-filter-apply)

(global-font-lock-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(default-text-scale-mode t)
(desktop-save-mode 1)

(set-display-table-slot standard-display-table 'wrap ?·)
;; (set-display-table-slot standard-display-table 'vertical-border ?│)

(require 'compile)
(add-hook 'perl-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (concat "perl -c " (file-name-nondirectory buffer-file-name)))))

;(add-hook 'after-init-hook #'global-flycheck-mode)
(if (memq window-system '(mac ns))
    (progn
      (require 'exec-path-from-shell)
      (exec-path-from-shell-initialize)
      (set-scroll-bar-mode nil)
      (load-theme 'schellj-gui t)
      (fringe-mode '(2 . 2)))
  (load-theme 'schellj-terminal t))

(use-package tramp
  :config
  (setq tramp-connection-timeout 10)
  (add-to-list 'tramp-methods
               '("gssh"
                 (tramp-login-program        "gssh")
                 (tramp-login-args           (("%h")))
                 (tramp-async-args           (("-q")))
                 (tramp-remote-shell         "/bin/sh")
                 (tramp-remote-shell-args    ("-c"))
                 (tramp-gw-args              (("-o" "GlobalKnownHostsFile=/dev/null")
                                              ("-o" "UserKnownHostsFile=/dev/null")
                                              ("-o" "StrictHostKeyChecking=no")))
                 (tramp-default-port         22))))

(use-package magit)

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
   beacon-color "#333333"
   beacon-mode t
   beacon-size 100))

(use-package volatile-highlights
  :config
  (volatile-highlights-mode t)
  (run-with-idle-timer 1 t #'vhl/clear-all))

(use-package rainbow-delimiters
  :config
  (setq rainbow-delimiters-max-face-count 6)
  :hook (cperl-mode . rainbow-delimiters-mode))

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
  :init
  (defhydra hydra-git-gutter (global-map "s-d" :pre (ignore-errors (git-gutter:popup-hunk)) :post (kill-matching-buffers-no-ask "*git-gutter:diff*"))
    "git-gutter"
    ("=" git-gutter:popup-hunk "hunk at cursor")
    ("n" git-gutter:next-hunk "next hunk")
    ("p" git-gutter:previous-hunk "previous hunk")
    ("k" git-gutter:revert-hunk "kill hunk")))

(use-package git-gutter-fringe
  :config
  (global-git-gutter-mode t))

(use-package smartparens
  :bind
  (("M-p" . sp-backward-sexp)
   ("M-n" . sp-forward-sexp))
  :init
  (smartparens-global-mode)
  (show-smartparens-global-mode)
  (smartparens-global-mode 0))

(use-package cperl-mode
  :mode ("/t/.*\\.t\\'" "\\.pm\\'" "\\.pl\\'")
  :interpreter ("perl")
  :hook
  (cperl-mode . (lambda () (add-hook 'before-save-hook 'whitespace-cleanup nil t)))
  :config
  (setq
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
;; (add-to-list 'auto-mode-alist '("\\.pm\\'" . perltidy-mode))
;; (add-to-list 'auto-mode-alist '("\\.pl\\'" . perltidy-mode))

(use-package js2-mode
  :mode ("/architect.*view" "\\.js\\'")
  :hook (js2-mode . (lambda() (add-hook 'before-save-hook 'whitespace-cleanup nil t))))

(use-package objc-mode
  :mode "/rop-console-ios/.*\\.[hm]\\'")

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
  :config (counsel-projectile-mode +1))

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
   dumb-jump-use-visible-window t)
  :ensure)

(use-package which-key
  :ensure
  :config
  (setq which-key-idle-delay 2.0)
  :init
  (which-key-mode))

(use-package spaceline-config
  :config
  (spaceline-define-segment buffer-line-count
    "<CURRENT_LINE>/<BUFFER_LINES> <COLUMN_NUMBER>"
    (format "%%l/%d %%c" (count-lines (point-min) (point-max))))
  (setq powerline-default-separator "rounded"
        spaceline-separator-dir-left '(left . left)
        spaceline-separator-dir-right '(right . right)
        spaceline-highlight-face-func 'spaceline-highlight-face-modified)
  (spaceline-compile "jschell"
    '((buffer-modified :priority 98 :face highlight-face)
      (buffer-line-count :priority 97)
      (remote-host :priority 94)
      (projectile-root :priority 93)
      (buffer-id :priority 95)
      (version-control :priority 78))
    '((selection-info :priority 95)
      (major-mode :priority 79)
      (global :when active)))
  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-jschell)))))
