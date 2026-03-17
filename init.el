;;; init.el --- My Personal Emacs Configuration

;;; --- 1. BOOTSTRAP ---
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;; --- 2. LOAD MODULES ---
(dolist (module '("packages" "performance" "ui" "font" "editor" "theme" "plugins" "keybindings"))
  (load (expand-file-name (concat module ".el") user-emacs-directory)))

