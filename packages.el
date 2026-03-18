;;; packages.el --- Package Management Setup

(require 'package)

;; Add package archives for comprehensive package access
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)

;; Define available packages for reference
(defvar my/packages '(doom-themes rainbow-delimiters vertico marginalia orderless 
                     magit company treemacs ace-window avy hydra which-key 
                     posframe cfrs pfuture dash s ht with-editor magit-section)
  "List of packages used in this configuration")

;; Initialize package system
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))