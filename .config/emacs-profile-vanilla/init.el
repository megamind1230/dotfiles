;;; init.el --- dt's emacs config bootstrap -*- lexical-binding: t; -*-
;; --------------------
;; package management
;; --------------------
(require 'package)
;; typst-ts-mode autoloads inline `define-compilation-mode';
;; load `compile' first so package activation doesn't error
(require 'compile)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(package-initialize)
;; Refresh package contents if not already done
(unless package-archive-contents
  (package-refresh-contents))

;; --------------------
;; no menu/tool/scroll bars
;; --------------------
(setq native-comp-async-report-warnings-errors 'silent)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)
(menu-bar-mode -1)
(save-place-mode 1) ;; save cursor place in killed files
(blink-cursor-mode -1)
(global-display-line-numbers-mode 1) ;; show line numbers
(global-visual-line-mode 1) ;; smartly wrap lines
(setq vc-follow-symlinks t) ;; Always follow symlinks, no prompt

;; --------------------
;; highlight current line
;; --------------------
(global-hl-line-mode 1)

;; disable bell sound, but use visible instead
(setq ring-bell-function 'ignore)
(setq visible-bell t)

;; --------------------
;; encoding
;; --------------------
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; --------------------
;; misc global settings
;; --------------------
;; fast file reload
(global-auto-revert-mode 1)

(electric-pair-mode 1)           ;; auto-close brackets {} [] () "" etc.
(setq-default tab-width 2)       ;; display width
(setq-default c-basic-offset 2)  ;; C#/C indent

(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; --------------------
;; drag stuff.. to alt up/down lines
;; --------------------
(require 'drag-stuff)
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)
(with-eval-after-load 'evil
  (evil-define-key '(normal visual) 'global
    (kbd "M-h") #'drag-stuff-left
    (kbd "M-j") #'drag-stuff-down
    (kbd "M-k") #'drag-stuff-up
    (kbd "M-l") #'drag-stuff-right))
;; ctrl d/u zz
(defun dt/scroll-down-centered ()
  "Scroll down half a page and center the cursor."
  (interactive)
  (evil-scroll-down nil)
  (evil-scroll-line-to-center nil))
(defun dt/scroll-up-centered ()
  "Scroll up half a page and center the cursor."
  (interactive)
  (evil-scroll-up nil)
  (evil-scroll-line-to-center nil))
(with-eval-after-load 'evil
  (define-key evil-normal-state-map
              (kbd "C-d")
              #'dt/scroll-down-centered)
  (define-key evil-normal-state-map
              (kbd "C-u")
              #'dt/scroll-up-centered))
;; vertico --> vertical listing for M-x and vertical buffer listing
(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

;; marginalia extra info for vertico
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

;; orderless, fuzzy find search orderlessly
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  )
;; enable org export to markdown
(require 'ox-md)
;; --------------------
;; Org → PDF export
;; --------------------
(setq org-latex-compiler "xelatex")
(setq org-latex-pdf-process
      '("xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"))
;; Delete .tex/.log/.aux junk after a successful export
(setq org-latex-remove-logfiles t)
;; --------------------
;; dt-org
;; --------------------

;; --------------------
;; Org basics
;; --------------------
(require 'org)
(setq org-directory (expand-file-name "/mnt/hdd/obsi/vault_bank/core/my-org-agenda/"))
(setq org-agenda-files (list org-directory))
;; Default notes file (important!)
(setq org-default-notes-file
      (expand-file-name "0-inbox.org" org-directory))
;; --------------------
;; TODO workflow
;; --------------------
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
        (sequence "WAITING(w)" "|" "CANCELLED(c)")))
;; --------------------
;; Keybindings
;; --------------------
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c a") #'org-agenda)
;; --------------------
;; Capture templates
;; --------------------
(setq org-capture-templates
      `(("t" "Temp-note" entry
         (file ,(expand-file-name "0-inbox.org" org-directory))
         ;; "* TODO %?\n  %U\n")))
         "* %?\n")))
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

;; --------------------
;; easier - [ ]  insertion
;; --------------------
(defun insert-org-checkbox ()
  "Insert an unchecked checklist item."
  (interactive)
  ;; (beginning-of-line)
  (insert "- [ ] "))
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c i c") #'insert-org-checkbox))
;; ----------------------------
;; faster table insertion
;; ----------------------------
(defun insert-org-table ()
  "Insert a the table core"
  (interactive)
  ;; (beginning-of-line)
  (insert
"| a | b |
|---+---|
|   |   |
"))
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c i t") #'insert-org-table))
;; --------------------
;; recent files
;; --------------------
(recentf-mode 1)
(setq recentf-max-saved-items 50)
(global-set-key (kbd "C-x C-r") #'recentf)
;; --------------------
;; workspaces
;; --------------------
(use-package perspective
  :init
  (setq persp-mode-prefix-key (kbd "C-c w"))
  (persp-mode))
(global-set-key (kbd "C-c w s") #'persp-switch)
(global-set-key (kbd "C-c w k") #'persp-kill)
(global-set-key (kbd "C-c w r") #'persp-rename)

;; avy { the vimeasymotion alternative }
(require 'avy)
;; Jump to a character in the visible window { best }
(global-set-key (kbd "C-:") 'avy-goto-char)
;; Jump to a line
(global-set-key (kbd "M-g a l") 'avy-goto-line)
;; ;; Jump to a word beginning ;;i don't think i need this
;; (global-set-key (kbd "C-'") 'avy-goto-word-1)
;; --------------------
;; Global zoom (requires default-text-scale package)
;; --------------------
(use-package default-text-scale
  :config
  (global-set-key (kbd "C-=") 'default-text-scale-increase)
  (global-set-key (kbd "C--") 'default-text-scale-decrease))

;; auto select/focus newly opened help buffers
(setq help-window-select t)
;; --------------------
;; markdown-mode
;; --------------------
;; i installed (markdown-mode)
(use-package markdown-mode
  :ensure t)

;; --------------------
;; Markdown - org-like cycling + navigation for evil
;; --------------------
(with-eval-after-load 'markdown-mode
  (evil-define-key 'normal markdown-mode-map
    (kbd "TAB")       #'markdown-cycle
    (kbd "<backtab>") #'markdown-shifttab
    "gx"              #'markdown-follow-thing-at-point))
;; --------------------
;; consult
;; --------------------
;; i installed (consult)
(use-package consult
  :ensure t
  :bind
  (("C-c r" . consult-ripgrep))
  )

;; --------------------
;; embark
;; --------------------
(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
    ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
(use-package embark-consult
  :ensure t)
;; --------------------
;; embark (custom vertical/horizontal splits)
;; --------------------
(defun dt/find-file-split-below (file)
  "Open FILE in a horizontal split below."
  ; (interactive)
  (select-window (split-window-below))
  (find-file file))
(defun dt/find-file-split-right (file)
  "Open FILE in a vertical split to the right."
  ; (interactive)
  (select-window (split-window-right))
  (find-file file))
(with-eval-after-load 'embark
  (define-key embark-file-map (kbd "2")
    #'dt/find-file-split-below)
  (define-key embark-file-map (kbd "3")
    #'dt/find-file-split-right))
;; --------------------
;; key-quiz
;; --------------------
;; i installed (key-quiz package)
(use-package key-quiz
  :ensure t)
;; --------------------
;; dt-functions
;; --------------------

;; --------------------
;; search selected in browser, chatgpt
;; --------------------
(defun dt/query-duckduckgo ()
  (interactive)
  (if (use-region-p)
      (browse-url
       (concat "https://duckduckgo.com/?q="
               (url-hexify-string
                (buffer-substring-no-properties
                 (region-beginning)
                 (region-end)))))
    (message "No region selected")))
(defun dt/query-chatgpt ()
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
(global-set-key (kbd "C-c q d") #'dt/query-duckduckgo) ;; query duckduckgo
(global-set-key (kbd "C-c q c") #'dt/query-chatgpt) ;; query chatgpt
(defun dt/cd-personal-vault ()
  "Change the current buffer's `default-directory' to the vault directory."
  (interactive)
  (setq default-directory
        (expand-file-name (or (bound-and-true-p denote-directory)
                              "/mnt/hdd/obsi/vault_bank/core/")))
  (message "pwd: %s" default-directory))
(global-set-key (kbd "C-c g v") #'dt/cd-personal-vault) ;; go to vault

(defun dt/cd-home ()
  "Change the current buffer's `default-directory' to the home directory."
  (interactive)
  (setq default-directory "~/")
  (message "pwd: %s" default-directory))
(global-set-key (kbd "C-c g h") #'dt/cd-home) ;; go to vault

(defun dt/cd-org-agenda ()
  "Go to the Org directory."
  (interactive)
  (setq default-directory
        (file-name-as-directory
         (expand-file-name org-directory)))
  (message "pwd: %s" default-directory))
(global-set-key (kbd "C-c g o") #'dt/cd-org-agenda) ;; go to org-agenda files
