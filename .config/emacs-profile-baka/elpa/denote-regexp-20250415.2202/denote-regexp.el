;;; denote-regexp.el --- Compose regexps to match Denote files  -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Samuel W. Flint <swflint@samuelwflint.com>

;; Author: Samuel W. Flint <swflint@samuelwflint.com>
;; SPDX-License-Identifier: GPL-3.0-or-later
;; Homepage: https://git.sr.ht/~swflint/denote-regexp
;; Package-Version: 20250415.2202
;; Package-Revision: 08d62cb5bb2d
;; Keywords: convenience
;; Package-Requires: ((emacs "27.1") (denote "3.1.0"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This library provides two user- or developer-facing functions,
;; `denote-regexp' and `denote-regexp-rx'.  The function
;; `denote-regexp' uses `denote-regexp-rx' under the hood, and this
;; may be helpful to developers primarily.  In either case, they
;; generate some representation of a regular expression to match
;; Denote files, based on `denote-file-name-components-order' and
;; user-provided input.  Each of them take the following arguments:
;;
;;  - `:identifier' a (partial) identifier string.  If the length of
;;    the string is less than 15, it will be expanded with the `any'
;;    character class so that it fits 15 characters.  Additionally, if
;;    `identifier' is not the first element of
;;    `denote-file-name-components-order', the "@@" prefix will be
;;    added.
;;
;;  - `:signature' a Denote file signature.  This will be prefixed with "==".  If a string, it will be sluggified with `denote-sluggify'; if a regular expression (i.e., a list), it will be passed through otherwise.
;;
;;  - `:title' a note's title.  This will be prefixed with "--".  If a
;;    string, it will be sluggified with `denote-sluggify'; if a
;;    regular expression (i.e., a list), it will be passed through
;;    otherwise.
;;
;;  - `:keywords' keywords for a note.  This will be prefixed with
;;    "__".  The format of this argument is as follows:
;;
;;     - If it is a string, it well be passed to `denote-sluggify'.
;;
;;     - If it is a list, starting with `or' or `:or', it will be
;;       treated as a regular expression disjunction (`rx's `or'), and
;;       the remainder of the list will be processed recursively.
;;
;;     - If it is otherwise a list, (optionally starting with `and' or
;;       `:and'), it will be treated as a regular expression sequence.
;;       If all remaining elements of the list are strings, it will be
;;       sorted following `denote-sort-keywords', otherwise, all -
;;       elements will be processed recursively.
;;
;;  - `:file-type' will match known file types.  This should be a
;;    symbol or list of symbols representing file types which are part
;;    of `denote-file-types'.
;;
;; - `:directory' will match the subdirectory of a note.  This should be a
;;   string or a regexp.
;;
;; Finally, a `denote' construct for `rx' is available as well, which
;; follows the same arguments as above.
;;
;; ** Examples
;;
;;  - To match a file with the keywords "project" and "inprogress", use:
;;     (denote-regexp :keywords '("project" "inprogress"))
;;
;;  - To match a file whose identifier starts with "2024", use:
;;     (denote-regexp :identifier "2024")
;;
;;  - To match a file with the (unsluggified) signature
;;    "soloway85:_from_probl_progr_plans", use:
;;     (denote-regexp :signature "soloway85:_from_probl_progr_plans")
;;
;;  - To match a file with either the keyword "agenda" or both
;;    "project" and "inprogress", use:
;;     (denote-regexp :keywords '(or "agenda" (and "project" "inprogress")))
;;
;;  - To match denote-journal-extras files from May of 2023, use:
;;     (denote-regexp :signature "202305" :keywords denote-journal-extras-keyword)
;;
;;  - To match in-progress projects as part of a denote-links block:
;;    #+BEGIN: denote-links :regexp (denote :keywords '("project" "inprogress"))
;;    #+END:
;;
;; ** Errors and Patches
;;
;; If you find an error, or have a patch to improve this package,
;; please send an email to ~swflint/emacs-utilities@lists.sr.ht.

;;; Code:

(require 'seq)
(require 'cl-lib)
(require 'denote)

(defun denote-regexp--intersperse-list (intersperse list)
  "Intersperse LIST with INTERSPERSE.

That is, if we have a LIST (a b c), and INTERSPERSE is z, we would
get (a z b z c) as a result."
  (if (null (cdr list))
      list
    (cons (car list) (cons intersperse (denote-regexp--intersperse-list intersperse (cdr list))))))

(defvar denote-sort-keywords-comparison-function)

(defun denote-regexp--keywords (keywords)
  "Convert KEYWORDS into an RX form.

The following rules are used.

 - If KEYWORDS is a string, return the string converted with
   `denote-sluggify'.

 - If KEYWORDS is a list beginning with `or' or `:or', all remaining
   elements are processed recursively, and treated as an `rx' `or'.

 - Otherwise, if KEYWORDS is list (optionally beginning with `:and' or
   `and'), all remaining elements are processed recursively, and treated
   as an `rx' `and'.  In this case, the variable `denote-sort-keywords'
   is obeyed."
  (pcase keywords
    ((or
      `(or . ,kws)

      `(:or . ,kws))
     `(or ,@(mapcar #'denote-regexp--keywords kws)))
    ((or
      `(and . ,kws)
      `(:and . ,kws))
     `(and ,@(denote-regexp--intersperse-list '(* any)
                                              (mapcar #'denote-regexp--keywords
                                                      (if (and denote-sort-keywords
                                                               (seq-every-p #'stringp kws))
                                                          (seq-sort denote-sort-keywords-comparison-function kws)
                                                        kws)))))
    ((pred listp)
     `(and ,@(denote-regexp--intersperse-list '(* any)
                                              (mapcar #'denote-regexp--keywords
                                                      (if (and denote-sort-keywords
                                                               (seq-every-p #'stringp keywords))
                                                          (seq-sort denote-sort-keywords-comparison-function keywords)
                                                        keywords)))))
    ((pred stringp)
     `(and bow ,(denote-sluggify 'keyword keywords) eow))))

(defun denote-regexp--translate (field value)
  "Translate VALUE, based on FIELD.

This function prepends each field with its prefix, as follows:

 - `identifier' \"@@\" if not the first in
   `denote-file-name-components-order'.
 - `signature' \"==\"
 - `title' \"--\"
 - `keywords' \"__\"

For the pseudo-fields `file-type' and `directory', no prefix is
prepended.  However, they are appended with `eol' or the backslash,
respectively."
  (pcase field
    ('identifier
     (let ((base-regexp (if (= (length value) 15)
                            value
                          `(and ,value (= ,(- 15 (length value)) any)))))
       (if (= 0 (seq-position denote-file-name-components-order 'identifier))
           base-regexp
         `(and "@@" base-regexp))))
    ('signature
     (cond
      ((stringp value)
       `(and "==" ,(denote-sluggify 'signature value)))
      ((listp value)
       `(and "==" ,value))
      (value
       "==")))
    ('title
     (cond
      ((stringp value)
       `(and "--" ,(denote-sluggify 'title value)))
      ((listp value)
       `(and "--" ,value))))
    ('keywords
     `(and "__" (* any) ,(denote-regexp--keywords value)))
    ('file-type
     `(and
       (or ,@(mapcar (lambda (type)
                       (plist-get (alist-get type denote-file-types) :extension))
                     (if (listp value)
                         value
                       (list value))))
       eol)
     )
    ('directory
     `(and ,value "/"))))

(defun denote-regexp-rx (&rest args)
  "Construct an `rx' form based on ARGS to match Denote files.

ARGS should be a plist optionally containing the following properties:

 - `:title' an unformatted title of a Denote note.  This will be
   formatted using `denote-sluggify'.

 - `:identifier' a partial identifier, if less than 15 characters
   an `(= (- 15 n) any)' element will be generated.

 - `:signature' A Denote file signature.  This will be formatted using
   `denote-sluggify'.

 - `:keywords' A specification of keywords, as follows.

    - A single string (formatted using `denote-sluggify')
    - A list of keyword specifiers staring with the symbol `:or' or
      `or'.  These will be recursively formatted, joined with the `rx'
      `or' operator.
    - A list of keyword specifiers, optionally prefixed with the symbol
      `:and' or `and'.  These will be recursively formatted, joined with
      the `rx' `and' operator.

 - `:file-type' will match known file types. This should be a
   symbol or list of symbols representing file types which are part
   of `denote-file-types'.

 - `:directory' will match the subdirectory of a note.  This should be a
   string or a regexp.

For examples, run (finder-commentary \"denote-regexp\")."
  (unless (= 0 (mod (length args) 2))
    (error "The number of arguments to `denote-regexp' must be even"))
  (let* ((name-to-kw '((directory . :directory)
                       (title . :title)
                       (signature . :signature)
                       (identifier . :identifier)
                       (keywords . :keywords)
                       (file-type . :file-type))))
    (cons 'and
          (denote-regexp--intersperse-list
           '(* any)
           (remq nil
                 (mapcar
                  (lambda (item)
                    (when-let* ((keyword (alist-get item name-to-kw))
                                (index (seq-position args keyword))
                                (next-item (seq-elt args (1+ index))))
                      (denote-regexp--translate item next-item)))
                  (cons 'directory
                        (append denote-file-name-components-order '(file-type)))))))))

(defun denote-regexp (&rest args)
  "Construct a regexp based on ARGS to match Denote files.

ARGS should be a plist optionally containing the following properties:

- `:title' an unformatted title of a Denote note.  This will be
  formatted using `denote-sluggify'.

- `:identifier' a partial identifier, if less than 15 characters
  an `(= (- 15 n) any)' element will be generated.

- `:signature' A Denote file signature.  This will be formatted using
  `denote-sluggify'.

- `:keywords' A specification of keywords, as follows.

   - A single string (formatted using `denote-sluggify')
   - A list of keyword specifiers staring with the symbol `:or' or
     `or'.  These will be recursively formatted, joined with the `rx'
     `or' operator.
   - A list of keyword specifiers, optionally prefixed with the symbol
     `:and' or `and'.  These will be recursively formatted, joined with
     the `rx' `and' operator.

 - `:file-type' will match known file types. This should be a
   symbol or list of symbols representing file types which are part
   of `denote-file-types'.

For examples, run (finder-commentary \"denote-regexp\").  See also
`denote-regexp-rx'."
  (rx-to-string (apply #'denote-regexp-rx args)))

(rx-define denote (&rest args)
  (eval (denote-regexp-rx args)))

(provide 'denote-regexp)
;;; denote-regexp.el ends here
