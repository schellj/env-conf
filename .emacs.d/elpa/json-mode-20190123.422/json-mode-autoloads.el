;;; json-mode-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "../../../../../.emacs.d/elpa/json-mode-20190123.422/json-mode"
;;;;;;  "../../../../../.emacs.d/elpa/json-mode-20190123.422/json-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/json-mode-20190123.422/json-mode.el

(defconst json-mode-standard-file-ext '(".json" ".jsonld") "\
List of JSON file extensions.")

(defsubst json-mode--update-auto-mode (filenames) "\
Update the `json-mode' entry of `auto-mode-alist'.

FILENAMES should be a list of file as string.
Return the new `auto-mode-alist' entry" (let* ((new-regexp (rx-to-string `(seq (eval (cons 'or (append json-mode-standard-file-ext ',filenames))) eot))) (new-entry (cons new-regexp 'json-mode)) (old-entry (when (boundp 'json-mode--auto-mode-entry) json-mode--auto-mode-entry))) (setq auto-mode-alist (delete old-entry auto-mode-alist)) (add-to-list 'auto-mode-alist new-entry) new-entry))

(defvar json-mode-auto-mode-list '(".babelrc" ".bowerrc" "composer.lock") "\
List of filename as string to pass for the JSON entry of
`auto-mode-alist'.

Note however that custom `json-mode' entries in `auto-mode-alist'
won’t be affected.")

(custom-autoload 'json-mode-auto-mode-list "../../../../../.emacs.d/elpa/json-mode-20190123.422/json-mode" nil)

(defvar json-mode--auto-mode-entry (json-mode--update-auto-mode json-mode-auto-mode-list) "\
Regexp generated from the `json-mode-auto-mode-list'.")

(autoload 'json-mode "../../../../../.emacs.d/elpa/json-mode-20190123.422/json-mode" "\
Major mode for editing JSON files

\(fn)" t nil)

(add-to-list 'magic-fallback-mode-alist '("^[{[]$" . json-mode))

(autoload 'json-mode-show-path "../../../../../.emacs.d/elpa/json-mode-20190123.422/json-mode" "\
Print the path to the node at point to the minibuffer, and yank to the kill ring." t nil)

(autoload 'json-mode-kill-path "../../../../../.emacs.d/elpa/json-mode-20190123.422/json-mode" nil t nil)

(autoload 'json-mode-beautify "../../../../../.emacs.d/elpa/json-mode-20190123.422/json-mode" "\
Beautify / pretty-print the active region (or the entire buffer if no active region)." t nil)

(register-definition-prefixes "../../../../../.emacs.d/elpa/json-mode-20190123.422/json-mode" '("json-"))

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/json-mode-20190123.422/json-mode-autoloads.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; json-mode-autoloads.el ends here
