;;; editor.el --- Core Editor Configuration

;; UTF-8 encoding everywhere
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Indentation settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Editing behaviors
(electric-pair-mode 1)
(delete-selection-mode 1)
(global-visual-line-mode 1)

;; File management
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(desktop-save-mode 1)

;; Backup configuration
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)

;; Kill ring and auto-save
(setq kill-ring-max 100)
(auto-save-visited-mode 1)
(setq auto-save-visited-interval 1)
(setq save-silently t)

;; Search configuration
(setq isearch-wrap-pause 'no)
(setq isearch-lazy-highlight t)
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")
(setq-default case-fold-search t)