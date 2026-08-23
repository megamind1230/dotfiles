;; --------------------
;;melpa
;; --------------------
(require 'package)
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


;;(custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(package-selected-packages
;;   '(cape consult corfu corfu-terminal evil lv orderless use-package
;;          vertico which-key)))
;;(custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; )

;;;; setup completion
;;(vertico-mode)
;;(setq completion-styles '(orderless basic))
;;(global-set-key (kbd "C-x b") 'consult-buffer)



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
;;(windmove-default-keybindings) ;; shift+arrow to change window

;; --------------------
;; highlight current line
;; --------------------
(global-hl-line-mode 1)

;; updated: XDG-compliant cache/state dirs (replaces disabled backup block above)
(defconst dt/cache-dir
  (expand-file-name "emacs/" (or (getenv "XDG_CACHE_HOME") "~/.cache/")))
(defconst dt/state-dir
  (expand-file-name "emacs/" (or (getenv "XDG_STATE_HOME") "~/.local/state/")))

(dolist (dir (list dt/cache-dir
                    dt/state-dir
                    (expand-file-name "auto-save/" dt/cache-dir)
                    (expand-file-name "auto-save-list/" dt/cache-dir)
                    (expand-file-name "backups/" dt/cache-dir)))
  (unless (file-directory-p dir)
    (make-directory dir t)))

(setq custom-file (expand-file-name "custom.el" dt/state-dir))
(load custom-file t)
;; old disabled backup block (keep for reference):
;; (setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
;; (setq custom-file (locate-user-emacs-file "custom.el"))

(setq auto-save-list-file-prefix (expand-file-name "auto-save-list/.saves-" dt/cache-dir))
(setq backup-directory-alist `(("." . ,(expand-file-name "backups/" dt/cache-dir))))
(setq auto-save-file-name-transforms `((".*" ,(expand-file-name "auto-save/" dt/cache-dir) t)))
(setq bookmark-default-file (expand-file-name "bookmarks" dt/state-dir))
(setq recentf-save-file (expand-file-name "recentf" dt/state-dir))
(setq savehist-file (expand-file-name "savehist" dt/state-dir))
(savehist-mode 1)
(setq savehist-additional-variables '(text-scale-mode-amount))
(setq save-place-file (expand-file-name "places" dt/state-dir))
(setq create-lockfiles nil)



;; --------------------
;; faster kill buffer
;; --------------------
(global-set-key (kbd "C-x k") 'kill-current-buffer)

;; --------------------
;; spaces over tabs
;; --------------------
(setq-default indent-tabs-mode nil)

;; idk whether to uncomment or not
;; ;; Isolate the external clipboard
;; (use-package simpleclip
;;   :if (display-graphic-p)
;;   :config
;;   ;; C-ins / M-ins to copy/paste from the system clipboard
;;   (global-set-key (kbd "C-<insert>") 'simpleclip-copy)
;;   (global-set-key (kbd "M-<insert>") 'simpleclip-paste)
;;   (simpleclip-mode))

;; ;; Provide access to the Wayland clipboard.
;; ;; Install the tool by running `dnf install -y wl-clipboard'
;; (defun wl-copy ()
;;   "Copy the current region to Wayland clipboard with wl-copy."
;;   (interactive)
;;   (when (use-region-p)
;;     (let ((p (make-process :name "wl-copy"
;;                            :command '("wl-copy")
;;                            :connection-type 'pipe))
;;           (s (buffer-substring-no-properties (region-beginning) (region-end))))
;;       (process-send-string p s)
;;       (process-send-eof p))))

;; ;; Use C-ins to copy into Wayland clipboard from an Emacs TTY
;; (unless (display-graphic-p)
;;   (global-set-key (kbd "C-<insert>") 'wl-copy))


;; Install Evil if not already installed
(unless (package-installed-p 'evil)
  (package-refresh-contents)
  (package-install 'evil))
;; Enable Evil mode
(require 'evil)
(evil-mode 1)
(require 'evil-surround)
(global-evil-surround-mode 1)

;; I installed which-key gnu
;; enable which-key mode
(which-key-mode 1)

;; disable bell sound, but use visible instead
(setq ring-bell-function 'ignore)
(setq visible-bell t)

;; installed corfu / corfu-terminal / cape
;; Enable indentation and completion using the TAB key.
(setq tab-always-indent 'complete)
;; Make the completion suggest file paths.
;;(add-hook 'completion-at-point-functions #'cape-file)
;; Activate in buffer completion everywhere.
;;(global-corfu-mode)
;; enable corfu in terminal.
;; This is needed until child frame support for terminal Emacs arrives.
;;(unless (display-graphic-p) (corfu-terminal-mode +1))
;; For manual corfu, use SPC to add orderless separator.
;;(keymap-set corfu-map "SPC"  'corfu-insert-separator)
;; show completion automatically after a short delay
;;(setq corfu-auto t)

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

;; --------------------
;; gcc AND gc to comment/uncomment
;; --------------------
(defun comment-line ()
  "Comment or uncomment the current line."
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
  (forward-line 1))
;; Using evil-mode style keybindings (recommended approach)
;; If you're using evil-mode:
(with-eval-after-load 'evil
  ;; Make gc an operator that works with motions (like gcap, gc5j, etc.)
  (evil-define-operator evil-comment-operator (beg end)
    "Comment or uncomment region."
    (comment-or-uncomment-region beg end))
  (define-key evil-normal-state-map "gc" 'evil-comment-operator)
  (define-key evil-visual-state-map "gc" 'evil-comment-operator)
  ;; gcc comments the current line
  (define-key evil-normal-state-map "g c c" 'comment-line))

;; --------------------
;; scratch buffer as default on startup, with no dashboard
;; --------------------
;; (defun emacs-startup ()
;;   "Start Emacs with *scratch* buffer."
;;   (get-buffer-create "*scratch*"))
;; (setq initial-buffer-choice #'emacs-startup)
;; (setq dashboard-set-init-info nil)
(add-hook 'after-init-hook
  (lambda ()
    (set-face-attribute 'default nil :family "Ubuntu Mono" :height 148)
    (set-frame-font "Ubuntu Mono-16" nil t)))
(setq initial-major-mode 'org-mode)
(setq inhibit-startup-screen t)
(setq initial-scratch-message "")


;; ;; org
;; ;; Enable Org
;; (require 'org)
;; ;; Where my org files live
;; (setq org-directory "~/org")
;; ;; Agenda files
;; (setq org-agenda-files (list org-directory))
;; ;; TODO workflow
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")))
;; ;; Keybindings
;; (global-set-key (kbd "C-c a") 'org-agenda)
;; (global-set-key (kbd "C-c c") 'org-capture)
;; ;;TODO states (minimal & powerful)
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
;;         (sequence "WAITING(w)" "|" "CANCELLED(c)")))
;; ;;capture into inbox?
;; (setq org-capture-templates
;;       '(("i" "Inbox" entry
;;          (file "inbox.org")
;;          "* TODO %?\n  %U\n")))
;; ;; agenda setup
;; (setq org-agenda-files '("~/org"))
;; (setq org-agenda-custom-commands
;;       '(("g" "GTD"
;;          ((agenda "")
;;           (todo "NEXT")
;;           (todo "WAITING")))))

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
;; theme
;; --------------------
;; (Load-theme 'solarized-dark t)
(load-theme 'leuven-dark t)
;; (load-theme 'modus-vivendi-tinted t)
;; (use-package gruber-darker-theme
;;   :ensure t)
;; (load-theme 'gruber-darker t)


;; --------------------
;; recent files
;; --------------------
(recentf-mode 1)
(setq recentf-max-saved-items 50)
(global-set-key (kbd "C-x C-r") #'recentf)


;; --------------------
;; encoding
;; --------------------
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)


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

; ;; --------------------
; ;; csharp mode conf
; ;; --------------------
; (dolist (pkg '(lsp-mode
;                lsp-ui
;                company
;                csharp-mode))
;   (unless (package-installed-p pkg)
;     (package-install pkg)))
;     ;; ----------------------------
;     ;; LSP Mode
;     ;; ----------------------------
; (require 'lsp-mode)
; (setq lsp-keymap-prefix "C-c l")
; (setq lsp-enable-snippet t
;       lsp-enable-symbol-highlighting t
;       lsp-enable-indentation t)
; (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
; (require 'lsp-ui)
; (setq lsp-ui-doc-enable t
;       lsp-ui-sideline-enable t
;       lsp-ui-sideline-show-hover t)
; (require 'company)
; (global-company-mode)
; (require 'csharp-mode)
; (add-hook 'csharp-mode-hook #'lsp)
; (setq lsp-csharp-server-path "csharp-ls")

;; i installed (markdown-mode)
(use-package markdown-mode
  :ensure t)

;; enable org export to markdown
(require 'ox-md)


;; jk as esc
;; AND prevent jk locking emacs input
    ;; installed evil-escape btw
(use-package evil-escape
  :after evil
  :config
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.3) ;; 300ms
  (evil-escape-mode 1))

;; Install vterm
(unless (package-installed-p 'vterm)
  (package-install 'vterm))

;; Install csharp-mode for C# syntax highlighting
(unless (package-installed-p 'csharp-mode)
  (package-install 'csharp-mode))

;; csharp-mode setup
(require 'csharp-mode)
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))

;; ----------------------------------------------------------------------
;; 1. Core Configuration for company-mode  *** REPLACED BY Corfu + Cape below ***
;; ----------------------------------------------------------------------
;; (use-package company
;;   :ensure t
;;   :init
;;   (global-company-mode) ;; Enable company-mode everywhere
;;   :config
;;   (setq company-minimum-prefix-length 1   ;; Start completion after typing 1 character
;;         company-idle-delay 0.0             ;; Show completions immediately, no delay
;;         company-selection-wrap-around t    ;; Cycle through candidates from start/end
;;         company-tooltip-align-annotations t ;; Align extra info (like method signatures) nicely
;;         ;; Optional: Show numbers in the tooltip for selection with M-1..M-0
;;         ;; company-show-numbers t
;;         ))
;;
;; ;; Optional but recommended: Adds icons to the completion tooltip for a modern IDE-like look
;; (use-package company-box
;;   :ensure t
;;   :hook (company-mode . company-box-mode))

;; ----------------------------------------------------------------------
;; 2. Core Configuration for lsp-mode  *** REPLACED BY Eglot below ***
;; ----------------------------------------------------------------------
;; (use-package lsp-mode
;;   :ensure t
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")
;;   :hook
;;   (csharp-mode . lsp-deferred)
;;   :commands (lsp lsp-deferred)
;;   :config
;;   (setq lsp-completion-provider :none))
;;
;; (use-package lsp-ui
;;   :ensure t
;;   :hook (lsp-mode . lsp-ui-mode)
;;   :commands lsp-ui-mode)

;; ----------------------------------------------------------------------
;; 3. Eglot (built-in LSP client, replaces lsp-mode + lsp-ui)
;; ----------------------------------------------------------------------
(require 'eglot)
(setq eglot-autoshutdown t)
(setq eglot-extend-to-xref t)

(add-hook 'csharp-mode-hook #'eglot-ensure)

;; (define-key eglot-mode-map (kbd "C-c e f") #'eglot-format)
;; (define-key eglot-mode-map (kbd "C-c e r") #'eglot-rename)
;; (define-key eglot-mode-map (kbd "C-c e a") #'eglot-code-actions)

;; ----------------------------------------------------------------------
;; 4. Corfu + Cape (inline completion, replaces company + company-box)
;; ----------------------------------------------------------------------
(when (require 'corfu nil t)
  (setq corfu-auto t)
  (setq corfu-auto-delay 0.1)
  (setq corfu-auto-prefix 1)
  (setq corfu-cycle t)
  (setq corfu-count 14)
  (setq corfu-max-width 100)
  (setq corfu-min-width 35)
  (setq corfu-preview-current 'insert)
  (setq corfu-quit-no-match 'separator)
  (setq corfu-on-exact-match nil)
  (global-corfu-mode 1)

  ;; (define-key corfu-map (kbd "C-n") #'corfu-next)
  ;; (define-key corfu-map (kbd "C-p") #'corfu-previous)
  ;; (define-key corfu-map (kbd "C-y") #'corfu-insert)

  ;; new:
  ;; (evil-define-key 'insert corfu-map
  ;;   (kbd "C-n") #'corfu-next
  ;;   (kbd "C-p") #'corfu-previous
  ;;   (kbd "C-y") #'corfu-insert)

  ;; replace evil-define-key block with:
  (define-key evil-insert-state-map (kbd "C-n") #'corfu-next)
  (define-key evil-insert-state-map (kbd "C-p") #'corfu-previous)
  (define-key evil-insert-state-map (kbd "C-y") #'corfu-insert)

  (unless (display-graphic-p)
    (when (require 'corfu-terminal nil t)
      (corfu-terminal-mode +1))))

(when (require 'cape nil t)
  ;; (add-to-list 'completion-at-point-functions #'cape-file)
  ;; (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  ;; (add-to-list 'completion-at-point-functions #'cape-keyword)
  ;; (add-hook 'completion-at-point-functions #'cape-file -10)
  ;; (add-hook 'completion-at-point-functions #'cape-dabbrev)
  ;; (add-hook 'completion-at-point-functions #'cape-keyword)
  ;; (defun dt/setup-cape ()
  ;;   "Add cape backends and clean up junk from buffer-local capf."
  ;;   (add-hook 'completion-at-point-functions #'cape-file -10)
  ;;   (add-hook 'completion-at-point-functions #'cape-dabbrev nil)
  ;;   (add-hook 'completion-at-point-functions #'cape-keyword nil)
  ;;   (setq-local completion-at-point-functions
  ;;               (remove 'ispell-completion-at-point
  ;;                       (remove 't completion-at-point-functions))))
  ;; (add-hook 'after-change-major-mode-hook #'dt/setup-cape)
  ;; (dt/setup-cape)

  ;; Bulletproof fix: advise completion-at-point to always include cape-file.
  ;; Hooks get overwritten by mode setup — this runs every time capf is called.
  (defun dt/ensure-cape-file ()
    "Ensure cape-file is in completion-at-point-functions."
    (unless (memq #'cape-file completion-at-point-functions)
      (setq-local completion-at-point-functions
                  (cons #'cape-file completion-at-point-functions))))
  (advice-add 'completion-at-point :before #'dt/ensure-cape-file))

;; M-/ for completion — global binding (evil-insert-state-map didn't work)
(global-set-key (kbd "M-/") #'completion-at-point)

;; diagnostic: verify corfu-mode activates
;; (add-hook 'find-file-hook
;;           (lambda () (message "[corfu-debug] mode=%s auto=%s capf=%s"
;;                               (bound-and-true-p corfu-mode)
;;                               (bound-and-true-p corfu-auto)
;;                               completion-at-point-functions)))

;; diagnostic: test cape-file directly
;; (defun dt/test-cape-file ()
;;   "Call cape-file and show what it returns."
;;   (interactive)
;;   (let ((result (cape-file)))
;;     (message "[cape-file-test] result=%s point=%d text='%s'"
;;              (if result (list (nth 0 result) (nth 1 result) (length (nth 2 result))) nil)
;;              (point)
;;              (buffer-substring (max (point-min) (- (point) 20)) (point)))))

;; diagnostic: test completion-at-point directly
;; (defun dt/test-capf ()
;;   "Call completion-at-point and show what it returns."
;;   (interactive)
;;   (let ((result (completion-at-point)))
;;     (message "[capf-test] result=%s capf=%s"
;;              (if result (list (nth 0 result) (nth 1 result)) nil)
;;              completion-at-point-functions)))

(defun yas-completion-at-point ()
  "Yasnippet completion at point."
  (when (fboundp 'yas--get-snippet-tables)
    (when-let* ((tables (yas--get-snippet-tables))
                (bounds (bounds-of-thing-at-point 'symbol)))
      (let ((symbols (cl-mapcan
                      (lambda (table)
                        (cl-remove-if-not #'stringp (yas--table-all-keys table)))
                      tables)))
        `(,(car bounds) ,(cdr bounds) ,symbols
          :annotation-function ,(lambda (cand) (concat " " "snippet"))
          :exclusive 'no)))))

(add-to-list 'completion-at-point-functions #'yas-completion-at-point)

;; ----------------------------------------------------------------------
;; 4. Code Snippets
;; ----------------------------------------------------------------------
(use-package yasnippet
  :ensure t
  :demand t
  :hook ((csharp-mode . yas-minor-mode)
         (prog-mode . yas-minor-mode)))
  ;; (define-key yas-minor-mode-map [(tab)] nil)
  ;; (define-key yas-minor-mode-map (kbd "TAB") nil)
  ;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
  ;; :bind
  ;; (:map yas-minor-mode-map ("S-<tab>" . yas-expand)))
  ;; new:
  ;; :bind
  ;; (:map yas-minor-mode-map ("TAB" . yas-expand)))

;; A collection of default snippets for many languages, including C#
(use-package yasnippet-snippets
  :ensure t
  :after yasnippet
  :config
  (yas-reload-all))

;; Company + Yasnippet integration  *** NOT NEEDED with Corfu (no bridge required) ***
;; (add-hook 'company-mode-hook
;;           (defvar company-mode/enable-yas t)
;;           (defun company-mode/backend-with-yas (backend)
;;             (if (or (not company-mode/enable-yas) (and (consp backend) (member 'company-yasnippet backend)))
;;                 backend
;;               (append (if (consp backend) backend (list backend))
;;                       '(:with company-yasnippet))))
;;           (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends)))

;; avy { the vimeasymotion alternative }
(require 'avy)
;; Jump to a character in the visible window { best }
(global-set-key (kbd "C-:") 'avy-goto-char)
;; Jump to a line
(global-set-key (kbd "M-g a l") 'avy-goto-line)
;; ;; Jump to a word beginning ;;i don't think i need this
;; (global-set-key (kbd "C-'") 'avy-goto-word-1)


;; RSS feed reader {elfeed}
(use-package elfeed
  :ensure t)
(setq elfeed-feeds
      '("https://www.youtube.com/feeds/videos.xml?channel_id=UCX5lX80yKjkzyXQWkkm3rOQ"
        "https://www.youtube.com/feeds/videos.xml?channel_id=UCngn7SVujlvskHRvRKc1cTw"
        "https://www.youtube.com/feeds/videos.xml?channel_id=UC11DKpZ9mdjdb5fbdb7ulRw"))
(defun dt/elfeed-mark-all-read ()
  "Mark all Elfeed entries as read."
  (interactive)
  (elfeed-search-untag-all-unread))
(defun dt/elfeed-mark-all-unread ()
  "Mark all Elfeed entries as unread."
  (interactive)
  (elfeed-search-tag-all-unread))

;; ;; toggle evil-mode
;; (global-set-key (kbd "C-c e") #'evil-mode)

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
;; Global zoom (requires default-text-scale package)
;; --------------------
(use-package default-text-scale
  :config
  (global-set-key (kbd "C-=") 'default-text-scale-increase)
  (global-set-key (kbd "C--") 'default-text-scale-decrease))

;; --------------------
;; pandoc markdown to org in-place convertion
;; --------------------
;; (defun md-to-org (beg end)
;;   "Convert selected Markdown text to Org format in-place."
;;   (interactive "r")
;;   (unless (use-region-p)
;;     (user-error "No region selected"))

;;   (let* ((markdown (buffer-substring-no-properties beg end))
;;          ;; Requires pandoc installed
;;          (org-text
;;           (with-temp-buffer
;;             (insert markdown)
;;             (shell-command-on-region
;;              (point-min)
;;              (point-max)
;;              "pandoc -f markdown -t org"
;;              t t)
;;             (buffer-string))))

;;     (delete-region beg end)
;;     (goto-char beg)
;;     (insert org-text)))
(defun dt/md-to-org (beg end)
  "Convert selected Markdown text to Org format in-place."
  (interactive "r")
  (unless (use-region-p)
    (user-error "No region selected"))

  (let* ((markdown (buffer-substring-no-properties beg end))
         (org-text
          (with-temp-buffer
            (insert markdown)
            (shell-command-on-region
             (point-min)
             (point-max)
             "pandoc -f markdown -t org"
             t t)

            ;; Remove CUSTOM_ID property drawers
            (goto-char (point-min))
            (while (re-search-forward
                    "^:PROPERTIES:\n:CUSTOM_ID:.*\n:END:\n?"
                    nil t)
              (replace-match ""))

            (buffer-string))))

    (delete-region beg end)
    (goto-char beg)
    (insert org-text)))

(defun dt/org-to-md (beg end)
  "Convert selected Org text to Markdown format in-place."
  (interactive "r")
  (unless (use-region-p)
    (user-error "No region selected"))

  (let* ((org-text (buffer-substring-no-properties beg end))
         (md-text
          (with-temp-buffer
            (insert org-text)
            (shell-command-on-region
             (point-min)
             (point-max)
             "pandoc -f org -t gfm"
             t t)

            ;; Strip pandoc markdown attributes like {.done .DONE}
            (goto-char (point-min))
            (while (re-search-forward "{[^}]*}" nil t)
              (replace-match ""))

            (buffer-string))))

    (delete-region beg end)
    (goto-char beg)
    (insert md-text)))

(defun dt/html-to-org (beg end)
  "Convert selected HTML text to Org format in-place."
  (interactive "r")
  (unless (use-region-p)
    (user-error "No region selected"))

  (let* ((html (buffer-substring-no-properties beg end))
         (org-text
          (with-temp-buffer
            (insert html)
            (shell-command-on-region
             (point-min)
             (point-max)
             "pandoc -f html -t org"
             t t)

            ;; Remove CUSTOM_ID property drawers
            (goto-char (point-min))
            (while (re-search-forward
                    "^:PROPERTIES:\n:CUSTOM_ID:.*\n:END:\n?"
                    nil t)
              (replace-match ""))

            (buffer-string))))

    (delete-region beg end)
    (goto-char beg)
    (insert org-text)))

;; backups/auto-save now go to XDG cache dir (see top of file)
;; (setq make-backup-files nil) ; disable ~ backups  -- disabled: XDG paths handle this
;; (setq auto-save-default nil) ; disable #autosave# files -- disabled: XDG paths handle this


;; (use-package pcre2el
;;   :ensure t)

;; (use-package visual-regexp
;;   :ensure t)

;; (use-package visual-regexp-steroids
;;   :ensure t
;;   :after (visual-regexp pcre2el))
(defun my-replace-whole-buffer-if-no-region (orig-fun &rest args)
  (if (use-region-p)
      (apply orig-fun args)
    (save-excursion
      (mark-whole-buffer)
      (apply orig-fun args))))

(advice-add 'query-replace :around #'my-replace-whole-buffer-if-no-region)
(advice-add 'query-replace-regexp :around #'my-replace-whole-buffer-if-no-region)
(advice-add 'replace-string :around #'my-replace-whole-buffer-if-no-region)
(advice-add 'replace-regexp :around #'my-replace-whole-buffer-if-no-region)




;; ;; --------------------
;; ;; Consult (better buffer/file/search commands)
;; ;; --------------------
;; (when (require 'consult nil t)
;;   (global-set-key (kbd "C-s") #'consult-line)
;;   (global-set-key (kbd "C-x b") #'consult-buffer))

;; --------------------
;; SPC leader key (vanilla, no general.el needed)
;; --------------------
(define-key evil-normal-state-map (kbd "SPC") nil)
(define-key evil-motion-state-map (kbd "SPC") nil)

(let ((leader-map (make-sparse-keymap)))
  (define-key evil-normal-state-map (kbd "SPC") leader-map)
  (define-key evil-visual-state-map (kbd "SPC") leader-map)

  ;; Buffers
  (define-key leader-map (kbd "b") nil)
  (define-key leader-map (kbd "bb") (if (fboundp 'consult-buffer) #'consult-buffer #'switch-to-buffer))
  (define-key leader-map (kbd "bd") #'kill-current-buffer)
  (define-key leader-map (kbd "bi") #'ibuffer)
  (define-key leader-map (kbd "bs") #'save-buffer)

  ;; Files
  (define-key leader-map (kbd "f") nil)
  ;; (define-key leader-map (kbd "ff") #'find-file)
  (define-key leader-map (kbd "fs") #'save-buffer)
  (define-key leader-map (kbd "cfd") #'consult-fd)
  ;; (define-key leader-map (kbd "fr") (if (fboundp 'consult-recent-file) #'consult-recent-file #'recentf-open-files))

  ;; Projects
  (define-key leader-map (kbd "p") nil)
  (define-key leader-map (kbd "psp") #'project-switch-project)
  (define-key leader-map (kbd "pff") #'project-find-file)
  (define-key leader-map (kbd "pfd") #'project-find-dir)
  (define-key leader-map (kbd "pfg") #'project-find-regexp)
  (define-key leader-map (kbd "psb") #'project-switch-to-buffer)
  (define-key leader-map (kbd "pd") #'project-dired)
  (define-key leader-map (kbd "pe") (lambda () (interactive) (let ((default-directory (if-let* ((p (project-current))) (project-root p) default-directory))) (eshell t))))
  (define-key leader-map (kbd "pkb") #'project-kill-buffers)

  ;; Windows
  (define-key leader-map (kbd "w") nil)
  (define-key leader-map (kbd "wh") #'windmove-left)
  (define-key leader-map (kbd "wj") #'windmove-down)
  (define-key leader-map (kbd "wk") #'windmove-up)
  (define-key leader-map (kbd "wl") #'windmove-right)
  (define-key leader-map (kbd "wd") #'delete-window)
  (define-key leader-map (kbd "wo") #'delete-other-windows)
  (define-key leader-map (kbd "ws") #'split-window-below)
  (define-key leader-map (kbd "wv") #'split-window-right)

  ;; Quit
  (define-key leader-map (kbd "q") nil)
  (define-key leader-map (kbd "qq") #'save-buffers-kill-terminal)

  ;; Help
  (define-key leader-map (kbd "h") nil)
  (define-key leader-map (kbd "hf") #'describe-function)
  (define-key leader-map (kbd "hk") #'describe-key)
  (define-key leader-map (kbd "hv") #'describe-variable))



;; ;; --------------------
;; ;; list bindings
;; ;; --------------------
;; (defun list-bindings ()
;;   "List all commands with a keybinding, sorted by name."
;;   (interactive)
;;   (let* ((bindings '())
;;          (seen     (make-hash-table :test #'equal)))
;;     ;; Walk one keymap recursively
;;     (cl-labels ((walk (km)
;;                 (map-keymap
;;                  (lambda (_evt bind)
;;                    (cond
;;                     ((keymapp bind)  (walk bind))
;;                     ((and (commandp bind) (symbolp bind))
;;                      (unless (gethash bind seen)
;;                        (puthash bind t seen)
;;                        (let ((keys
;;                              (where-is-internal bind nil t)))
;;                          (when keys
;;                            (push
;;                             (cons (symbol-name bind)
;;                                   (key-description keys))
;;                             bindings))))))
;;                  km)))
;;       ;; Collect global + local + evil maps
;;       (dolist (km
;;                (append
;;                 (list (current-global-map)
;;                       (current-local-map))
;;                 (when (featurep 'evil)
;;                   (list evil-normal-state-map
;;                         evil-insert-state-map
;;                         evil-visual-state-map
;;                         evil-motion-state-map
;;                         evil-emacs-state-map))))
;;         (when km (walk km)))
;;       ;; Sort by function name
;;       (setq bindings
;;             (sort bindings
;;                   (lambda (a b) (string< (car a) (car b)))))
;;       ;; Render in temp buffer
;;       (with-current-buffer (get-buffer-create "*keybindings*")
;;         (let ((inhibit-read-only t))
;;           (erase-buffer)
;;           (insert (format "%-50s %s\n" "Function" "Keybinding"))
;;           (insert (make-string 70 ?=) "\n\n")
;;           (pcase-dolist (`(,cmd . ,keys) bindings)
;;             (insert (format "%-50s ==>  %s\n" cmd keys)))
;;           (goto-char (point-min))
;;           (setq buffer-read-only t))
;;         (display-buffer (current-buffer))
;;         (message "Found %d keybindings" (length bindings)))))
;; ;; Bind it
;; (global-set-key (kbd "C-c k") #'list-bindings)

;; --------------------
;; list bindings, you could just use `C-h b` .. but i created mine .. cuz why not
;; --------------------
(defun list-bindings ()
  "List all commands with a keybinding, sorted by name."
  (interactive)
  (let* ((bindings '())
         (seen (make-hash-table :test #'equal)))

    (cl-labels
        ((walk (km)
           (map-keymap
            (lambda (_evt bind)
              (cond
               ((keymapp bind)
                (walk bind))
               ((and (commandp bind) (symbolp bind))
                (unless (gethash bind seen)
                  (puthash bind t seen)
                  (let ((keys (where-is-internal bind nil t)))
                    (when keys
                      (push (cons (symbol-name bind)
                                  (key-description keys))
                            bindings)))))))
            km)))

      ;; Walk maps
      (dolist (km
               (append
                (list (current-global-map)
                      (current-local-map))
                (when (featurep 'evil)
                  (list evil-normal-state-map
                        evil-insert-state-map
                        evil-visual-state-map
                        evil-motion-state-map
                        evil-emacs-state-map))))
        (when km (walk km)))

      ;; Sort
      (setq bindings
            (sort bindings
                  (lambda (a b) (string< (car a) (car b)))))

      ;; Output buffer
      (with-current-buffer (get-buffer-create "*keybindings*")
        (let ((inhibit-read-only t))
          (erase-buffer)
          (insert (format "%-50s %s\n" "Function" "Keybinding"))
          (insert (make-string 70 ?=) "\n\n")
          (pcase-dolist (`(,cmd . ,keys) bindings)
            (insert (format "%-50s ==>  %s\n" cmd keys)))
          (goto-char (point-min))
          (setq buffer-read-only t))
        (display-buffer (current-buffer))
        (message "Found %d keybindings" (length bindings))))))

;; Bind it
(global-set-key (kbd "C-c k") #'list-bindings)

;; esc as ctrl g or cancel cmd
(keymap-global-set "<escape>" #'keyboard-escape-quit)


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


;; ;; delsel , just select , type ==> and selection is deleted
;; (use-package delsel
;;   :ensure nil
;;   :config
;;   (delete-selection-mode 1))

;;(delete-selection-mode 1)

;; alternative buffer fast switching
(global-set-key (kbd "C-x C-a") #'mode-line-other-buffer)

;; denote
;; Remember that the website version of this manual shows the latest
;; developments, which may not be available in the package you are
;; using.  Instead of copying from the web site, refer to the version
;; of the documentation that comes with your package.  Evaluate:
;;
;;     (info "(denote) Sample configuration")
(use-package denote
  :ensure t
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c d n" . denote)
   ("C-c d r" . denote-rename-file)
   ("C-c d l" . denote-link)
   ("C-c d b" . denote-backlinks)
   ("C-c d d" . denote-dired)
   ("C-c d g" . denote-grep))
  :config
  (setq denote-directory (expand-file-name "/mnt/hdd/obsi/vault_bank/core/"))
  (make-directory denote-directory t)

  ;; Automatically rename Denote buffers when opening them so that
  ;; instead of their long file name they have, for example, a literal
  ;; "[D]" followed by the file's title.  Read the docstring of
  ;; `denote-rename-buffer-format' for how to modify this.
  (denote-rename-buffer-mode 1)

  ;; Optional: convert current non-Denote file to Denote format
  (defun dt/denote-convert-current-file ()
    "Convert current buffer's file to Denote format.
Prompts for title/keywords, uses file's modification time.
Moves file to denote-directory with proper naming."
    (interactive)
    (let* ((file (buffer-file-name))
           (title (read-string "Title: " (file-name-base file)))
           (keywords (read-string "Keywords (space-separated): " ""))
           (date (or (buffer-file-attribute 'time-modified)
                     (current-time)))
           (new-name (denote--rename-file file title
                            (when keywords (split-string keywords))
                            nil date nil)))
      (when new-name
        (rename-file file new-name t)
        (message "Converted to: %s" new-name)))))

(add-to-list 'load-path "/home/dt/.emacs.d/elpa/denote-explore-20260823/")
(use-package denote-explore
  :load-path "/home/dt/.emacs.d/elpa/denote-explore-20260823/"
  :custom
  ;; Where to store network data and in which format
  (denote-explore-network-directory "/mnt/hdd/obsi/vault_bank/core/")
  (denote-explore-network-filename "denote-network")
  ;; (denote-explore-network-keywords-ignore "<keywords list>")
  ;; (denote-explore-network-regex-ignore "<regex>")
  (denote-explore-network-format 'd3.js)
  (denote-explore-network-d3-colours 'SchemeObservable10)
  (denote-explore-network-d3-js "https://d3js.org/d3.v7.min.js")
  ;; (denote-explore-network-d3-template "<file path>")
  ;; (denote-explore-network-graphviz-header "<header strings>")
  (denote-explore-network-graphviz-filetype 'svg)
  :bind
  (;; Statistics
   ("C-c e s n" . denote-explore-count-notes)
   ("C-c e s k" . denote-explore-count-keywords)
   ("C-c e s e" . denote-explore-barchart-filetypes)
   ("C-c e s w" . denote-explore-barchart-keywords)
   ("C-c e s t" . denote-explore-barchart-timeline)
   ;; Random walks
   ("C-c e w n" . denote-explore-random-note)
   ("C-c e w r" . denote-explore-random-regex)
   ("C-c e w l" . denote-explore-random-link)
   ("C-c e w k" . denote-explore-random-keyword)
   ;; Denote Janitor
   ("C-c e j d" . denote-explore-duplicate-notes)
   ("C-c e j D" . denote-explore-duplicate-notes-dired)
   ("C-c e j l" . denote-explore-missing-links)
   ("C-c e j z" . denote-explore-zero-keywords)
   ("C-c e j s" . denote-explore-single-keywords)
   ("C-c e j r" . denote-explore-rename-keywords)
   ("C-c e j y" . denote-explore-sync-metadata)
   ("C-c e j i" . denote-explore-isolated-files)
   ;; Visualise denote
   ("C-c e n" . denote-explore-network)
   ("C-c e r" . denote-explore-network-regenerate)
   ("C-c e d" . denote-explore-barchart-degree)
   ("C-c e b" . denote-explore-barchart-backlinks)))

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


;; --------------------
;; emacsclient server
;; --------------------
(condition-case nil
    (server-start)
  (error
   (server-force-delete)
   (server-start)))

;; golden-ratio { TEMPORARILY DISABLED - may block corfu popup }
;; (unless (package-installed-p 'golden-ratio)
;;   (package-refresh-contents)
;;   (package-install 'golden-ratio))
;; (require 'golden-ratio)
;; (golden-ratio-mode 1)

;; CF project layout
(defvar dt/cp-term-buffer nil
  "Persistent vterm buffer used by `dt/cp-term-toggle'.")

(defvar-local dt/cp-term-dir nil
  "Directory this vterm was last cd'd into.")

(defun dt/cp-dir ()
  "Return the CP problem directory of the current buffer, or nil."
  (when-let* ((file (buffer-file-name))
              (dir (file-name-directory file))
              (root (expand-file-name "~/cp/")))
    (when (and (string-prefix-p root dir)
               (not (string= root dir)))
      (directory-file-name dir))))

(defun dt/cp-term-toggle ()
  "Toggle a plain vterm window rooted at the current CP problem dir."
  (interactive)
  (let ((win (and (buffer-live-p dt/cp-term-buffer)
                  (get-buffer-window dt/cp-term-buffer t))))
    (if win
        ;; close: guard against sole/minibuffer window
        (condition-case nil
            (delete-window win)
          (error (switch-to-buffer (other-buffer))))
      ;; open: dumb split right of the current window
      (let ((dir (or (dt/cp-dir) default-directory)))
        (split-window-right)
        (other-window 1)
        (if (buffer-live-p dt/cp-term-buffer)
            (switch-to-buffer dt/cp-term-buffer)
          (vterm "*dt-cp-term*")
          (setq dt/cp-term-buffer (current-buffer)))
        ;; cd only when the project changed, so a running run.sh is not interrupted
        (unless (equal dt/cp-term-dir dir)
          (vterm-send-string (concat "cd " dir))
          (vterm-send-return)
          (setq dt/cp-term-dir dir))))))

(defun dt/cp-open (dir &optional mainfile)
  "Open CP problem: main file only; C-` toggles a vterm for run.sh."
  (interactive (list (read-directory-name "CP dir: " "~/cp/")
                     (read-string "Main file: " "Program.cs")))
  (delete-other-windows)
  (find-file (expand-file-name (or mainfile "Program.cs") dir)))

(global-set-key (kbd "C-`") #'dt/cp-term-toggle)

;; search vault bank (by name) (vault picker)
(defun dt/vault-picker ()
  (interactive)
  (let ((default-directory (expand-file-name "/mnt/hdd/obsi/vault_bank/")))
    (call-interactively #'consult-find)))
(global-set-key (kbd "C-c v p") #'dt/vault-picker)

;; search vault bank (by name) (vault new note)
(defun dt/vault-new ()
  (interactive)
  (let ((default-directory (expand-file-name "/mnt/hdd/obsi/vault_bank/")))
    (call-interactively #'find-file)))
(global-set-key (kbd "C-c v n") #'dt/vault-new)

;; search vault bank (by content) (vault grep)
(defun dt/vault-grep ()
  (interactive)
  (let ((default-directory (expand-file-name "/mnt/hdd/obsi/vault_bank/")))
    (call-interactively #'consult-grep)))
(global-set-key (kbd "C-c v g") #'dt/vault-grep)

;; wiki link style for .md
(defun dt/insert-link (file title)
  (interactive
   (progn
     (unless (eq major-mode 'markdown-mode)
       (user-error "Only usable in markdown buffers"))
     (let* ((vault-dir (expand-file-name "/mnt/hdd/obsi/vault_bank/"))
            (files (directory-files-recursively vault-dir "" t))
            (files (mapcar (lambda (f) (file-relative-name f vault-dir)) files))
            (file (completing-read "Link to: " files nil t)))
       (list file
             (read-string "Link text: "
                          (file-name-sans-extension (file-name-base file)))))))
  (insert (format "[[%s|%s]]" file title)))
(global-set-key (kbd "C-c v l") #'dt/insert-link)


;; random note
(defun dt/vault-random ()
  (interactive)
  (let* ((vault-dir (expand-file-name "/mnt/hdd/obsi/vault_bank/"))
         (files (directory-files-recursively
                 vault-dir
                 "\\.\\(md\\|org\\)\\'"
                 t)))
    (if files
        (find-file (nth (random (length files)) files))
      (message "No .md or .org files in vault"))))

(global-set-key (kbd "C-c v r") #'dt/vault-random)

;; fast file reload
(global-auto-revert-mode 1)


(electric-pair-mode 1)           ;; auto-close brackets {} [] () "" etc.
(setq-default tab-width 2)       ;; display width
(setq-default c-basic-offset 2)  ;; C#/C indent


; ;; org refactor after md-to-org
; (defun dt/org-refactor-region (beg end)
;   "Refactor the selected Org region.
; - Delete every line starting with \"---\".
; - Demote every Org heading by one level."
;   (interactive "r")
;   (unless (use-region-p)
;     (user-error "No region selected"))
;   (save-excursion
;     (save-restriction
;       (narrow-to-region beg end)
;       ;; Delete separator lines.
;       (goto-char (point-min))
;       (flush-lines "^---")
;       ;; Demote every heading by one level.
;       (goto-char (point-min))
;       (while (re-search-forward "^\\(\\*+\\) " nil t)
;         (replace-match (concat (match-string 1) "* ") t t)))))

(defun dt/org-refactor-region (beg end)
  "Refactor the selected Org region.

- Delete every line starting with \"---\".
- Demote every Org heading by one level.
- Strip heading markers from level-4+ headings."
  (interactive "r")
  (unless (use-region-p)
    (user-error "No region selected"))
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)

      ;; Delete separator lines.
      (goto-char (point-min))
      (flush-lines "^---")

      ;; Demote every heading by one level.
      (goto-char (point-min))
      (while (re-search-forward "^\\(\\*+\\) " nil t)
        (replace-match (concat (match-string 1) "* ") t t)))))

(defun dt/org-strip-headings (beg end)
  "Strip Org heading markers from level-4+ headings in the selected region.

Examples:
**** Learn:    -> Learn:
***** Features -> Features
****** Notes   -> Notes"
  (interactive "r")
  (unless (use-region-p)
    (user-error "No region selected"))
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (re-search-forward "^\\*\\{4,\\}[ \t]+" nil t)
        (replace-match "" t t)))))
(put 'narrow-to-region 'disabled nil)

;; i installed (key-quiz package)
(use-package key-quiz
  :ensure t)

;; i installed (evil-surround)
(use-package evil-surround
  :ensure t)

(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; --------------------
;; Markdown - org-like cycling + navigation for evil
;; --------------------
(with-eval-after-load 'markdown-mode
  (evil-define-key 'normal markdown-mode-map
    (kbd "TAB")       #'markdown-cycle
    (kbd "<backtab>") #'markdown-shifttab
    "gx"              #'markdown-follow-thing-at-point))


;; i installed (consult)
(use-package consult
  :ensure t

  :bind
  (("C-c r" . consult-ripgrep))
  )

(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
    ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  ;;:init
  ;; Optionally replace the key help with a completing-read interface
  ;;(setq prefix-help-command #'embark-prefix-help-command)
  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:
  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)
  ;; Add Embark to the mouse context menu. Also enable `context-menu-mode'.
  ;; (context-menu-mode 1)
  ;; (add-hook 'context-menu-functions #'embark-context-menu 100)
  ;;:config
  ;; Hide the mode line of the Embark live/completions buffers
 ;; (add-to-list 'display-buffer-alist
 ;;              '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
 ;;                nil
 ;;                (window-parameters (mode-line-format . none)))))
  )
;; Consult users will also want the embark-consult package.
; only need to install it, embark loads it after consult if found
(use-package embark-consult
  :ensure t)

;; ;; transparency
;; (add-to-list 'default-frame-alist '(alpha . 50))

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

;; embark (custom vertical/horizontal splits)
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

;; auto select/focus newly opened help buffers
(setq help-window-select t)

;; ;; multi-cursors (disabled — replaced by evil-mc)
;; (global-unset-key (kbd "M-<down-mouse-1>"))
;; (use-package multiple-cursors
;;   :ensure t
;;   :bind
;;   (("C->"   . mc/mark-next-like-this)
;;    ("C-<"   . mc/mark-previous-like-this)
;;    ("C-c m m a" . mc/mark-all-like-this)
;;    ("C-c m e l" . mc/edit-lines)))
;; (with-eval-after-load 'evil
;;   (global-set-key (kbd "M-<down-mouse-1>") #'mc/add-cursor-on-click))

;; --------------------
;; evil-mc (multi-cursors, evil-native)
;; --------------------
(use-package evil-mc
  :ensure t
  :after evil
  :config
  (global-evil-mc-mode 1))


;; --------------------
;; magit, just trying
;; --------------------


(use-package magit
  :ensure t
  )
