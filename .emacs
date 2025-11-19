;;melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
;; Refresh package contents if not already done
(unless package-archive-contents
  (package-refresh-contents))

;; setup theme
(load-theme 'leuven-dark)

;; shift+arrow to change window
(windmove-default-keybindings)

;; save cursor place in killed files
(save-place-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cape consult corfu corfu-terminal evil lv orderless use-package
          vertico which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; setup completion
(vertico-mode)
(setq completion-styles '(orderless basic))
(global-set-key (kbd "C-x b") 'consult-buffer)

;;i installed which-key gnu

;; no menu/tool/scroll bars
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)
(menu-bar-mode -1)

;;idk whether to enable this block or not
;; Keep auto-save and backup files in one flat directory
;; (instead of next to the original files)
;; (setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
;; Store custom variables in ~/.emacs.d/custom.el (instead of ~/.emacs)
;;(setq custom-file (locate-user-emacs-file "custom.el"))


;; Do not ask for permission to kill a buffer (unless it is modified)
(global-set-key (kbd "C-x k") 'kill-current-buffer)

;; spaces over tabs
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


;; enable which-key mode
(which-key-mode 1)

;; disable bell sound, but use visible instead
(setq ring-bell-function 'ignore)
(setq visible-bell t)

;; installed corfu / corfu-terminal / cape
;; Enable indentation and completion using the TAB key.
(setq tab-always-indent 'complete)
;; Make the completion suggest file paths.
(add-hook 'completion-at-point-functions #'cape-file)
;; Activate in buffer completion everywhere.
(global-corfu-mode)
;; enable corfu in terminal.
;; This is needed until child frame support for terminal Emacs arrives.
(unless (display-graphic-p) (corfu-terminal-mode +1))
;; For manual corfu, use SPC to add orderless separator.
(keymap-set corfu-map "SPC"  'corfu-insert-separator)
;; show completion automatically after a short delay
(setq corfu-auto t)

;; ;; gcc AND gc to comment/uncomment
;; Comment region with 'gc' and comment line with 'gcc'
;; Add this to your init.el or .emacs file
(defun my/comment-line ()
  "Comment or uncomment the current line."
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
  (forward-line 1))
;; Using evil-mode style keybindings (recommended approach)
;; If you're using evil-mode:
(with-eval-after-load 'evil
  ;; Make gc an operator that works with motions (like gcap, gc5j, etc.)
  (evil-define-operator my/evil-comment-operator (beg end)
    "Comment or uncomment region."
    (comment-or-uncomment-region beg end))
  (define-key evil-normal-state-map "gc" 'my/evil-comment-operator)
  (define-key evil-visual-state-map "gc" 'my/evil-comment-operator)
  ;; gcc comments the current line
  (define-key evil-normal-state-map "gcc" 'my/comment-line))

;; show line numbers
(global-display-line-numbers-mode 1)

;; smartly wrap lines
(visual-line-mode 1)
