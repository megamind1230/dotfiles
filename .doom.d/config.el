;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

;; BAKA
(require 'org)
(setq org-directory (expand-file-name "~/org"))
(setq org-agenda-files (list org-directory))
;; Default notes file (important!)
(setq org-default-notes-file
      (expand-file-name "inbox.org" org-directory))


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; --------------------
;; spaces over tabs
;; --------------------
(setq-default indent-tabs-mode nil)
;; --------------------
;; search selected in browser, chatgpt
;; --------------------
(defun search-selected-text ()
  (interactive)
  (if (use-region-p)
      (browse-url
       (concat "https://duckduckgo.com/?q="
               (url-hexify-string
                (buffer-substring-no-properties
                 (region-beginning)
                 (region-end)))))
    (message "No region selected")))
(defun ask-chatgpt-browser ()
  "Send selected text to ChatGPT in browser."
  (interactive)
  (if (use-region-p)
      (let ((query (buffer-substring-no-properties
                    (region-beginning)
                    (region-end))))
        (browse-url
         (concat "https://chat.openai.com/?q="
                 (url-hexify-string query))))
    (message "No region selected")))
(global-set-key (kbd "C-c s") #'search-selected-text)
(global-set-key (kbd "C-c g") #'ask-chatgpt-browser)

;; --------------------
;; jk as esc in Evil insert mode
;; --------------------
(setq evil-escape-key-sequence "jk"
      evil-escape-delay 0.2)


;; --------------------
;; scratch buffer as default on startup, with no dashboard
;; also need to comment ui: doom-dashboard
;; --------------------
;; Disable Doom dashboard
(setq doom-dashboard-enable nil)
;; Make *scratch* the startup buffer
(setq initial-buffer-choice t)
;; Scratch buffer settings
(setq initial-major-mode 'org-mode
      initial-scratch-message "")

;; --------------------
;; org
;; --------------------
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c a") #'org-agenda)
;; Default notes file (important!)
(setq org-default-notes-file
      (expand-file-name "inbox.org" org-directory))
;; --------------------
;; TODO workflow
;; --------------------
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
        (sequence "WAITING(w)" "|" "CANCELLED(c)")))
;; --------------------
;; Capture templates
;; --------------------
(setq org-capture-templates
      `(("t" "Temp-note" entry
         (file ,(expand-file-name "inbox.org" org-directory))
         "* TODO %?\n  %U\n")))
;; --------------------
;; GTD Agenda
;; --------------------
(setq org-agenda-custom-commands
      '(("g" "GTD"
         ((agenda "")
          (todo "NEXT")
          (todo "WAITING")))))
;; Refile setup (make it usable)
(setq org-refile-targets
      '((org-agenda-files :maxlevel . 3)))
(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)
;; --------------------
;; ignore DONE in agenda view ig
;; --------------------
(setq org-agenda-todo-ignore-done t)
(setq org-agenda-skip-timestamp-pre-if-done t)
(setq org-agenda-skip-deadline-pre-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
;; (setq org-return-follows-link t)
(with-eval-after-load 'org
  (evil-define-key 'normal org-mode-map
    "gx" #'org-open-at-point
    (kbd "TAB") #'org-cycle
    (kbd "<backtab>") #'org-shifttab))
(global-set-key (kbd "C-c i") #'org-id-get-create)
(map! "C-," #'org-cycle-agenda-files)

;; --------------------
;; recent files
;; --------------------
(recentf-mode 1)
(global-set-key (kbd "C-x C-r") #'recentf-open-files)

;; --------------------
;; easier - [ ]  insertion
;; --------------------
(defun insert-org-checkbox ()
  "Insert an unchecked checklist item."
  (interactive)
  ;; (beginning-of-line)
  (insert "- [ ] "))
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c m c") #'insert-org-checkbox))

;; --------------------
;; drag-stuff { alt }
;; --------------------
(use-package! drag-stuff
  :hook (after-init . drag-stuff-global-mode)
  :config
  (drag-stuff-define-keys))
(map! :nv "M-h" #'drag-stuff-left
      :nv "M-j" #'drag-stuff-down
      :nv "M-k" #'drag-stuff-up
      :nv "M-l" #'drag-stuff-right)
