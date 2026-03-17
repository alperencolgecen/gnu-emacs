;;; performance.el --- Performance Optimizations

;; Increase GC threshold during init for faster startup
(setq gc-cons-threshold (* 100 1024 1024))

;; Optimize process output handling
(setq read-process-output-max (* 1024 1024))

;; Silence native compilation warnings
(setq native-comp-async-report-warnings-errors nil)

;; Optimize file watching on case-insensitive filesystems
(setq file-notify-cases-insensitive-p t)

;; Prevent font cache compacting for better performance
(setq inhibit-compacting-font-caches t)

;; Restore normal GC threshold after startup
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 16 1024 1024))))