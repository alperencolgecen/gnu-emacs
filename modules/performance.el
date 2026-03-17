;;; init.el --- My Personal Emacs Configuration

;;; --- 1. OTOMATİK AYAR DOSYASI (En Üstte Olmalı) ---
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;; --- 2. PAKET YÖNETİMİ VE TEMALAR ---
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents (package-refresh-contents))
(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

(load-theme 'doom-vibrant t)
(doom-themes-visual-bell-config)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;;; --- 3. GÖRSEL VE DAVRANIŞSAL AYARLAR ---
(setq-default cursor-type 'bar)
(setq cursor-type 'bar)
(global-hl-line-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq shift-selection-mode t)
(cua-mode 1)

;; Akıllı Oto-Kayıt
(setq auto-save-visited-interval 1)
(auto-save-visited-mode 1)
(setq save-silently t)

;;; --- 4. FONKSİYONLAR ---
(defun my/toggle-ui-elements ()
  "Menü ve araç çubuklarını açar/kapatır."
  (interactive)
  (if menu-bar-mode
      (progn (menu-bar-mode -1) (tool-bar-mode -1) (message "Gizlendi"))
    (progn (menu-bar-mode 1) (tool-bar-mode 1) (message "Gösteriliyor"))))

;;; --- 5. KISAYOLLAR (Hatasız Bölüm) ---
(global-set-key (kbd "<f7>") 'my/toggle-ui-elements)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-S-s") 'write-file)

;; C-k üzerindeki tüm eski bağları zorla kopar
(define-key global-map (kbd "C-k") nil)

;; Şimdi C-k'yı bir başlangıç tuşu yap ve 'o' ile dosyayı aç
(global-set-key (kbd "C-k C-o") 'find-file)
;; --- GELİŞMİŞ TÜM SAYFADA ARAMA ---

;; 1. Arama sayfa sonuna gelince otomatik olarak başa döner (Tüm sayfayı tarar)
(setq isearch-wrap-pause 'no)

;; 2. Arama yaparken imleç kelimenin tam üzerine gitsin
(setq isearch-lazy-highlight t)

;; 3. Ctrl + F: Aşağı doğru arama
(global-set-key (kbd "C-f") 'isearch-forward)

;; 4. Ctrl + Shift + F: Yukarı doğru arama
(global-set-key (kbd "C-S-f") 'isearch-backward)

;; 5. Ctrl + H: Bul ve Değiştir (Replace)
;; Sayfanın neresinde olursan ol, tüm sayfada değişiklik yapmayı teklif eder.
(global-set-key (kbd "C-h") 'query-replace)
;; Ctrl + Mouse Tekerleği ile yazı boyutunu ayarla
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; --- MENÜ ÇUBUĞUNU TEK TUŞLA AÇ/KAPA ---

(defun benim/menu-cubugu-degistir ()
  "Menü çubuğunu açar veya kapatır."
  (interactive)
  (if (and (boundp 'menu-bar-mode) menu-bar-mode)
      (menu-bar-mode -1)
    (menu-bar-mode 1)))

;; F7 tuşuna bu fonksiyonu ata
(global-set-key (kbd "<f7>") 'benim/menu-cubugu-degistir)
;; --- TAM ODAKLANMA MODU (ZEN MODE) ---
;; Menü, Araç ve Kaydırma çubuklarını tek tuşla açar/kapatır.

(defun benim/arayuz-toggle ()
  "Arayüz elemanlarını (Menü, Tool ve Scroll bar) topluca açar veya kapatır."
  (interactive)
  ;; menu-bar-mode'un mevcut durumuna bakarak karar ver
  (if (and (boundp 'menu-bar-mode) menu-bar-mode)
      (progn
        (menu-bar-mode -1)
        (tool-bar-mode -1)
        (scroll-bar-mode -1)
        (message "Minimalist Görünüm: AKTİF"))
    (progn
      (menu-bar-mode 1)
      (tool-bar-mode 1)
      (scroll-bar-mode 1)
      (message "Standart Görünüm: AKTİF"))))

;; Emacs'ta genellikle boş olan F9 tuşuna ata
(global-set-key (kbd "<f9>") 'benim/arayuz-toggle)
;; --- 1. İMLEÇ AYARI (KESİN ÇÖZÜM) ---
(setq-default cursor-type 'bar)
(setq cursor-type 'bar)
(blink-cursor-mode 1)
;; --- ULTRA HAYALET VE TAM DONDURMA ---

(defvar benim/kilitli-mi nil)

(defun benim/ultra-hayalet-kilidi ()
  "Her şeyi gizler, minibuffer'ı görünmez yapar ve dondurur."
  (interactive)
  (setq benim/kilitli-mi t)
  
  ;; 1. Arayüzü Kapat
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  
  ;; 2. Minibuffer'ı Gizle (İllüzyon)
  (set-face-attribute 'mode-line nil :height 0.1) ;; Mode-line'ı küçült
  (set-window-text-height (minibuffer-window) 0) ;; Alt alanı sıfırla
  
  ;; 3. Ekranı Temizle ve İmleci Uçur
  (message nil)
  (setq-default cursor-type nil)
  (setq cursor-type nil)
  
;; 4. KİLİT DÖNGÜSÜ (F12 gelene kadar her şeyi yutar)
  (while benim/kilitli-mi
    (let ((event (read-event nil)))
      (when (eq event 'f12)
        (setq benim/kilitli-mi nil))))

  ;; 5. GERİ YÜKLEME (F12 basınca her şey canlanır)
  (setq-default cursor-type 'bar)
  (setq cursor-type 'bar)
  (set-face-attribute 'mode-line nil :height 100) ;; Yazı boyutuna göre ayarla
  (scroll-bar-mode 1)
  (message "Sistem geri yüklendi."))

(global-set-key (kbd "<f12>") 'benim/ultra-hayalet-kilidi)
(setq-default cursor-type 'bar)
(setq cursor-type 'bar)
;;; --- MENU BAR & TOOL BAR NEON GÖRÜNÜM ---
(custom-set-faces
 ;; Menu bar yazıları ve arkaplan
 '(menu ((t (:foreground "#00FFFF" :background "#1a1a2e" :box (:line-width 1 :color "#00FFFF")))))
 
 ;; Menu bar açılan menüler
 '(menu-item ((t (:foreground "#00FFFF" :background "#1a1a2e"))))
 
 ;; Tool bar
 '(tool-bar ((t (:foreground "#00FFFF" :background "#1a1a2e" :box (:line-width 1 :color "#00FFFF")))))
 
 ;; Mode line (alt çubuk da neon olsun)
 '(mode-line ((t (:foreground "#00FFFF" :background "#0d0d1a" :box (:line-width 1 :color "#00FFFF")))))
 '(mode-line-inactive ((t (:foreground "#005f5f" :background "#0d0d1a" :box (:line-width 1 :color "#003f3f")))))
 
 ;; Header line
 '(header-line ((t (:foreground "#00FFFF" :background "#0d0d1a" :box (:line-width 1 :color "#00FFFF"))))))
;; Güzel bir programlama fontu
(set-face-attribute 'default nil
  :font "JetBrains Mono"
  :weight 'regular)

;; Emoji desteği
(set-fontset-font t 'emoji "Noto Color Emoji" nil 'append)

;; Satır numaraları (programlama modunda)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(setq display-line-numbers-type 'relative) ; 'relative veya t

;; Pencere kenar boşluğu
(set-fringe-mode 10)
;; Garbage collection optimizasyonu
(setq gc-cons-threshold (* 100 1024 1024)) ; 100MB
(setq read-process-output-max (* 1024 1024)) ; 1MB

;; Başlangıçta native-comp uyarılarını sustur
(setq native-comp-async-report-warnings-errors nil)

;; Dosya izleme optimizasyonu
(setq file-notify-cases-insensitive-p t)
(setq my-packages '(doom-themes
                    rainbow-delimiters
                    vertico        ; dikey tamamlama menüsü
                    marginalia     ; açıklamalar
                    orderless      ; esnek arama
                    which-key      ; tuş ipuçları
                    magit          ; Git arayüzü
                    company        ; otomatik tamamlama
                    treemacs))     ; dosya ağacı

;; which-key (hangi kısayol ne yapar gösterir)
(which-key-mode 1)
(setq which-key-idle-delay 0.5)

;; Vertico (M-x ve find-file için modern menü)
(vertico-mode 1)

;; Marginalia (komutların yanında açıklama)
(marginalia-mode 1)

;; Company (kod tamamlama)
(global-company-mode 1)
(setq company-idle-delay 0.2)
;; Son açılan dosyaları hatırla
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key (kbd "C-r") 'recentf-open-files)

;; Açık dosyaları bir sonraki açılışta geri yükle
(desktop-save-mode 1)

;; Yedek dosyaları (~backup) tek yerde topla
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)

;; Kopyala-yapıştır geçmişi
(setq kill-ring-max 100)
;; Açılan parantezi otomatik kapat
(electric-pair-mode 1)
(setq electric-pair-inhibit-predicate 'ignore)
;; Eşleşen parantezi vurgula
(show-paren-mode 1)
(setq show-paren-style 'mixed)

;; Sözcük satır kaydırma (uzun satırları keser)
(global-visual-line-mode 1)

;; Seçili alanın üzerine yazınca seçimi sil
(delete-selection-mode 1)

;; Sekme = boşluk
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(prefer-coding-system 'utf-8)
;; Başlangıç ekranını kapat
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;; Pencere başlığı: hangi dosya açık
(setq frame-title-format '("%b — Emacs"))
;; Arama sırasında kaç eşleşme var göster
(setq isearch-lazy-count t)
(setq lazy-count-prefix-format "(%s/%s) ")

;; Büyük/küçük harf duyarsız arama
(setq-default case-fold-search t)

