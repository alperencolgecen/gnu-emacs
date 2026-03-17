;;; theme.el --- Theme and Color Configuration

;; Load doom-vibrant theme
(load-theme 'doom-vibrant t)

;; Enable visual bell for doom themes
(doom-themes-visual-bell-config)

;; Custom neon faces
(custom-set-faces
 ;; Menu and tool bar neon styling
 '(menu ((t (:foreground "#00FFFF" :background "#1a1a2e" :box (:line-width 1 :color "#00FFFF")))))
 '(menu-item ((t (:foreground "#00FFFF" :background "#1a1a2e"))))
 '(tool-bar ((t (:foreground "#00FFFF" :background "#1a1a2e" :box (:line-width 1 :color "#00FFFF")))))
 
 ;; Header line neon styling
 '(header-line ((t (:foreground "#00FFFF" :background "#0d0d1a" :box (:line-width 1 :color "#00FFFF"))))))