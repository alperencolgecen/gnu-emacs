;;; keybindings.el --- Key Bindings Configuration

;; Enable CUA mode for standard editing
(cua-mode 1)
(setq shift-selection-mode t)

;; Unbind help key to free it up
(global-unset-key (kbd "C-h"))

;; File operations
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-S-s") 'write-file)
(global-set-key (kbd "C-k C-o") 'find-file)

;; Search and replace
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-S-f") 'isearch-backward)
(global-set-key (kbd "C-h") 'query-replace)
(global-set-key (kbd "C-r") 'recentf-open-files)

;; Navigation
(global-set-key (kbd "M-g") 'goto-line)

;; UI toggles
(global-set-key (kbd "<f7>") 'my/toggle-ui)
(global-set-key (kbd "<f9>") 'my/toggle-ui)

;; Text scaling
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; Ghost lock function
(defun my/ghost-lock ()
  "Hide cursor and block all input until F12 is pressed."
  (interactive)
  (setq-default cursor-type nil)
  (setq cursor-type nil)
  (message "Ghost lock active - press F12 to unlock")
  (let ((event (read-event)))
    (while (not (eq event 'f12))
      (setq event (read-event))))
  (setq-default cursor-type 'bar)
  (setq cursor-type 'bar)
  (message "Ghost lock disabled"))

(global-set-key (kbd "<f12>") 'my/ghost-lock)