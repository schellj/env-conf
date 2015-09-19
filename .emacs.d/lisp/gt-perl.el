;;;  Copyright (c) 2004-2007 bivio Software, Inc.  All rights reserved.
;;; 
;;;  Visit http://www.bivio.biz for more info.
;;;  
;;;  This library is free software; you can redistribute it and/or modify
;;;  it under the terms of the GNU Lesser General Public License as
;;;  published by the Free Software Foundation; either version 2.1 of the
;;;  License, or (at your option) any later version.
;;;  
;;;  This library is distributed in the hope that it will be useful, but
;;;  WITHOUT ANY WARRANTY; without even the implied warranty of
;;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;;;  Lesser General Public License for more details.
;;;  
;;;  You should have received a copy of the GNU Lesser General Public
;;;  License along with this library;  If not, you may get a copy from:
;;;  http://www.opensource.org/licenses/lgpl-license.html
;;;  
;;;  $Id: gt-perl.el,v 1.79 2013/01/10 05:49:11 nagler Exp $
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Perl (cperl-mode)
;;;
(provide 'gt-perl)
;; (load-library "cperl-mode")
(load-library "cl")
(load-library "thingatpt")
(defconst gt-perl-src-re "\\(.*/src/\\)/")
(defvar gt-perl-use-version-5-6 t
  "*If you are using Perl 5.6.x or above, leave this attribute as t.  Otherwise, set it to nil.")

(defun gt-perl ()
  "gt-perl provides configuration and functions to format your Perl.  gt-perl is built on cperl-mode, which it
installs as a replacement for perl-mode.

The following key bindings are defined when you load this file:

key             binding
---             -------
C-c b           gt-perl-call-super
C-c f           gt-perl-find-module
C-c p           gt-perl-man-builtin
C-c r		gt-perl-refactor-rename-method
C-c s		gt-perl-insert-method
C-c v		gt-perl-insert-variable
C-c u           gt-perl-insert-use
C-c w           gt-perl-insert-role
C-c h           gt-perl-insert-has
C-c t           gt-perl-template

"
  (interactive)
  (describe-function 'gt-perl))

;; (add-hook 'cperl-mode-hook
;; 	  '(lambda ()
;; 	     (cperl-set-style "PerlStyle")
;; 	     (setq cperl-continued-statement-offset 4)
;; 	     (setq cperl-merge-trailing-else nil)
;; 	     (setq cperl-tab-always-indent t)
;; 	     (set (make-local-variable 'compile-command)
;; 	     	   (gt-perl-compile-command))
;; 	     (if (>= (string-to-number cperl-version) 5.0)
;; 		 (progn
;; 		   (setq cperl-close-paren-offset -4)
;; 		   (setq cperl-brace-offset 0)
;; 		   (setq cperl-indent-parens-as-block t)
;; 		   (set (make-local-variable 'dabbrev-abbrev-char-regexp)
;; 			"\\sw\\|\\s_\\|:")))
;; 	     (if (>= (string-to-number cperl-version) 6.0)
;; 		 (progn
;; 		   (setq cperl-continued-brace-offset -4)
;; 		   (setq cperl-indent-parens-as-block t)))
;; 	  ))

(defun gt-perl-call-super nil
  "Generates a call to SUPER::<current sub>"
  (interactive)
  (let
      ((start (point)))
    (insert
     "return shift->SUPER::"
     (save-excursion
       (re-search-backward "^sub ")
       (forward-word 2)
       (thing-at-point 'gt-perl-word))
     "(@_);")
    (cperl-indent-region start (point))))

(defun gt-perl-compile-command nil
  "Returns a string compile-command."
  (concat
   "PERLLIB=~/gtperl perl -w "
   (file-name-nondirectory buffer-file-name)))

(defun gt-perl-man-builtin nil
  "Shows perlfunc man page entry for function at point"
  (interactive)
  (let ((builtin (read-string "Perl builtin: " (thing-at-point 'gt-perl-word))))
    (man "perlfunc")
    (save-excursion
      (other-window 1)
      (goto-char (point-min))
      (re-search-forward
       (concat "^       "  builtin  "\\( \\|$\\)"))))
  (other-window -1))
  
(defun gt-perl-do-insert-variable (name value &optional is-our)
  (goto-char (point-min))
  (re-search-forward "^sub ")
  (if (re-search-backward "^\\(our\\|my\\)(" nil t)
      (re-search-forward "^$")
    (re-search-backward "^$")
    (insert "\n"))
  (if name
      (insert
       (if is-our "our" "my")
       "($_"
       (upcase name)
       ")"
       (if value (concat " = " value) "")
       ";\n") 
    (if value (insert value))))
  
(defun gt-perl-do-insert-method (name body type)
    (goto-char (point-max))
    (re-search-backward "^1;$")
    (re-search-backward "^__PACKAGE__->meta->make_immutable;$" nil t)
    (let ((found nil)
	  (last (point)))
      (catch 'loop
	(while (re-search-backward "^sub \\([_a-zA-Z0-9]+\\)" nil t)
	  (setq found (match-string 1))
	  (cond
	   ((eq 'CONSTANT type) (if (and (string-match "^[A-Z]" found)
					 (string< found name))
				    (throw 'loop (goto-char last))))
	   ((eq 'PRIVATE type) (if (or (not (string-match "^_" found))
				       (string< found name))
				    (throw 'loop (goto-char last))))
	   (t (if (or (and (string-match "^[a-z]" found)
			   (string< found name))
		      (string-match "^[A-Z]" found))
		  (throw 'loop (goto-char last)))))
	  (setq last (point)))))
    (if name
	(progn
	  (insert "sub " name " {\n}\n\n")
	  (forward-char -4)))
    (if body
	(insert body))
    (if (re-search-backward "@@" nil t)
	(delete-char 2)))

(defun gt-perl-do-insert-package-element (element keyword quoted op)
  "Insert package element (role, attribute, etc)"
  (if (not element)
      (setq element (read-string (concat keyword ": "))))
  (let ((start (point))
	(startmax (point-max))
	(quote (if quoted "'" "")))
    (goto-char (point-min))
    (if (re-search-forward (concat "^" keyword " " quote element quote) nil t)
	(progn
	  (message "%s" (concat element " already being used"))
	  (goto-char start))
      (re-search-forward "^use Moose;$" nil t)
      (re-search-forward "^extends " nil t)
      (if (funcall op element)
	  (progn
	    (setq current (point))
	    (if (> start current) (goto-char (+ start (- (point-max) startmax))))))
      (message "%s" (concat element " inserted")))))

(defconst gt-perl-word-chars "A-Za-z0-9_:")
(put 'gt-perl-word 'end-op
     (lambda () (skip-chars-forward gt-perl-word-chars)))
(put 'gt-perl-word 'beginning-op
     (lambda () (skip-chars-backward gt-perl-word-chars)))

(defconst gt-perl-module-chars (concat gt-perl-word-chars "."))
(put 'gt-perl-module 'end-op
     (lambda () (skip-chars-forward gt-perl-module-chars)))
(put 'gt-perl-module 'beginning-op
     (lambda () (skip-chars-backward gt-perl-module-chars)))

(defun gt-perl-insert-use ()
  "Add word at point as import or prompt"
  (interactive)
  (let
      ((module (thing-at-point 'gt-perl-word)))
    (unless module (setq module ""))
    (gt-perl-do-insert-package-element 
     (if (string-match "\\:\\:" module) module nil) 
     "use" 
     nil
     #'(lambda (element) 
       (if (re-search-forward "^use " nil t)
	   (progn
	     (goto-char (point-max))
	     (re-search-backward "^use "))
	 (re-search-forward "^$")
	 (insert "\n"))
       (re-search-forward "^$")
       (insert "use " element ";\n")
       1))))

(defun gt-perl-insert-role ()
  "Add role"
  (interactive)
  (gt-perl-do-insert-package-element 
   nil "with" t #'(lambda (element)
		  (if (re-search-forward "^with " nil t)
		      (progn
			(goto-char (point-max))
			(re-search-backward "^with ")))
		  (re-search-forward ";")
		  (insert "\nwith '" element "';")
		  1)))

(defun gt-perl-insert-has ()
  "Add attribute"
  (interactive)
  (gt-perl-do-insert-package-element
   nil "has" nil #'(lambda (element)
		 (setq element-hash (make-hash-table))
		 (puthash "is" (read-string "is: ") element-hash)
		 (puthash "isa" (read-string "isa: ") element-hash)
		 (puthash "required" (read-string "required: ") element-hash)
		 (puthash "lazy_build" (read-string "lazy-build: ") element-hash)
		 (setq element-other (read-string "other? "))
		 (if (re-search-forward "^has " nil t)
		     (progn
		       (goto-char (point-max))
		       (re-search-backward "^has "))
		   (if (re-search-forward "^with " nil t)
		       (progn
			 (goto-char (point-max))
			 (re-search-backward "^with "))))
		 (re-search-forward ";")
		 (insert "\nhas " element " => ( ")
		 (setq element-list ())
		 (maphash #'(lambda (k v) 
			      (unless (string-equal v "") 
				(setq element-list (append 
						    element-list 
						    (list (concat 
							   k 
							   " => " 
							   (if (string-match "^[0-9]+$" v) "" "'") 
							   v 
							   (if (string-match "^[0-9]+$" v) "" "'"))))))) 
			  element-hash)
		 (insert (mapconcat 'identity element-list ", "))
		 (insert " );")
		 (if (not (string-equal element-other "")) (backward-char 3))
		 (string-equal element-other ""))))

(defun gt-perl-insert-constant ()
  "Add constant"
  (interactive)
  (gt-perl-do-insert-package-element 
   nil "use constant" nil #'(lambda (element)
			    (setq value (read-string "value: "))
			    (if (re-search-forward "^use constant " nil t)
				(progn
				  (goto-char (point-max))
				  (re-search-backward "^use constant ")
				  (re-search-forward ";"))
			      (re-search-forward "^$"))
			    (insert "\nuse constant " element " => " value ";")
			    1)))

(defun gt-perl-insert-method (&optional name body type)
  "insert a perl method (sub) in lexographically correct location.
If the method begins with '_' it will be inserted in private subroutines
section.

Handles look up to see if there's a gt-perl-insert-<name> function that
handles special method names.

You may include a qualifier in the name, e.g.

   a some_abstract
   c some_constant
   f some_factory
   p _some_private
   s some_static
 
Otherwise, inserts in the methods section."
  (interactive)
  (let
      ((special nil)
       (qualifier ?!)
       (case-fold-search nil))
    (if (not name)
	(setq name (read-string "method (sub) name: ")))
    (if (> (length (split-string name)) 1)
	(progn
	  (setq qualifier (string-to-char (nth 0 (split-string name))))
	  (setq name (nth 1 (split-string name)))))
    (if qualifier (message (char-to-string qualifier) "HEY"))
    (if (not type)
	(progn
	  (setq type
		(case qualifier
		  (?a 'ABSTRACT)
		  (?c (setq name (upcase name)) 'CONSTANT)
		  (?f 'FACTORY)
		  (?p 'PRIVATE)
		  (?s 'STATIC)
		  (?! (cond
		      ((string-match "^new" name) 'FACTORY)
		      ((string-match "^_" name) 'PRIVATE)
		      ((string-match "^[A-Z]" name) 'CONSTANT)
		      (t 'SIMPLE)))
		  (t (error "bad qualifier"))))))
    (if body
	(gt-perl-do-insert-method name body type)
      (funcall (or (intern-soft (concat "gt-perl-insert-method-" name))
		   (intern-soft
		    (concat "gt-perl-insert-method-"
			    (downcase (symbol-name type)))))
	       name
	       type))))

(defun gt-perl-insert-method-constant (name type)
  (gt-perl-do-insert-method name "
    return @@;"
			   type))

(defun gt-perl-insert-method-private (name type)
  (gt-perl-do-insert-method name "
    my (@@) = @_;
    return;"
			   type))

(defun gt-perl-insert-method-factory (name type)
  (gt-perl-do-insert-method
   name
   (concat "
    my ($self) = shift->SUPER::" name "(@_);
    $self->[$_IDI] = {
        @@
    };
    return $self;")
   type))

(defun gt-perl-insert-method-static (name type)
  (gt-perl-do-insert-method name "
    my ($proto) = @_;
    @@
    return;"
			   type))

(defun gt-perl-insert-method-abstract (name type)
  (gt-perl-do-insert-method name "
    my ($self@@) = @_;
    die('abstract method called');
    # DOES NOT RETURN"
			   type))

(defun gt-perl-insert-method-simple (name type)
  (gt-perl-do-insert-method name "
    my ($self@@) = @_;

    return;"
			   type))

(defun gt-perl-insert-variable ()
  "insert a global variable, which always begin with \"$_\", but you may
leave this off when entering the variable name at the prompt.
"
  (interactive)
  (let
      ((name (read-string "global variable name: "
			  nil 'gt-perl-insert-variable)))
    (if (string-match "^\\$?_\\(.*\\)" name)
	(setq name (match-string 1)))
    (gt-perl-do-insert-variable (upcase name) "")
    (re-search-backward ";")))

(defun gt-perl-refactor-rename-method ()
  "Renames the method and updates documentation and references to
old name within documentation and body method, but not rest of module."
  (interactive)
  (let
      ((old (read-string "OLD method (sub) name: "))
       (new (read-string "NEW method (sub) name: "))
       (case-fold-search nil)
       (end nil)
       (start nil)
       (is-private nil)
       (body nil))
    (goto-char (point-min))
    (re-search-forward (concat "^sub " old " {"))
    (beginning-of-line)
    (setq start (point))
    (re-search-forward "^}\n\n")
    (while (re-search-backward (concat "\\b" old "\\b") start t)
      (replace-match new t t)
      (forward-word -1))
    (re-search-backward "^sub ")
    (kill-line)
    (setq start (point))
    (re-search-forward "^}")
    (backward-char 2)
    (re-search-backward "\\S_")
    (setq body (buffer-substring start (+ (point) 1)))
    (forward-line)
    (re-search-forward "\n+")
    (delete-char (- start (point)))
    (gt-perl-insert-method new body)
    (save-excursion
      (goto-char (point-min))
      (query-replace old new t))))

(defun gt-perl-module-from-file-name (name)
  "find the /(gt)?lib/ part and use all names after as package components.  Replaces / with ::."
  (setq name (file-name-sans-extension name))
(message "name %s" name)
  (if (string-match "/\\(\\(gt\\)?lib/\\)" name)
      (mapconcat
       (lambda (a) a)
       (split-string (substring name (match-end 1)) "/")
       "::")
    ""))

(defun gt-perl-template nil
  "inserts a filename-specific template"
  (interactive)
  (setq name (buffer-file-name))
  (if (string-match "\\.pm\\'" name)
      (gt-perl-do-template-pm)
    (if (string-match "\\.t\\'" name)
	(gt-perl-do-template-t)
      (message "no supported template found"))))

(defun gt-perl-do-template-pm nil
  "inserts a template for a perl module which may extend an existing class."
  (let*
      ((name (gt-perl-module-from-file-name (buffer-file-name)))
       (extends (read-string "extends module: ")))
    (insert "package " name ";

use Moose;
use namespace::autoclean;
"
	    (if (string-equal extends "")
		""
	      (concat "\nextends '" extends "';\n"))
"
__PACKAGE__->meta->make_immutable;

1;
"))
  (forward-line -4))

(defun gt-perl-do-template-t nil
  "inserts a template for a perl test"
  (insert "#!perl
use strict;
use warnings;
use Test::More;
use Test::Deep;
use Test::Exception;
use GTCore::Testing::TestInit;
use GTCore::Testing::Factories qw( make_facil make_sku make_lot make_vendor make_extsku make_order );

use DBR ( app => 'rop', use_exceptions => 1 );
use Data::Printer;

")
  (setq inserted 0)
  (while (not (string-equal "" (setq module (read-string "use module: "))))
    (insert "use_ok '" module "';\n")
    (setq inserted 1))
  (if (= 1 inserted) (insert "\n"))
  (insert "\n\ndone_testing;\n")
  (forward-line -3))

(eval-after-load "cperl-mode"
  '(progn
      (define-key cperl-mode-map (kbd "\C-c b") 'gt-perl-call-super)
      (define-key cperl-mode-map (kbd "\C-c f") 'gt-perl-find-module)
      (define-key cperl-mode-map (kbd "\C-c p") 'gt-perl-man-builtin)
      (define-key cperl-mode-map (kbd "\C-c r") 'gt-perl-refactor-rename-method)
      (define-key cperl-mode-map (kbd "\C-c s") 'gt-perl-insert-method)
      (define-key cperl-mode-map (kbd "\C-c v") 'gt-perl-insert-variable)
      (define-key cperl-mode-map (kbd "\C-c u") 'gt-perl-insert-use)
      (define-key cperl-mode-map (kbd "\C-c w") 'gt-perl-insert-role)
      (define-key cperl-mode-map (kbd "\C-c h") 'gt-perl-insert-has)
      (define-key cperl-mode-map (kbd "\C-c c") 'gt-perl-insert-constant)
      (define-key cperl-mode-map (kbd "\C-c t") 'gt-perl-template)
      (define-key cperl-mode-map (kbd "\C-c m") 'compile)))
