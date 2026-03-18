;;; snippets.el --- Complete Snippet System Using Built-in Emacs Features

(require 'skeleton)
(require 'tempo)
(require 'abbrev)

;;; --- 1. ABBREV TABLE (abbrev.el) ---

;; Enable abbrev mode globally
(abbrev-mode 1)

;; Define common abbreviations for typos and shorthands
(define-abbrev-table 'global-abbrev-table
  "imt" "import")
(define-abbrev-table 'global-abbrev-table
  "ret" "return")
(define-abbrev-table 'global-abbrev-table
  "deff" "def")
(define-abbrev-table 'global-abbrev-table
  "cls" "class")
(define-abbrev-table 'global-abbrev-table
  "teh" "the")
(define-abbrev-table 'global-abbrev-table
  "adn" "and")

;;; --- 2. SKELETON SNIPPETS (skeleton.el) ---

;; Python skeletons
(define-skeleton python-if-skeleton
  "Insert Python if block"
  "if " str ":\n" _ "\n")

(define-skeleton python-def-skeleton
  "Insert Python function definition"
  "def " (skeleton-read "Function name: ") "(self):\n"
  "    \"\"\"" (skeleton-read "Docstring: ") "\"\"\"\n"
  "    " _ "\n")

(define-skeleton python-class-skeleton
  "Insert Python class definition"
  "class " (skeleton-read "Class name: ") ":\n"
  "    def __init__(self):\n"
  "        \"\"\"" (skeleton-read "Init docstring: ") "\"\"\"\n"
  "        " _ "\n")

(define-skeleton python-for-skeleton
  "Insert Python for loop"
  "for " (skeleton-read "Variable: ") " in " (skeleton-read "Iterable: ") ":\n"
  "    " _ "\n")

(define-skeleton python-try-skeleton
  "Insert Python try/except block"
  "try:\n"
  "    " _ "\n"
  "except Exception as e:\n"
  "    print(f\"Error: {e}\")\n")

;; C skeletons
(define-skeleton c-function-skeleton
  "Insert C function definition"
  (skeleton-read "Return type: ") " " (skeleton-read "Function name: ") "(" (skeleton-read "Arguments: ") ") {\n"
  > _ "\n}\n")

(define-skeleton c-if-skeleton
  "Insert C if block"
  "if (" (skeleton-read "Condition: ") ") {\n"
  > _ "\n}\n")

(define-skeleton c-while-skeleton
  "Insert C while loop"
  "while (" (skeleton-read "Condition: ") ") {\n"
  > _ "\n}\n")

(define-skeleton c-struct-skeleton
  "Insert C struct definition"
  "typedef struct {\n"
  > "    " _ ";\n"
  > "} " (skeleton-read "Struct name: ") ";\n")

(define-skeleton c-main-skeleton
  "Insert C main function template"
  "int main(int argc, char *argv[]) {\n"
  > "    " _ "\n"
  > "    return 0;\n"
  "}\n")

;; Emacs Lisp skeletons
(define-skeleton elisp-defun-skeleton
  "Insert Emacs Lisp defun with docstring"
  "(defun " (skeleton-read "Function name: ") (" (skeleton-read "Arguments: ") ")\n"
  "  \"" (skeleton-read "Docstring: ") "\"\n"
  > _ "\n)\n")

(define-skeleton elisp-let-skeleton
  "Insert Emacs Lisp let block"
  "(let (" (skeleton-read "Variables: ") ")\n"
  > _ "\n)\n")

(define-skeleton elisp-condition-case-skeleton
  "Insert Emacs Lisp condition-case block"
  "(condition-case err\n"
  > "  (" (skeleton-read "Error condition: ") ")\n"
  > "    " _ "\n"
  > "  (error\n"
  > "    (message \"Error: %s\" err)))\n")

(define-skeleton elisp-add-hook-skeleton
  "Insert Emacs Lisp add-hook template"
  "(add-hook '" (skeleton-read "Hook name: ") "\n"
  > "  (lambda ()\n"
  > "    " _ "\n))\n")

;; Global skeletons
(define-skeleton insert-date-skeleton
  "Insert current date in YYYY-MM-DD format"
  (format-time-string "%Y-%m-%d") "\n")

(define-skeleton insert-uuid-skeleton
  "Insert UUID v4"
  (if (executable-find "uuidgen")
      (shell-command-to-string "uuidgen")
    (format "%04x%04x-%04x-%04x-%04x%04x%04x"
            (random 65535) (random 65535) (random 65535)
            (random 65535) (random 65535) (random 65535) (random 65535)))
  "\n")

;;; --- 3. KEY BINDINGS FOR SKELETONS ---

;; Python mode skeletons
(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c s f") 'python-if-skeleton)
            (local-set-key (kbd "C-c s d") 'python-def-skeleton)
            (local-set-key (kbd "C-c s c") 'python-class-skeleton)
            (local-set-key (kbd "C-c s l") 'python-for-skeleton)
            (local-set-key (kbd "C-c s t") 'python-try-skeleton)))

;; C mode skeletons
(add-hook 'c-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c s f") 'c-function-skeleton)
            (local-set-key (kbd "C-c s i") 'c-if-skeleton)
            (local-set-key (kbd "C-c s w") 'c-while-skeleton)
            (local-set-key (kbd "C-c s s") 'c-struct-skeleton)
            (local-set-key (kbd "C-c s m") 'c-main-skeleton)))

;; Emacs Lisp mode skeletons
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c s f") 'elisp-defun-skeleton)
            (local-set-key (kbd "C-c s l") 'elisp-let-skeleton)
            (local-set-key (kbd "C-c s c") 'elisp-condition-case-skeleton)
            (local-set-key (kbd "C-c s h") 'elisp-add-hook-skeleton)))

;; Global skeletons
(global-set-key (kbd "C-c s i") 'insert-date-skeleton)
(global-set-key (kbd "C-c s u") 'insert-uuid-skeleton)

;;; --- 4. TEMPO TEMPLATES (tempo.el) ---

;; HTML tempo templates
(tempo-define-template "html5-boilerplate"
  "Full HTML5 boilerplate"
  '("<!DOCTYPE html>\n"
    "<html lang=\"en\">\n"
    "<head>\n"
    "    <meta charset=\"UTF-8\">\n"
    "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
    "    <title>" (p "Title: ") "</title>\n"
    "</head>\n"
    "<body>\n"
    > p "\n"
    "</body>\n"
    "</html>"))

(tempo-define-template "html-div"
  "HTML div with class"
  '("<div class=\"" (p "Class: ") "\">\n"
    > p "\n"
    "</div>\n"))

(tempo-define-template "html-list"
  "HTML ul/li list structure"
  '("<ul>\n"
    > (repeat-string (string-to-number (p "Number of items: "))
                   '("<li>" p "</li>\n" >)
    "</ul>\n"))

;; Bind HTML templates
(add-hook 'mhtml-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c s h") (tempo-insert-template "html5-boilerplate"))
            (local-set-key (kbd "C-c s d") (tempo-insert-template "html-div"))
            (local-set-key (kbd "C-c s l") (tempo-insert-template "html-list"))))

;;; --- 5. HIPPIE EXPAND CONFIGURATION ---

;; Replace dabbrev-expand with hippie-expand
(global-set-key (kbd "M-/") 'hippie-expand)

;; Configure hippie-expand try functions order
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-line
        try-complete-file-name-partially
        try-complete-lisp-symbol-partially))

;;; --- 6. FILE HEADER TEMPLATES ---

(defun my/insert-file-header ()
  "Insert language-appropriate header comment for new file."
  (interactive)
  (when (= (buffer-size) 0)  ; Only for brand new files
    (let ((filename (file-name-nondirectory (buffer-file-name)))
      (extension (file-name-extension (buffer-file-name)))
      (save-excursion
        (goto-char (point-min))
        (cond
         ;; Python files
         ((string= extension "py")
          (insert "# -*- coding: utf-8 -*-\n")
          (insert "#!/usr/bin/env python3\n")
          (insert (format "'''\nAuthor: %s\nDate: %s\nDescription: %s\n'''\n"
                      (user-full-name) (format-time-string "%Y-%m-%d") 
                      (read-string "Description: "))))
         
         ;; C/C++ files
         ((member extension '("c" "h" "cpp" "hpp"))
          (insert (format "/*\n * File: %s\n * Author: %s\n * Date: %s\n * Description: %s\n */\n"
                      filename (user-full-name) (format-time-string "%Y-%m-%d")
                      (read-string "Description: "))))
         
         ;; Emacs Lisp files
         ((string= extension "el")
          (insert (format ";;; %s --- %s\n\n"
                      filename (read-string "Description: "))))
         
         ;; Go files
         ((string= extension "go")
          (insert (format "// Package %s\n// Author: %s\n// Date: %s\n// Description: %s\n\n"
                      (file-name-base filename) (user-full-name) 
                      (format-time-string "%Y-%m-%d") (read-string "Description: "))))
         
         ;; Generic header for other files
         (t
          (insert (format "# Author: %s\n# Date: %s\n# Description: %s\n\n"
                      (user-full-name) (format-time-string "%Y-%m-%d")
                      (read-string "Description: "))))))))

;; Auto-insert header on find-file for new files
(add-hook 'find-file-hook 'my/insert-file-header)

;;; --- 7. SNIPPET MENU ---

(defun my/snippet-menu ()
  "Show and insert available snippets for current major mode."
  (interactive)
  (let* ((mode-name (symbol-name major-mode))
         (snippets
          (cond
           ;; Python snippets
           ((string= mode-name "python-mode")
            '(("if block" . python-if-skeleton)
              ("function" . python-def-skeleton)
              ("class" . python-class-skeleton)
              ("for loop" . python-for-skeleton)
              ("try/except" . python-try-skeleton)))
           
           ;; C mode snippets
           ((string= mode-name "c-mode")
            '(("function" . c-function-skeleton)
              ("if block" . c-if-skeleton)
              ("while loop" . c-while-skeleton)
              ("struct" . c-struct-skeleton)
              ("main function" . c-main-skeleton)))
           
           ;; Emacs Lisp snippets
           ((string= mode-name "emacs-lisp-mode")
            '(("defun" . elisp-defun-skeleton)
              ("let block" . elisp-let-skeleton)
              ("condition-case" . elisp-condition-case-skeleton)
              ("add-hook" . elisp-add-hook-skeleton)))
           
           ;; HTML snippets
           ((string= mode-name "mhtml-mode")
            '(("HTML5 boilerplate" . (lambda () (tempo-insert-template "html5-boilerplate")))
              ("div with class" . (lambda () (tempo-insert-template "html-div")))
              ("list structure" . (lambda () (tempo-insert-template "html-list")))))
           
           ;; Default snippets
           (t
            '(("insert date" . insert-date-skeleton)
              ("insert UUID" . insert-uuid-skeleton))))))
    
    (when snippets
      (let* ((choices (mapcar #'car snippets))
             (selected (completing-read "Select snippet: " choices)))
        (when selected
          (let ((snippet (cdr (assoc selected snippets)))
            (when snippet
              (call-interactively snippet))))))))

;; Bind snippet menu globally
(global-set-key (kbd "C-c s s") 'my/snippet-menu)

;;; snippets.el ends here
