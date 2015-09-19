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
      (schellj-white          "#ffffff")
      (schellj-fg             "#fafaf4")
      (schellj-red            "#ff0000")
      (schellj-pink           "#ff005c")
      (schellj-orange+5       "#ef5939")
      (schellj-orange         "#FC9317")
      (schellj-yellow         "#ffff00")
      (schellj-darkgoldenrod  "#F0E262")
      (schellj-wheat          "#c4be89")
      (schellj-olive          "#808000")
      (schellj-chartreuse     "#a6e22e")
      (schellj-lime           "#00ff00")
      (schellj-green          "#008000")
      (schellj-darkwine       "#1e0010")
      (schellj-maroon         "#800000")
      (schellj-wine           "#960050")
      (schellj-teal           "#008080")
      (schellj-aqua           "#00ffff")
      (schellj-blue           "#66d9ef")
      (schellj-medium-blue    "#3333ff")
      (schellj-lightblue      "#8888ff")
      (schellj-slateblue      "#7070f0")
      (schellj-lightaqua      "#00cccc")
      (schellj-purple         "#ae81ff")
      (schellj-palevioletred  "#d33682")
      (schellj-grey-2         "#bcbcbc")
      (schellj-grey-1         "#8f8f8f")
      (schellj-grey           "#808080")
      (schellj-grey+2         "#403d3d")
      (schellj-grey+3         "#4c4745")
      (schellj-grey+5         "#232526")
      (schellj-bg             "#292929")
      (schellj-bg-1           "#191919")
      (schellj-grey+10        "#080808")
      (schellj-dark           "#000000")
      (schellj-base01         "#465457")
      (schellj-base02         "#455354")
      (schellj-base03         "#293739")
      (schellj-dodgerblue     "#13354a"))
  (custom-theme-set-faces
   'schellj-gui

   ;; base
   `(default ((t (:background ,schellj-bg :foreground ,schellj-fg))))
   `(cursor ((t (:background ,schellj-grey-2 :foreground ,schellj-bg))))
   `(fringe ((t (:foreground ,schellj-grey+2 :background "#1e1e1e"))))
   `(highlight ((t (:background ,schellj-grey))))
   `(region ((t (:background  ,schellj-grey+2))
             (t (:inverse-video t))))
   `(warning ((t (:foreground ,schellj-palevioletred))))

   ;; font lock
   `(font-lock-builtin-face ((t (:foreground ,schellj-chartreuse))))
   `(font-lock-comment-face ((t (:foreground ,schellj-base01))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,schellj-base01))))
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
   `(font-lock-warning-face ((t (:foreground ,schellj-palevioletred))))

   ;; mode line
   `(mode-line ((t (:foreground ,schellj-fg
                                :background ,schellj-grey+2
                                :box nil))))
   ;; `(mode-line-buffer-id ((t (:weight bold))))
   `(mode-line-inactive ((t (:foreground ,schellj-fg
                                         :background ,schellj-bg-1
                                         :box nil))))

   `(vertical-border ((t (:foreground ,schellj-grey+2 :background ,schellj-bg))))

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

   ;; TODO
   ;; ido-mode
   ;; flycheck
   ;; show-paren
   ;; rainbow-delimiters
   ;; highlight-symbols
   ))

(defcustom schellj-theme-kit nil
  "Non-nil means load schellj-theme-kit UI component"
  :type 'boolean
  :group 'schellj-theme)

(defcustom schellj-theme-kit-file
  (concat (file-name-directory
           (or (buffer-file-name) load-file-name))
          "schellj-theme-kit.el")
  "schellj-theme-kit-file"
  :type 'string
  :group 'schellj-theme)

(if (and schellj-theme-kit
         (file-exists-p schellj-theme-kit-file))
    (load-file schellj-theme-kit-file))

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
