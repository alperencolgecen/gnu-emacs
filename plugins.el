;;; plugins.el --- Plugin Configuration

;; Rainbow delimiters for programming
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Modern completion framework
(vertico-mode 1)
(marginalia-mode 1)

;; Enhanced completion style
(setq completion-styles '(orderless basic))

;; Key binding helper
(which-key-mode 1)
(setq which-key-idle-delay 0.3)

;; Auto-completion
(global-company-mode 1)
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 2)

;; File tree
(require 'treemacs)
(global-set-key (kbd "<f8>") 'treemacs)

;; Window navigation
(global-set-key (kbd "M-o") 'ace-window)

;; Fast navigation
(global-set-key (kbd "M-s") 'avy-goto-char-2)

;; Git integration
(global-set-key (kbd "C-x g") 'magit-status)