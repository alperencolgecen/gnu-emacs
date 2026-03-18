;;; font.el --- Font and Typography Configuration

;; Set default font with fallback
(condition-case nil
    (set-face-attribute 'default nil
      :font "JetBrains Mono"
      :weight 'regular
      :height 130)
  (error
   (set-face-attribute 'default nil
     :font "Courier New"
     :weight 'regular
     :height 130)))

;; Configure emoji support
(set-fontset-font t 'emoji "Noto Color Emoji" nil 'append)

;; Configure line numbers for programming
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Set fringe width (visual setting)
(set-fringe-mode 10)