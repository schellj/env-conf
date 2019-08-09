;;; molokai-theme.el --- Yet another molokai theme for Emacs 24

;; Copyright (C) 2013 Huang Bin

;; Author: Huang Bin <embrace.hbin@gmail.com>
;; URL: https://github.com/hbin/molokai-theme
;; Version: 0.8

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; This is another molokai dark theme for Emacs 24.
;; Equiped with my favorites.

;;; Requirements:
;;
;; Emacs 24

;;; Code:
(deftheme schellj-gui "The schellj color theme for Emacs 25 OS X GUI")

(let ((class '((class color) (min-colors 89)))
      ;; schellj palette
      (schellj-aqua           "#00ffff")
      (schellj-base01         "#465457")
      (schellj-base02         "#455354")
      (schellj-base03         "#293739")
      (schellj-bg             "#111111")
      (schellj-bg-1           "#191919")
      (schellj-bg-2           "#693939")
      (schellj-bg-old         "#1b1b1b")
      (schellj-blue           "#66d9ef")
      (schellj-brightgreen    "#00a000")
      (schellj-chartreuse     "#a6e22e")
      (schellj-dark           "#000000")
      (schellj-darkblue       "#4455aa")
      (schellj-darkgoldenrod  "#F0E262")
      (schellj-darkred        "#700000")
      (schellj-darkred2       "#903333")
      (schellj-darkwine       "#1e0010")
      (schellj-dodgerblue     "#13354a")
      (schellj-fg             "#f8f8f8")
      (schellj-green          "#008000")
      (schellj-grey           "#808080")
      (schellj-grey+10        "#080808")
      (schellj-grey+2         "#403d3d")
      (schellj-grey+3         "#4c4745")
      (schellj-grey+5         "#232526")
      (schellj-grey-1         "#8f8f8f")
      (schellj-grey-2         "#bcbcbc")
      (schellj-lightaqua      "#00cccc")
      (schellj-lightblue      "#8888ff")
      (schellj-lime           "#00ff00")
      (schellj-maroon         "#800000")
      (schellj-medium-blue    "#3333ff")
      (schellj-olive          "#808000")
      (schellj-orange         "#FC9317")
      (schellj-orange+5       "#ef5939")
      (schellj-palevioletred  "#d33682")
      (schellj-pink           "#ff005c")
      (schellj-purple         "#ae81ff")
      (schellj-red            "#ff0000")
      (schellj-slateblue      "#7070f0")
      (schellj-teal           "#008080")
      (schellj-wheat          "#c4be89")
      (schellj-white          "#ffffff")
      (schellj-wine           "#960050")
      (schellj-yellow         "#ffff00"))
  (custom-theme-set-faces
   'schellj-gui

   ;; base
   `(default ((t (:inherit nil
                           :stipple nil
                           :background ,schellj-bg
                           :foreground ,schellj-fg
                           :inverse-video nil
                           :box nil
                           :strike-through nil
                           :overline nil
                           :underline nil
                           :slant normal
                           :weight normal
                           :height 120
                           :width normal
                           :foundry "nil"
                           :family "Monaco"))))
   `(bold ((t (:weight normal))))
   `(term ((t (:background ,schellj-bg :foreground ,schellj-fg))))
   `(cursor ((t (:background ,schellj-fg :foreground ,schellj-bg))))
   `(fringe ((t (:foreground ,schellj-grey+2 :background "#1e1e1e"))))
   `(highlight ((t (:background ,schellj-grey+2))))
   `(magit-diff-context-highlight ((t (:background ,schellj-grey+2))))
   `(region ((t (:background  ,schellj-grey+2))
             (t (:inverse-video t))))
   `(warning ((t (:foreground ,schellj-palevioletred))))

   ;; font lock
   `(font-lock-builtin-face ((t (:foreground ,schellj-chartreuse))))
   `(font-lock-comment-face ((t (:foreground ,schellj-grey-1))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,schellj-grey-1))))
   `(font-lock-constant-face ((t (:foreground ,schellj-purple))))
   `(font-lock-doc-string-face ((t (:foreground ,schellj-darkgoldenrod))))
   `(font-lock-function-name-face ((t (:foreground ,schellj-lightblue))))
   `(font-lock-keyword-face ((t (:foreground ,schellj-pink))))
   `(font-lock-negation-char-face ((t (:foreground ,schellj-yellow))))
   `(font-lock-preprocessor-face ((t (:inherit (font-lock-builtin-face)))))
   `(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
   `(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
   `(font-lock-string-face ((t (:foreground ,schellj-darkgoldenrod))))
   `(font-lock-type-face ((t (:foreground ,schellj-lightaqua))))
   `(font-lock-variable-name-face ((t (:foreground ,schellj-orange))))
   `(font-lock-warning-face ((t (:foreground nil :background ,schellj-bg-2))))
   `(column-enforce-face ((t (:foreground nil :background ,schellj-darkred))))

   `(vertical-border ((t (:foreground "#204020" :background ,schellj-bg))))

   ;; search
   `(isearch ((t (:foreground ,schellj-dark :background ,schellj-wheat))))
   `(isearch-fail ((t (:foreground ,schellj-wine :background ,schellj-darkwine))))

   ;; linum-mode
   `(linum ((t (:foreground ,schellj-grey-2 :background ,schellj-grey+5))))

   ;; hl-line-mode
   `(hl-line-face ((,class (:background ,schellj-grey+5)) t))
   `(hl-line ((,class (:background ,schellj-grey+5)) t))

   `(cperl-hash-face ((,class (:foreground ,schellj-red :background ,schellj-dark :slant normal))))
   `(cperl-array-face ((,class (:foreground ,schellj-yellow :background ,schellj-dark :slant normal))))

   `(col-highlight ((t (:background ,schellj-grey+3)) t))
   `(vline ((t (:background ,schellj-grey+3)) t))
   ;; TODO
   ;; ido-mode
   ;; flycheck
   ;; show-paren
   ;; highlight-symbols
   `(git-gutter-fr:modified ((t (:height 50 :foreground ,schellj-blue :background ,schellj-blue))))
   `(git-gutter-fr:added ((t (:height 50 :foreground ,schellj-brightgreen :background ,schellj-brightgreen))))
   `(git-gutter-fr:deleted ((t (:height 50 :foreground ,schellj-red :background ,schellj-red))))
   `(git-gutter-fr:unchanged ((t (:height 50 :foreground ,schellj-dark :background ,schellj-dark))))

   `(show-paren-match ((t :background ,schellj-darkblue)))
   `(show-paren-mismatch ((t :background ,schellj-darkred2)))

   `(auto-dim-other-buffers-face ((t (:foreground "#bbbbbb" :background "#222222"))))
   `(comint-highlight-prompt ((t nil)))
   `(eshell-prompt ((t nil)))
   `(sp-show-pair-enclosing ((t (:inherit highlight))))
   `(window-divider ((t (:foreground "#666666"))))))

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'schellj-gui)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; schellj-theme.el ends here
