;;; colors.el --- Color Palettes and Utilities

;;; --- 1. MATERIAL DESIGN COLORS ---

(defvar my/material-colors
  '((red . ((50 . "#FFEBEE") (100 . "#FFCDD2") (200 . "#EF9A9A") (300 . "#E57373") 
            (400 . "#EF5350") (500 . "#F44336") (600 . "#E53935") (700 . "#D32F2F") 
            (800 . "#C62828") (900 . "#B71C1C")))
    (pink . ((50 . "#FCE4EC") (100 . "#F8BBD0") (200 . "#F48FB1") (300 . "#F06292") 
             (400 . "#EC407A") (500 . "#E91E63") (600 . "#D81B60") (700 . "#C2185B") 
             (800 . "#AD1457") (900 . "#880E4F")))
    (purple . ((50 . "#F3E5F5") (100 . "#E1BEE7") (200 . "#CE93D8") (300 . "#BA68C8") 
               (400 . "#AB47BC") (500 . "#9C27B0") (600 . "#8E24AA") (700 . "#7B1FA2") 
               (800 . "#6A1B9A") (900 . "#4A148C")))
    (deep-purple . ((50 . "#EDE7F6") (100 . "#D1C4E9") (200 . "#B39DDB") (300 . "#9575CD") 
                    (400 . "#7E57C2") (500 . "#673AB7") (600 . "#5E35B1") (700 . "#512DA8") 
                    (800 . "#4527A0") (900 . "#311B92")))
    (indigo . ((50 . "#E8EAF6") (100 . "#C5CAE9") (200 . "#9FA8DA") (300 . "#7986CB") 
               (400 . "#5C6BC0") (500 . "#3F51B5") (600 . "#3949AB") (700 . "#303F9F") 
               (800 . "#283593") (900 . "#1A237E")))
    (blue . ((50 . "#E3F2FD") (100 . "#BBDEFB") (200 . "#90CAF9") (300 . "#64B5F6") 
             (400 . "#42A5F5") (500 . "#2196F3") (600 . "#1E88E5") (700 . "#1976D2") 
             (800 . "#1565C0") (900 . "#0D47A1")))
    (light-blue . ((50 . "#E1F5FE") (100 . "#B3E5FC") (200 . "#81D4FA") (300 . "#4FC3F7") 
                  (400 . "#29B6F6") (500 . "#03A9F4") (600 . "#039BE5") (700 . "#0288D1") 
                  (800 . "#0277BD") (900 . "#01579B")))
    (cyan . ((50 . "#E0F7FA") (100 . "#B2EBF2") (200 . "#80DEEA") (300 . "#4DD0E1") 
             (400 . "#26C6DA") (500 . "#00BCD4") (600 . "#00ACC1") (700 . "#0097A7") 
             (800 . "#00838F") (900 . "#006064")))
    (teal . ((50 . "#E0F2F1") (100 . "#B2DFDB") (200 . "#80CBC4") (300 . "#4DB6AC") 
             (400 . "#26A69A") (500 . "#009688") (600 . "#00897B") (700 . "#00796B") 
             (800 . "#00695C") (900 . "#004D40")))
    (green . ((50 . "#E8F5E9") (100 . "#C8E6C9") (200 . "#A5D6A7") (300 . "#81C784") 
              (400 . "#66BB6A") (500 . "#4CAF50") (600 . "#43A047") (700 . "#388E3C") 
              (800 . "#2E7D32") (900 . "#1B5E20")))
    (light-green . ((50 . "#F1F8E9") (100 . "#DCEDC8") (200 . "#C5E1A5") (300 . "#AED581") 
                    (400 . "#9CCC65") (500 . "#8BC34A") (600 . "#7CB342") (700 . "#689F38") 
                    (800 . "#558B2F") (900 . "#33691E")))
    (lime . ((50 . "#F9FBE7") (100 . "#F0F4C3") (200 . "#E6EE9C") (300 . "#DCE775") 
             (400 . "#D4E157") (500 . "#CDDC39") (600 . "#C0CA33") (700 . "#AFB42B") 
             (800 . "#9E9D24") (900 . "#827717")))
    (yellow . ((50 . "#FFFDE7") (100 . "#FFF9C4") (200 . "#FFF59D") (300 . "#FFF176") 
               (400 . "#FFEE58") (500 . "#FFEB3B") (600 . "#FDD835") (700 . "#FBC02D") 
               (800 . "#F9A825") (900 . "#F57F17")))
    (amber . ((50 . "#FFF8E1") (100 . "#FFECB3") (200 . "#FFE082") (300 . "#FFD54F") 
              (400 . "#FFCA28") (500 . "#FFC107") (600 . "#FFB300") (700 . "#FFA000") 
              (800 . "#FF8F00") (900 . "#FF6F00")))
    (orange . ((50 . "#FFF3E0") (100 . "#FFE0B2") (200 . "#FFCC80") (300 . "#FFB74D") 
               (400 . "#FFA726") (500 . "#FF9800") (600 . "#FB8C00") (700 . "#F57C00") 
               (800 . "#EF6C00") (900 . "#E65100")))
    (deep-orange . ((50 . "#FBE9E7") (100 . "#FFCCBC") (200 . "#FFAB91") (300 . "#FF8A65") 
                    (400 . "#FF7043") (500 . "#FF5722") (600 . "#F4511E") (700 . "#E64A19") 
                    (800 . "#D84315") (900 . "#BF360C")))
    (brown . ((50 . "#EFEBE9") (100 . "#D7CCC8") (200 . "#BCAAA4") (300 . "#A1887F") 
              (400 . "#8D6E63") (500 . "#795548") (600 . "#6D4C41") (700 . "#5D4037") 
              (800 . "#4E342E") (900 . "#3E2723")))
    (grey . ((50 . "#FAFAFA") (100 . "#F5F5F5") (200 . "#EEEEEE") (300 . "#E0E0E0") 
             (400 . "#BDBDBD") (500 . "#9E9E9E") (600 . "#757575") (700 . "#616161") 
             (800 . "#424242") (900 . "#212121")))
    (blue-grey . ((50 . "#ECEFF1") (100 . "#CFD8DC") (200 . "#B0BEC5") (300 . "#90A4AE") 
                  (400 . "#78909C") (500 . "#607D8B") (600 . "#546E7A") (700 . "#455A64") 
                  (800 . "#37474F") (900 . "#263238"))))
  "Material Design color palette.")

;;; --- 2. NORD COLORS ---

(defvar my/nord-colors
  '((nord0 . "#2E3440")    ; Polar Night
    (nord1 . "#3B4252")
    (nord2 . "#434C5E")
    (nord3 . "#4C566A")
    (nord4 . "#D8DEE9")    ; Snow Storm
    (nord5 . "#E5E9F0")
    (nord6 . "#ECEFF4")
    (nord7 . "#8FBCBB")    ; Frost
    (nord8 . "#88C0D0")
    (nord9 . "#81A1C1")
    (nord10 . "#5E81AC")   ; Aurora
    (nord11 . "#BF616A")
    (nord12 . "#D08770")
    (nord13 . "#EBCB8B")
    (nord14 . "#A3BE8C")
    (nord15 . "#B48EAD"))
  "Nord color palette.")

;;; --- 3. CUSTOM NEON COLORS ---

(defvar my/neon-colors
  '((cyan . "#00FFFF")
    (magenta . "#FF00FF")
    (yellow . "#FFFF00")
    (lime . "#00FF00")
    (orange . "#FF8800")
    (pink . "#FF69B4")
    (purple . "#9370DB")
    (red . "#FF0000")
    (blue . "#0080FF")
    (green . "#00FF00"))
  "Neon color palette for cyberpunk themes.")

;;; --- 4. COLOR UTILITY FUNCTIONS ---

(defun my/get-material-color (color shade)
  "Get Material Design color by name and shade.
Example: (my/get-material-color 'blue 500) => \"#2196F3\""
  (let* ((color-data (assoc color my/material-colors))
         (shade-data (and color-data (assoc shade (cdr color-data)))))
    (when shade-data (cdr shade-data))))

(defun my/get-nord-color (color)
  "Get Nord color by name.
Example: (my/get-nord-color 'nord8) => \"#88C0D0\""
  (let ((color-data (assoc color my/nord-colors)))
    (when color-data (cdr color-data))))

(defun my/get-neon-color (color)
  "Get neon color by name.
Example: (my/get-neon-color 'cyan) => \"#00FFFF\""
  (let ((color-data (assoc color my/neon-colors)))
    (when color-data (cdr color-data))))

(defun my/list-material-shades (color)
  "List all available shades for a Material Design color."
  (let ((color-data (assoc color my/material-colors)))
    (when color-data
      (mapcar 'car (cdr color-data)))))

(defun my/list-nord-colors ()
  "List all available Nord colors."
  (mapcar 'car my/nord-colors))

(defun my/list-neon-colors ()
  "List all available neon colors."
  (mapcar 'car my/neon-colors))

;;; --- 5. COLOR PREVIEW FUNCTIONS ---

(defun my/preview-material-colors ()
  "Preview all Material Design colors in a buffer."
  (interactive)
  (let ((buffer (get-buffer-create "*Material Colors*")))
    (with-current-buffer buffer
      (erase-buffer)
      (insert "Material Design Color Palette\n\n")
      (dolist (color my/material-colors)
        (insert (format "%s:\n" (car color)))
        (dolist (shade (cdr color))
          (insert (format "  %3d: " (car shade)))
          (insert (propertize "████████" 'face `(:background ,(cdr shade) :foreground ,(cdr shade))))
          (insert (format " %s\n" (cdr shade))))
        (insert "\n"))
      (goto-char (point-min))
      (view-mode 1))
    (display-buffer buffer)))

(defun my/preview-nord-colors ()
  "Preview all Nord colors in a buffer."
  (interactive)
  (let ((buffer (get-buffer-create "*Nord Colors*")))
    (with-current-buffer buffer
      (erase-buffer)
      (insert "Nord Color Palette\n\n")
      (dolist (color my/nord-colors)
        (insert (format "%-8s: " (car color)))
        (insert (propertize "████████" 'face `(:background ,(cdr color) :foreground ,(cdr color))))
        (insert (format " %s\n" (cdr color))))
      (goto-char (point-min))
      (view-mode 1))
    (display-buffer buffer)))

(defun my/preview-neon-colors ()
  "Preview all neon colors in a buffer."
  (interactive)
  (let ((buffer (get-buffer-create "*Neon Colors*")))
    (with-current-buffer buffer
      (erase-buffer)
      (insert "Neon Color Palette\n\n")
      (dolist (color my/neon-colors)
        (insert (format "%-8s: " (car color)))
        (insert (propertize "████████" 'face `(:background ,(cdr color) :foreground ,(cdr color))))
        (insert (format " %s\n" (cdr color))))
      (goto-char (point-min))
      (view-mode 1))
    (display-buffer buffer)))

;;; --- 6. COLOR THEMES ---

(defun my/apply-material-theme (primary-color primary-shade &optional background)
  "Apply a Material Design color theme.
Example: (my/apply-material-theme 'blue 500 'nord0)"
  (let ((primary (my/get-material-color primary-color primary-shade))
        (bg (or background (my/get-nord-color 'nord0))))
    (when primary
      (custom-set-faces
       `(default ((t (:background ,bg :foreground ,(my/get-nord-color 'nord4)))))
       `(mode-line ((t (:background ,primary :foreground ,bg))))
       `(mode-line-inactive ((t (:background ,(my/get-nord-color 'nord3) :foreground ,(my/get-nord-color 'nord4)))))
       `(font-lock-keyword-face ((t (:foreground ,(my/get-material-color 'purple 400)))))
       `(font-lock-string-face ((t (:foreground ,(my/get-material-color 'green 600)))))
       `(font-lock-comment-face ((t (:foreground ,(my/get-nord-color 'nord3) :italic t))))
       `(font-lock-function-name-face ((t (:foreground ,(my/get-material-color 'blue 400)))))
       `(font-lock-variable-name-face ((t (:foreground ,(my/get-material-color 'orange 600)))))
       `(region ((t (:background ,(my/get-material-color 'blue 100)))))
       `(header-line ((t (:background ,(my/get-nord-color 'nord2) :foreground ,(my/get-nord-color 'nord4)))))))))

(defun my/apply-nord-theme ()
  "Apply Nord color theme."
  (interactive)
  (custom-set-faces
   `(default ((t (:background ,(my/get-nord-color 'nord0) :foreground ,(my/get-nord-color 'nord4)))))
   `(mode-line ((t (:background ,(my/get-nord-color 'nord3) :foreground ,(my/get-nord-color 'nord6)))))
   `(mode-line-inactive ((t (:background ,(my/get-nord-color 'nord2) :foreground ,(my/get-nord-color 'nord4)))))
   `(font-lock-keyword-face ((t (:foreground ,(my/get-nord-color 'nord9)))))
   `(font-lock-string-face ((t (:foreground ,(my/get-nord-color 'nord14)))))
   `(font-lock-comment-face ((t (:foreground ,(my/get-nord-color 'nord3) :italic t))))
   `(font-lock-function-name-face ((t (:foreground ,(my/get-nord-color 'nord8)))))
   `(font-lock-variable-name-face ((t (:foreground ,(my/get-nord-color 'nord12)))))
   `(region ((t (:background ,(my/get-nord-color 'nord2)))))
   `(header-line ((t (:background ,(my/get-nord-color 'nord1) :foreground ,(my/get-nord-color 'nord4)))))))

;;; --- 7. COLOR KEYBINDINGS ---

(defvar my/colors-keymap (make-sparse-keymap)
  "Keymap for color commands.")

(define-key my/colors-keymap (kbd "m") 'my/preview-material-colors)
(define-key my/colors-keymap (kbd "n") 'my/preview-nord-colors)
(define-key my/colors-keymap (kbd "e") 'my/preview-neon-colors)
(define-key my/colors-keymap (kbd "t") 'my/apply-nord-theme)

;; Bind colors keymap globally
(global-set-key (kbd "C-c c") my/colors-keymap)

(provide 'colors)
;;; colors.el ends here
