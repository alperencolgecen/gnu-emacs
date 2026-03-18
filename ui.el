;;; ui.el --- User Interface Configuration

;; Disable visual clutter
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

;; Disable startup screen and message
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;; Enable useful visual aids
(global-hl-line-mode 1)
(show-paren-mode 1)
(setq show-paren-style 'mixed)
(column-number-mode 1)
(size-indication-mode 1)

;; Configure fringe and frame title
(set-fringe-mode 10)
(setq frame-title-format '("%b — Emacs"))

;; Cursor configuration
(setq-default cursor-type 'bar)
(setq cursor-type 'bar)
(blink-cursor-mode -1)

;; Smooth scrolling behavior
(setq scroll-conservatively 101)
(setq scroll-margin 3)
(setq scroll-preserve-screen-position t)

;; Neon mode-line styling
(custom-set-faces
 '(mode-line ((t (:foreground "#00FFFF" :background "#0d0d1a" :box (:line-width 1 :color "#00FFFF")))))
 '(mode-line-inactive ((t (:foreground "#005f5f" :background "#0d0d1a" :box (:line-width 1 :color "#003f3f"))))))

;; Toggle UI elements function
(defun my/toggle-ui ()
  "Toggle menu-bar, tool-bar, and scroll-bar visibility."
  (interactive)
  (if menu-bar-mode
      (progn
        (menu-bar-mode -1)
        (tool-bar-mode -1)
        (scroll-bar-mode -1)
        (message "UI elements hidden"))
    (progn
      (menu-bar-mode 1)
      (tool-bar-mode 1)
      (scroll-bar-mode 1)
      (message "UI elements shown"))))