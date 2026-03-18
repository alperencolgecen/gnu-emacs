;;; layout.el --- Frame Layout and Window Configuration

;;; --- Frame Layout ---
;; Frame positioning and sizing
(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      window-resize-pixelwise t)

;; Default frame size and position
(when window-system
  (setq default-frame-alist '((width . 120) (height . 40)
                              (left . 0.5) (top . 0.5)
                              (fullscreen . fullheight))))

;;; --- Window Layout ---
;; Window dividers and spacing
(setq window-divider-default-places t
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1)
(window-divider-mode 1)

;; Window margins and padding
(setq-default window-margins nil)
(defun my/set-window-margins ()
  "Set window margins for better readability."
  (set-window-margins nil 10 10))
(add-hook 'window-configuration-change-hook #'my/set-window-margins)

;; Split window preferences
(setq split-width-threshold 160
      split-height-threshold nil
      window-combination-resize t)

;;; --- Fringe Configuration ---
;; Fringe settings (already set in ui.el, but enhanced here)
(set-fringe-mode 10)
(setq fringe-indicator-alist '((truncation . nil)
                               (continuation . nil)
                               (overlay . nil)
                               (arrow . nil)))

;;; --- Line and Column Spacing ---
;; Line spacing for better readability
(setq-default line-spacing 0.1)

;; Column number display (already in ui.el)
(column-number-mode 1)

;;; --- Scroll Configuration ---
;; Smooth scrolling (already in ui.el, but enhanced)
(setq scroll-conservatively 101
      scroll-margin 3
      scroll-preserve-screen-position t
      mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse 't)

;;; --- Tab Bar Configuration ---
;; Minimalist tab bar
(setq tab-bar-close-button-show nil
      tab-bar-new-button-show nil
      tab-bar-tab-handles t)

;;; --- Minibuffer Configuration ---
;; Minibuffer behavior
(setq minibuffer-prompt-properties '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt))

;;; --- Layout Utility Functions ---
(defun my/toggle-fullscreen ()
  "Toggle fullscreen mode."
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(defun my/reset-layout ()
  "Reset window layout to default."
  (interactive)
  (delete-other-windows)
  (balance-windows)
  (my/set-window-margins))

(provide 'layout)
;;; layout.el ends here
