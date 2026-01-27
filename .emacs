;; --------------------
;;melpa
;; --------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
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

;;idk whether to enable this block or not
;; Keep auto-save and backup files in one flat directory
;; (instead of next to the original files)
;; (setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
;; Store custom variables in ~/.emacs.d/custom.el (instead of ~/.emacs)
;;(setq custom-file (locate-user-emacs-file "custom.el"))


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

;; I installed which-key gnu
;; enable which-key mode
(which-key-mode 1)

;; disable bell sound, but use visible instead
(setq ring-bell-function 'ignore)
(setq visible-bell t)

;; installed corfu / corfu-terminal / cape
;; Enable indentation and completion using the TAB key.
;;(setq tab-always-indent 'complete)
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
;; gcc AND gc to comment/uncomment
;; --------------------
(defun my/comment-line ()
  "Comment or uncomment the current line."
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
  (forward-line 1))
;; Using evil-mode style keybindings (recommended approach)
;; If you're using evil-mode:
(with-eval-after-load 'evil
  ;;jk as esc
  (define-key evil-insert-state-map (kbd "j k") 'evil-normal-state)
  ;; Make gc an operator that works with motions (like gcap, gc5j, etc.)
  (evil-define-operator my/evil-comment-operator (beg end)
    "Comment or uncomment region."
    (comment-or-uncomment-region beg end))
  (define-key evil-normal-state-map "gc" 'my/evil-comment-operator)
  (define-key evil-visual-state-map "gc" 'my/evil-comment-operator)
  ;; gcc comments the current line
  (define-key evil-normal-state-map "g c c" 'my/comment-line))


;; --------------------
;; scratch buffer as default on startup, with no dashboard
;; --------------------
;; (defun my-emacs-startup ()
;;   "Start Emacs with *scratch* buffer."
;;   (get-buffer-create "*scratch*"))
;; (setq initial-buffer-choice #'my-emacs-startup)
;; (setq dashboard-set-init-info nil)
(setq initial-major-mode 'org-mode)
(setq inhibit-startup-screen t)
(setq initial-scratch-message
      "")


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
(setq org-directory (expand-file-name "~/org"))
(setq org-agenda-files (list org-directory))
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
;; Keybindings
;; --------------------
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c a") #'org-agenda)
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


;; --------------------
;; theme
;; --------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773"
     "36d4b9573ed57b3c53261cb517eef2353058b7cf95b957f691f5ad066933ae84"
     "0f9a1b7a0f1d09544668297c1f04e5a5452ae1f4cf69f11b125f4cff1d54783d"
     "efcecf09905ff85a7c80025551c657299a4d18c5fcfedd3b2f2b6287e4edd659"
     "57a29645c35ae5ce1660d5987d3da5869b048477a7801ce7ab57bfb25ce12d3e"
     "833ddce3314a4e28411edf3c6efde468f6f2616fc31e17a62587d6a9255f4633"
     "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36"
     "2b0fcc7cc9be4c09ec5c75405260a85e41691abb1ee28d29fcd5521e4fca575b"
     "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c"
     "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7"
     "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1"
     "7fea145741b3ca719ae45e6533ad1f49b2a43bf199d9afaee5b6135fd9e6f9b8"
     "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5"
     default))
 '(package-selected-packages '(drag-stuff evil solarized-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(load-theme 'solarized-dark t)


;; --------------------
;; recent files
;; --------------------
(recentf-mode 1)
(global-set-key (kbd "C-x C-r") #'recentf-open-files)


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

;; --------------------
;; search selected in browser, chatgpt
;; --------------------
(defun my/search-selected-text ()
  (interactive)
  (if (use-region-p)
      (browse-url
       (concat "https://duckduckgo.com/?q="
               (url-hexify-string
                (buffer-substring-no-properties
                 (region-beginning)
                 (region-end)))))
    (message "No region selected")))
(defun my/ask-chatgpt-browser ()
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
