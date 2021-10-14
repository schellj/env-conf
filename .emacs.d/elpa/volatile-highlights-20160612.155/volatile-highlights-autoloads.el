;;; volatile-highlights-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "../../../../../.emacs.d/elpa/volatile-highlights-20160612.155/volatile-highlights"
;;;;;;  "../../../../../.emacs.d/elpa/volatile-highlights-20160612.155/volatile-highlights.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/volatile-highlights-20160612.155/volatile-highlights.el

(defvar volatile-highlights-mode nil "\
Non-nil if Volatile-Highlights mode is enabled.
See the `volatile-highlights-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `volatile-highlights-mode'.")

(let ((exp 'nil)) (put 'volatile-highlights-mode 'standard-value (list exp)) (custom-initialize-default 'volatile-highlights-mode exp))

(custom-autoload 'volatile-highlights-mode "../../../../../.emacs.d/elpa/volatile-highlights-20160612.155/volatile-highlights" nil)

(autoload 'volatile-highlights-mode "../../../../../.emacs.d/elpa/volatile-highlights-20160612.155/volatile-highlights" "\
Minor mode for visual feedback on some operations.

If called interactively, toggle `Volatile-Highlights mode'.  If
the prefix argument is positive, enable the mode, and if it is
zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "../../../../../.emacs.d/elpa/volatile-highlights-20160612.155/volatile-highlights" '("Vhl/highlight-zero-width-ranges" "vhl/"))

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/volatile-highlights-20160612.155/volatile-highlights-autoloads.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; volatile-highlights-autoloads.el ends here
