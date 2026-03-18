;;; help.el --- Echo Area Help Messages and Tooltips

;;; --- 1. HELP CONFIGURATION ---

(defvar my/help-enabled t
  "Enable/disable help system.")

(defvar my/help-timeout 5
  "Auto-hide help messages after N seconds.")

(defvar my/help-history '()
  "History of help messages.")

;;; --- 2. CORE HELP FUNCTIONS ---

(defun my/help-show (message &optional timeout)
  "Show help message in echo area with optional timeout."
  (when my/help-enabled
    (let ((msg (propertize message 'face '(:foreground "#00FFFF"))))
      (message msg)
      (when timeout
        (run-with-timer timeout nil 
                       (lambda () (message ""))))
      (setq my/help-history (cons (cons (current-time) message) my/help-history))
      (when (> (length my/help-history) 50)
        (setq my/help-history (nthcdr 25 my/help-history))))))

(defun my/help-quick (message)
  "Show quick help message with default timeout."
  (my/help-show message my/help-timeout))

(defun my/help-persistent (message)
  "Show persistent help message (no timeout)."
  (my/help-show message nil))

;;; --- 3. CONTEXT-SENSITIVE HELP ---

(defun my/help-buffer-info ()
  "Show current buffer information."
  (interactive)
  (let* ((buffer (current-buffer))
         (file (buffer-file-name buffer))
         (mode major-mode)
         (size (when file (file-attribute-size (file-attributes file))))
         (lines (count-lines (point-min) (point-max))))
    (my/help-quick 
     (format "Buffer: %s | Mode: %s | Lines: %d%s%s"
             (buffer-name buffer)
             mode
             lines
             (if file (format " | Size: %s" (file-size-human-readable size)) "")
             (if file (format " | File: %s" (file-name-nondirectory file)) "")))))

(defun my/help-cursor-position ()
  "Show cursor position information."
  (interactive)
  (let* ((line (line-number-at-pos))
         (column (current-column))
         (total-lines (count-lines (point-min) (point-max)))
         (percent (if (> total-lines 0)
                     (/ (* line 100) total-lines)
                   0)))
    (my/help-quick 
     (format "Line: %d/%d (%d%%) | Column: %d" 
             line total-lines percent column))))

(defun my/help-git-branch ()
  "Show current git branch if in git repository."
  (interactive)
  (let ((default-directory (or (buffer-file-name) default-directory)))
    (when (and default-directory (file-exists-p (expand-file-name ".git" default-directory)))
      (let ((branch (my/help--get-git-branch)))
        (if branch
            (my/help-quick (format "Git: %s" branch))
          (my/help-quick "Git: Not on any branch"))))))

(defun my/help--get-git-branch ()
  "Get current git branch name."
  (let ((default-directory (or (buffer-file-name) default-directory)))
    (when (file-exists-p (expand-file-name ".git" default-directory))
      (let ((branch (with-temp-buffer
                      (call-process "git" nil t nil "branch" "--show-current")
                      (goto-char (point-min))
                      (buffer-substring-no-properties (point-min) (line-end-position)))))
        (unless (string-empty-p branch) branch)))))

;;; --- 4. COMMAND HELP ---

(defun my/help-recent-command ()
  "Show help for recently used command."
  (interactive)
  (let ((command (car command-history)))
    (when command
      (my/help-quick 
       (format "Recent: %s - %s" 
               (key-description (car command))
               (documentation (cadr command) t))))))

(defun my/help-keybinding (key)
  "Show what key is bound to."
  (interactive "kKey: ")
  (let ((binding (key-binding key)))
    (if binding
        (my/help-quick 
         (format "%s is bound to: %s" 
                 (key-description key)
                 binding))
      (my/help-quick (format "%s is unbound" (key-description key))))))

(defun my/help-describe-at-point ()
  "Show help for symbol at point."
  (interactive)
  (let ((symbol (symbol-at-point)))
    (if symbol
        (my/help-quick 
         (format "%s: %s" 
                 symbol
                 (or (documentation symbol) "No documentation")))
      (my/help-quick "No symbol at point"))))

;;; --- 5. PROJECT HELP ---

(defun my/help-project-info ()
  "Show project information."
  (interactive)
  (if (fboundp 'projectile-project-root)
      (let* ((root (projectile-project-root))
             (name (projectile-project-name))
             (files (when root (length (directory-files-recursively root "")))))
        (my/help-quick 
         (format "Project: %s | Root: %s | Files: %d"
                 name
                 (if root (file-name-nondirectory (directory-file-name root)) "None")
                 (or files 0))))
    (my/help-quick "Projectile not available")))

;;; --- 6. SYSTEM HELP ---

(defun my/help-system-info ()
  "Show system information."
  (interactive)
  (my/help-quick 
   (format "Emacs: %s | Memory: %s | GC: %d"
           emacs-version
           (my/help--memory-usage)
           gcs-done)))

(defun my/help--memory-usage ()
  "Get memory usage string."
  (let ((total (memory-info-total))
        (used (memory-info-used)))
    (if (and total used)
        (format "%s/%s" 
                (file-size-human-readable used)
                (file-size-human-readable total))
      "Unknown")))

;;; --- 7. HELP HISTORY ---

(defun my/help-history-show ()
  "Show help message history."
  (interactive)
  (let ((buffer (get-buffer-create "*Help History*")))
    (with-current-buffer buffer
      (erase-buffer)
      (insert "Help Message History\n\n")
      (dolist (entry (reverse my/help-history))
        (let ((time (car entry))
              (message (cdr entry)))
          (insert (format "[%s] %s\n"
                          (format-time-string "%H:%M:%S" time)
                          message))))
      (goto-char (point-min))
      (view-mode 1))
    (display-buffer buffer)))

(defun my/help-history-clear ()
  "Clear help message history."
  (interactive)
  (setq my/help-history '())
  (my/help-quick "Help history cleared"))

;;; --- 8. MODELINE HELP INTEGRATION ---

(defvar my/help-mode-line-indicator ""
  "Mode-line help indicator.")

(defun my/help-update-indicator ()
  "Update mode-line help indicator."
  (setq my/help-mode-line-indicator 
        (if my/help-enabled "H" "")))

;; Update indicator on help toggle
(add-hook 'after-init-hook 'my/help-update-indicator)

;;; --- 9. AUTO-HELP HOOKS ---

(defun my/help-auto-save-reminder ()
  "Show reminder to save if buffer modified."
  (when (and (buffer-modified-p)
             (buffer-file-name)
             (> (random 100) 95)) ; 5% chance
    (my/help-quick "Buffer modified - consider saving (C-x C-s)")))

(defun my/help-large-file-warning ()
  "Show warning for large files."
  (when (and (buffer-file-name)
             (> (buffer-size) (* 1024 1024))) ; > 1MB
    (my/help-quick "Large file detected - performance may be affected")))

;; Add hooks
(add-hook 'first-change-hook 'my/help-auto-save-reminder)
(add-hook 'find-file-hook 'my/help-large-file-warning)

;;; --- 10. HELP KEYBINDINGS ---

(defvar my/help-keymap (make-sparse-keymap)
  "Keymap for help commands.")

(define-key my/help-keymap (kbd "b") 'my/help-buffer-info)
(define-key my/help-keymap (kbd "c") 'my/help-cursor-position)
(define-key my/help-keymap (kbd "g") 'my/help-git-branch)
(define-key my/help-keymap (kbd "r") 'my/help-recent-command)
(define-key my/help-keymap (kbd "k") 'my/help-keybinding)
(define-key my/help-keymap (kbd "d") 'my/help-describe-at-point)
(define-key my/help-keymap (kbd "p") 'my/help-project-info)
(define-key my/help-keymap (kbd "s") 'my/help-system-info)
(define-key my/help-keymap (kbd "h") 'my/help-history-show)
(define-key my/help-keymap (kbd "C") 'my/help-history-clear)
(define-key my/help-keymap (kbd "t") 'my/help-toggle)

;; Bind help keymap globally
(global-set-key (kbd "C-c h") my/help-keymap)

;;; --- 11. HELP TOGGLE ---

(defun my/help-toggle ()
  "Toggle help system."
  (interactive)
  (setq my/help-enabled (not my/help-enabled))
  (my/help-update-indicator)
  (my/help-quick (format "Help system %s" 
                        (if my/help-enabled "enabled" "disabled"))))

;;; --- 12. UTILITY FUNCTIONS ---

(defun file-size-human-readable (size)
  "Convert file size to human readable format."
  (cond
   ((< size 1024) (format "%dB" size))
   ((< size (* 1024 1024)) (format "%.1fKB" (/ size 1024.0)))
   ((< size (* 1024 1024 1024)) (format "%.1fMB" (/ size (* 1024.0 1024))))
   (t (format "%.1fGB" (/ size (* 1024.0 1024 1024))))))

(provide 'help)
;;; help.el ends here
