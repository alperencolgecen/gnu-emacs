;;; backups.el --- Complete Intelligent Backup System Using Built-in Emacs Features

;;; --- 1. CORE BACKUP SETTINGS ---

;; Ensure backup directory exists
(let ((backup-dir (expand-file-name "~/.emacs.d/backups/")))
  (unless (file-exists-p backup-dir)
    (make-directory backup-dir t)))

;; Configure backup directory with project-based subdirectories if possible
(setq backup-directory-alist
      (if (fboundp 'projectile-project-root)
          ;; Use project-based subdirectories if projectile is available
          '((".*" . "~/.emacs.d/backups/"))
        ;; Otherwise use flat directory
        '(("." . "~/.emacs.d/backups/"))))

;; Core backup settings
(setq backup-by-copying t)          ; Never rename originals, always copy
(setq version-control t)             ; Numbered backups
setq kept-new-versions 10)          ; Keep last 10 versions
setq kept-old-versions 2)           ; Keep first 2 versions
setq delete-old-versions t)          ; Silently delete excess versions
setq vc-make-backup-files t)        ; Also backup version-controlled files

;; Disable lock files (they clutter directories on Windows)
(setq create-lockfiles nil)

;;; --- 2. AUTO-SAVE SETTINGS ---

;; Auto-save settings
(setq auto-save-default t)
(setq auto-save-interval 200)         ; Every 200 keystrokes
(setq auto-save-timeout 20)            ; After 20 seconds idle
(setq save-silently t)

;; Redirect auto-save files to dedicated directory
(let ((auto-save-dir (expand-file-name "~/.emacs.d/auto-save-list/")))
  (unless (file-exists-p auto-save-dir)
    (make-directory auto-save-dir t))
  (setq auto-save-file-name-transforms
        (lambda (filename)
          (expand-file-name (file-name-nondirectory filename) auto-save-dir))))

;; Auto-save visited files
(auto-save-visited-mode 1)
(setq auto-save-visited-interval 30)  ; Every 30 seconds

;;; --- 3. BACKUP MANAGEMENT FUNCTIONS ---

(defun my/backup-open-latest ()
  "Find and open most recent backup of current file side-by-side with original."
  (interactive)
  (let* ((current-file (buffer-file-name))
         (backup-dir (file-name-directory (car (cdr (assoc "." backup-directory-alist))))
         (backups (when (and current-file backup-dir)
                    (directory-files backup-dir nil nil
                                      (lambda (a b)
                                        (let ((time-a (file-attribute-modification-time a))
                                              (time-b (file-attribute-modification-time b)))
                                          (time-less-p time-b time-a))))))
         (latest-backup (car backups)))
    (if latest-backup
        (progn
          (split-window-right)
          (other-window 1)
          (find-file latest-backup)
          (other-window 1))
      (message "No backup found for %s" (or current-file "current buffer")))))

(defun my/backup-list-all ()
  "Show all backups of current file in dedicated buffer with interactive actions."
  (interactive)
  (let* ((current-file (buffer-file-name))
         (backup-dir (file-name-directory (car (cdr (assoc "." backup-directory-alist))))
         (backups (when (and current-file backup-dir)
                    (directory-files backup-dir nil nil
                                      (lambda (a b)
                                        (time-less-p (file-attribute-modification-time b)
                                                    (file-attribute-modification-time a))))))
         (total-size 0)
    (if backups
        (let ((backup-buffer (get-buffer-create "*Backups*")))
          (with-current-buffer backup-buffer
            (erase-buffer)
            (insert (format "Backups for: %s\n\n" (file-name-nondirectory current-file)))
            (insert "VERSION | SIZE    | MODIFIED           | PATH\n")
            (insert "--------|---------|--------------------|--------------------------------\n")
            (dolist (backup backups)
              (let* ((size (file-attribute-size backup))
                     (mod-time (format-time-string "%Y-%m-%d %H:%M:%S" 
                                                  (file-attribute-modification-time backup))))
                (setq total-size (+ total-size size))
                (insert (format "%-7d | %-7s | %s | %s\n"
                            (backup-extract-version backup current-file)
                            (file-size-human-readable size)
                            mod-time
                            backup))))
            (insert (format "\nTotal: %d files, %s\n\n" 
                        (length backups) (file-size-human-readable total-size)))
            (insert "Commands: RET=open, d=delete, q=quit\n")
            (local-set-key (kbd "RET") 
                           (lambda () (interactive) 
                             (let ((backup (get-text-property (line-beginning-position) 'backup-file)))
                               (when backup (find-file backup)))))
            (local-set-key (kbd "d")
                           (lambda () (interactive)
                             (let ((backup (get-text-property (line-beginning-position) 'backup-file)))
                               (when backup
                                 (if (y-or-n-p (format "Delete backup %s? " backup))
                                     (progn
                                       (delete-file backup)
                                       (revert-buffer t)
                                       (message "Deleted backup: %s" backup)))))))
            (local-set-key (kbd "q") (lambda () (interactive) (kill-buffer)))
          (display-buffer backup-buffer))
      (message "No backups found for %s" (or current-file "current buffer")))))

(defun my/backup-diff ()
  "Run ediff between current buffer and its most recent backup."
  (interactive)
  (let* ((current-file (buffer-file-name))
         (backup-dir (file-name-directory (car (cdr (assoc "." backup-directory-alist))))
         (backups (when (and current-file backup-dir)
                    (directory-files backup-dir nil nil
                                      (lambda (a b)
                                        (time-less-p (file-attribute-modification-time b)
                                                    (file-attribute-modification-time a))))))
         (latest-backup (car backups)))
    (if latest-backup
        (ediff-files current-file latest-backup)
      (message "No backup found for %s" (or current-file "current buffer")))))

(defun my/backup-restore ()
  "Copy most recent backup over current file with confirmation."
  (interactive)
  (let* ((current-file (buffer-file-name))
         (backup-dir (file-name-directory (car (cdr (assoc "." backup-directory-alist))))
         (backups (when (and current-file backup-dir)
                    (directory-files backup-dir nil nil
                                      (lambda (a b)
                                        (time-less-p (file-attribute-modification-time b)
                                                    (file-attribute-modification-time a))))))
         (latest-backup (car backups)))
    (if (and latest-backup (y-or-n-p (format "Restore from backup %s? " latest-backup)))
        (progn
          (copy-file latest-backup current-file t)
          (revert-buffer nil t)
          (message "Restored from backup: %s" latest-backup))
      (message "No backup found for %s" (or current-file "current buffer")))))

(defun my/backup-cleanup-old ()
  "Interactively clean up backups older than N days."
  (interactive)
  (let* ((days (read-number "Delete backups older than (days): "))
         (current-file (buffer-file-name))
         (backup-dir (file-name-directory (car (cdr (assoc "." backup-directory-alist))))
         (backups (when backup-dir
                    (directory-files backup-dir)))
         (cutoff-time (time-subtract (current-time) 
                                  (days-to-time days)))
         (to-delete '())
         (total-size 0))
    (dolist (backup backups)
      (let ((mod-time (file-attribute-modification-time backup)))
        (when (time-less-p mod-time cutoff-time)
          (setq to-delete (cons backup to-delete))
          (setq total-size (+ total-size (file-attribute-size backup))))))
    (when (and to-delete 
               (y-or-n-p (format "Delete %d backup files (%s) older than %d days? " 
                                 (length to-delete) 
                                 (file-size-human-readable total-size)
                                 days)))
      (dolist (backup to-delete)
        (delete-file backup))
      (message "Deleted %d backup files older than %d days" 
               (length to-delete) days))))

(defun my/backup-stats ()
  "Show backup summary in minibuffer."
  (interactive)
  (let* ((backup-dir (file-name-directory (car (cdr (assoc "." backup-directory-alist))))
         (backups (when backup-dir (directory-files backup-dir)))
         (total-size 0)
         (oldest-time nil)
         (newest-time nil))
    (dolist (backup backups)
      (let ((size (file-attribute-size backup))
             (mod-time (file-attribute-modification-time backup)))
        (setq total-size (+ total-size size))
        (when (or (null oldest-time) (time-less-p mod-time oldest-time))
          (setq oldest-time mod-time))
        (when (or (null newest-time) (time-less-p newest-time mod-time))
          (setq newest-time mod-time))))
    (if backups
        (message "Backups: %d files, %s total, oldest: %s, newest: %s"
                 (length backups)
                 (file-size-human-readable total-size)
                 (if oldest-time (format-time-string "%Y-%m-%d" oldest-time) "N/A")
                 (if newest-time (format-time-string "%Y-%m-%d" newest-time) "N/A"))
      (message "No backups found"))))

;;; --- 4. BACKUP INDICATOR IN MODE-LINE ---

(defvar my/backup-indicator nil
  "Mode-line indicator for backup status.")

(defun my/update-backup-indicator ()
  "Update backup status indicator in mode-line."
  (let* ((current-file (buffer-file-name))
         (backup-dir (file-name-directory (car (cdr (assoc "." backup-directory-alist))))
         (backups (when (and current-file backup-dir)
                    (directory-files backup-dir)))
         (latest-backup (car backups))
         (backup-age (when latest-backup
                       (time-subtract (current-time) 
                                      (file-attribute-modification-time latest-backup))))
         (hours-old (when backup-age (/ (float-time backup-age) 3600))))
    (setq my/backup-indicator
          (cond
           ((null current-file) "B:∅")
           ((null backups) "B:✗")
           ((null latest-backup) "B:✗")
           ((and hours-old (> hours-old 24)) "B:!")
           (t "B:✓")))))

;; Update indicator on every save
(add-hook 'after-save-hook 'my/update-backup-indicator)

;; Add to mode-line (simple approach)
(setq-default mode-line-format
      (cons my/backup-indicator (default-value 'mode-line-format)))

;;; --- 5. EMERGENCY BACKUP ---

(defun my/emergency-backup ()
  "Immediately save timestamped backup of ALL modified buffers."
  (interactive)
  (let* ((emergency-dir (expand-file-name "~/.emacs.d/backups/emergency/"))
         (timestamp (format-time-string "%Y-%m-%d_%H-%M-%S" (current-time)))
         (saved-count 0)
         (total-size 0))
    (unless (file-exists-p emergency-dir)
      (make-directory emergency-dir t))
    (dolist (buffer (buffer-list))
      (when (and (buffer-file-name buffer) 
                 (buffer-modified-p buffer))
        (let* ((filename (buffer-file-name buffer))
               (backup-name (concat emergency-dir "/"
                                      (file-name-nondirectory filename)
                                      "_EMERGENCY_" timestamp)))
          (copy-file filename backup-name)
          (setq saved-count (1+ saved-count))
          (setq total-size (+ total-size (file-attribute-size (buffer-file-name buffer))))))
    (message "Emergency backup: saved %d files (%s) to %s"
             saved-count (file-size-human-readable total-size) emergency-dir)))

;; Hook emergency backup to Emacs shutdown
(add-hook 'kill-emacs-hook 'my/emergency-backup)

;;; --- 6. BACKUP KEYBINDING MAP ---

(defvar my/backup-keymap (make-sparse-keymap)
  "Keymap for backup commands.")

(define-key my/backup-keymap (kbd "l") 'my/backup-list-all)
(define-key my/backup-keymap (kbd "d") 'my/backup-diff)
(define-key my/backup-keymap (kbd "r") 'my/backup-restore)
(define-key my/backup-keymap (kbd "c") 'my/backup-cleanup-old)
(define-key my/backup-keymap (kbd "s") 'my/backup-stats)
(define-key my/backup-keymap (kbd "e") 'my/emergency-backup)
(define-key my/backup-keymap (kbd "o") 'my/backup-open-latest)

;; Bind backup keymap globally
(global-set-key (kbd "C-c b") my/backup-keymap)

;;; --- 7. HELPER FUNCTIONS ---

(defun backup-extract-version (backup-file original-file)
  "Extract version number from backup filename."
  (let ((backup-base (file-name-base backup-file))
         (orig-base (file-name-base original-file)))
    (when (string-prefix-p orig-base backup-base)
      (let ((version-string (substring backup-base (length orig-base)))
        (if (string-match "~\\([0-9]+\\)~?$" version-string)
            (string-to-number (match-string 1 version-string))
          0)))))

(defun file-size-human-readable (size)
  "Convert file size to human readable format."
  (cond
   ((< size 1024) (format "%dB" size))
   ((< size (* 1024 1024)) (format "%.1fKB" (/ size 1024.0)))
   ((< size (* 1024 1024 1024)) (format "%.1fMB" (/ size (* 1024.0 1024))))
   (t (format "%.1fGB" (/ size (* 1024.0 1024 1024))))))

;;; backups.el ends here
