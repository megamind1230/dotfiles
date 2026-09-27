;;; early-init.el --- Emacs early init -*- lexical-binding: t; -*-

;; Increase GC threshold during startup (reset later in init.el)
(setq gc-cons-threshold most-positive-fixnum)

;; Disable GUI elements early
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)

;; Prevent the glimpse of un-styled Emacs by setting background early
;; (add-to-list 'default-frame-alist '(background-color . "#282c34"))

;; Prefer loading .elc files for faster startup
(setq load-prefer-newer nil)

;; init.el calls package-initialize itself (after requiring compile, so that
;; typst-ts-mode autoloads resolve). Skip the automatic pre-init call so
;; autoloads are only loaded once, in the right order.
(setq package-enable-at-startup nil)

(provide 'early-init)
;;; early-init.el ends here
