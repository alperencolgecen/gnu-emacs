;;; splash.el --- Minimalist Startup Screen

;;; --- 1. SPLASH SCREEN CONFIGURATION ---

(defvar my/splash-buffer "*Splash*"
  "Name of the splash buffer.")

(defvar my/splash-enabled t
  "Enable/disable splash screen.")

(defvar my/splash-timeout 10
  "Auto-hide splash screen after N seconds (0 = disabled).")

;;; --- 2. SPLASH CONTENT ---

(defun my/splash-create-content ()
  "Create splash screen content."
  `(
    ;; Header
    ,(propertize "╔══════════════════════════════════════════════════════════════╗\n" 
                'face '(:foreground "#00FFFF"))
    ,(propertize "║                    GNU EMACS CONFIGURATION                ║\n" 
                'face '(:foreground "#00FFFF" :bold t))
    ,(propertize "╚══════════════════════════════════════════════════════════════╝\n\n" 
                'face '(:foreground "#00FFFF"))

    ;; Welcome message
    ,(propertize "Welcome to Emacs!\n\n" 
                'face '(:foreground "#FFFFFF" :height 1.2))

    ;; Quick actions
    ,(propertize "Quick Actions:\n" 
                'face '(:foreground "#00FFFF" :bold t))
    "  "
    ,(propertize "n" 'face '(:foreground "#FFFF00"))
    " - New file\n"
    "  "
    ,(propertize "o" 'face '(:foreground "#FFFF00"))
    " - Open file\n"
    "  "
    ,(propertize "r" 'face '(:foreground "#FFFF00"))
    " - Recent files\n"
    "  "
    ,(propertize "p" 'face '(:foreground "#FFFF00"))
    " - Project files\n"
    "  "
    ,(propertize "b" 'face '(:foreground "#FFFF00"))
    " - Bookmarks\n"
    "  "
    ,(propertize "s" 'face '(:foreground "#FFFF00"))
    " - Scratch buffer\n"
    "\n"

    ;; Recent files
    ,(propertize "Recent Files:\n" 
                'face '(:foreground "#00FFFF" :bold t))
    ,@(my/splash-recent-files)
    "\n"

    ;; Statistics
    ,(propertize "Statistics:\n" 
                'face '(:foreground "#00FFFF" :bold t))
    ,(format "  Emacs version: %s\n" emacs-version)
    ,(format "  Uptime: %s\n" (my/splash-uptime))
    ,(format "  Files edited: %d\n" (my/splash-files-count))
    ,(format "  Sessions: %d\n" (my/splash-sessions-count))
    "\n"

    ;; Footer
    ,(propertize "Press any key to continue, or 'q' to quit splash screen\n" 
                'face '(:foreground "#808080"))
    ))

;;; --- 3. SPLASH HELPER FUNCTIONS ---

(defun my/splash-recent-files ()
  "Get recent files list for splash screen."
  (let ((recent-files (recentf-list))
        (count 0)
        (result '()))
    (dolist (file recent-files)
      (when (< count 5)
        (setq result 
              (cons (format "  %s\n" 
                           (propertize (file-name-nondirectory file) 
                                      'face '(:foreground "#00FF00")
                                      'mouse-face '(:background "#003300")
                                      'help-echo file))
                    result))
        (setq count (1+ count))))
    (nreverse result)))

(defun my/splash-uptime ()
  "Get system uptime string."
  (let ((uptime (emacs-uptime)))
    (format "%.0f days, %.0f hours, %.0f minutes"
            (/ uptime 86400)
            (mod (/ uptime 3600) 24)
            (mod (/ uptime 60) 60))))

(defun my/splash-files-count ()
  "Count files edited in current session."
  (length (buffer-list)))

(defun my/splash-sessions-count ()
  "Count total sessions."
  (let ((desktop-file (expand-file-name "desktop" "~/.emacs.d/desktop/")))
    (if (file-exists-p desktop-file) 1 0)))

;;; --- 4. SPLASH DISPLAY AND MANAGEMENT ---

(defun my/splash-show ()
  "Show splash screen."
  (when my/splash-enabled
    (let ((buffer (get-buffer-create my/splash-buffer)))
      (with-current-buffer buffer
        (setq buffer-read-only nil)
        (erase-buffer)
        (dolist (line (my/splash-create-content))
          (insert line))
        (setq mode-line-format nil
              header-line-format nil
              cursor-type nil)
        (setq buffer-read-only t)
        (use-local-map (my/splash-keymap))
        (goto-char (point-min)))
      (switch-to-buffer buffer)
      (when (> my/splash-timeout 0)
        (run-with-timer my/splash-timeout nil 'my/splash-hide)))))

(defun my/splash-hide ()
  "Hide splash screen."
  (when (get-buffer my/splash-buffer)
    (kill-buffer my/splash-buffer)))

(defun my/splash-toggle ()
  "Toggle splash screen."
  (interactive)
  (setq my/splash-enabled (not my/splash-enabled))
  (message "Splash screen %s" (if my/splash-enabled "enabled" "disabled")))

;;; --- 5. SPLASH KEYMAP ---

(defun my/splash-keymap ()
  "Create keymap for splash screen."
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "n") 'my/splash-new-file)
    (define-key map (kbd "o") 'my/splash-open-file)
    (define-key map (kbd "r") 'my/splash-recent-files)
    (define-key map (kbd "p") 'my/splash-project-files)
    (define-key map (kbd "b") 'my/splash-bookmarks)
    (define-key map (kbd "s") 'my/splash-scratch)
    (define-key map (kbd "q") 'my/splash-quit)
    (define-key map [t] 'my/splash-quit) ; Any other key quits
    map))

;;; --- 6. SPLASH ACTION FUNCTIONS ---

(defun my/splash-new-file ()
  "Create new file from splash screen."
  (interactive)
  (my/splash-hide)
  (call-interactively 'find-file))

(defun my/splash-open-file ()
  "Open file from splash screen."
  (interactive)
  (my/splash-hide)
  (call-interactively 'find-file-existing))

(defun my/splash-recent-files ()
  "Show recent files from splash screen."
  (interactive)
  (my/splash-hide)
  (call-interactively 'recentf-open-files))

(defun my/splash-project-files ()
  "Show project files from splash screen."
  (interactive)
  (my/splash-hide)
  (if (fboundp 'projectile-find-file)
      (call-interactively 'projectile-find-file)
    (call-interactively 'find-file)))

(defun my/splash-bookmarks ()
  "Show bookmarks from splash screen."
  (interactive)
  (my/splash-hide)
  (call-interactively 'bookmark-jump))

(defun my/splash-scratch ()
  "Go to scratch buffer from splash screen."
  (interactive)
  (my/splash-hide)
  (switch-to-buffer "*scratch*"))

(defun my/splash-quit ()
  "Quit splash screen."
  (interactive)
  (my/splash-hide))

;;; --- 7. AUTO-START CONFIGURATION ---

(defun my/splash-init ()
  "Initialize splash screen on startup."
  (when (and my/splash-enabled
             (not (daemonp))
             (= (length (frame-list)) 1)
             (null (cdr (buffer-list))))
    (my/splash-show)))

;; Add to after-init-hook
(add-hook 'after-init-hook 'my/splash-init)

;;; --- 8. SPLASH CUSTOMIZATION ---

(defun my/splash-customize ()
  "Customize splash screen settings."
  (interactive)
  (customize-group 'my-splash))

(defgroup my-splash nil
  "Splash screen customization."
  :group 'applications)

(defcustom my/splash-enabled t
  "Enable/disable splash screen."
  :type 'boolean
  :group 'my-splash)

(defcustom my/splash-timeout 10
  "Auto-hide splash screen after N seconds (0 = disabled)."
  :type 'integer
  :group 'my-splash)

(provide 'splash)
;;; splash.el ends here
