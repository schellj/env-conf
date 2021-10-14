;;; js2-refactor-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2-refactor"
;;;;;;  "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2-refactor.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2-refactor.el

(autoload 'js2-refactor-mode "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2-refactor" "\
Minor mode providing JavaScript refactorings.

If called interactively, toggle `Js2-Refactor mode'.  If the
prefix argument is positive, enable the mode, and if it is zero
or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(autoload 'js2r-add-keybindings-with-prefix "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2-refactor" "\
Add js2r keybindings using the prefix PREFIX.

\(fn PREFIX)" nil nil)

(autoload 'js2r-add-keybindings-with-modifier "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2-refactor" "\
Add js2r keybindings using the modifier MODIFIER.

\(fn MODIFIER)" nil nil)

(register-definition-prefixes "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2-refactor" '("js2"))

;;;***

;;;### (autoloads nil "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-conditionals"
;;;;;;  "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-conditionals.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-conditionals.el

(register-definition-prefixes "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-conditionals" '("js2r-ternary-to-if"))

;;;***

;;;### (autoloads nil "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-conveniences"
;;;;;;  "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-conveniences.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-conveniences.el

(register-definition-prefixes "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-conveniences" '("js2r-" "move-line-"))

;;;***

;;;### (autoloads nil "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-formatting"
;;;;;;  "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-formatting.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-formatting.el

(register-definition-prefixes "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-formatting" '("js2r-"))

;;;***

;;;### (autoloads nil "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-functions"
;;;;;;  "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-functions.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-functions.el

(register-definition-prefixes "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-functions" '("js2r-"))

;;;***

;;;### (autoloads nil "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-helpers"
;;;;;;  "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-helpers.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-helpers.el

(register-definition-prefixes "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-helpers" '("js2r--"))

;;;***

;;;### (autoloads nil "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-iife"
;;;;;;  "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-iife.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-iife.el

(register-definition-prefixes "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-iife" '("js2r-"))

;;;***

;;;### (autoloads nil "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-paredit"
;;;;;;  "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-paredit.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-paredit.el

(register-definition-prefixes "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-paredit" '("js2r-"))

;;;***

;;;### (autoloads nil "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-vars"
;;;;;;  "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-vars.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-vars.el

(autoload 'js2r-extract-var "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-vars" nil t nil)

(autoload 'js2r-extract-let "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-vars" nil t nil)

(autoload 'js2r-extract-const "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-vars" nil t nil)

(register-definition-prefixes "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-vars" '("current-line-contents" "js2r-"))

;;;***

;;;### (autoloads nil "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-wrapping"
;;;;;;  "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-wrapping.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-wrapping.el

(register-definition-prefixes "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2r-wrapping" '("js2r-"))

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2-refactor-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/js2-refactor-20190630.2108/js2-refactor-pkg.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; js2-refactor-autoloads.el ends here
