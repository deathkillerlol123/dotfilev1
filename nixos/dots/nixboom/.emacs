(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(menu-bar-mode -1) 
(toggle-scroll-bar -1) 
(tool-bar-mode -1) 

(define-abbrev-table 'global-abbrev-table
  '(("fx" "{config,inputs,lib,pkgs,...}:{\n  flake.nixosModules.")))
(setq-default abbrev-mode t)

(use-package eglot
  :hook (nix-mode . eglot-ensure))

(setq backup-directory-alist '(("." . "/tmp"))
      backup-by-copying      t  
      version-control        t  
      delete-old-versions    t  
      kept-old-versions      1) 
(setq corfu-auto t
      corfu-auto-delay 0
      corfu-auto-trigger "."
      )
(use-package colorful-mode
  :custom 
  (colorful-use-prefix t)
  (colorful-only-strings 'only-prog)
  (css-fontify-colors nil)
  :config
  (global-colorful-mode t)
  (add-to-list 'global-colorful-modes 'helpful-mode))
(use-package which-key  
  :ensure t
  :config
  (which-key-mode))

(require 'tree-sitter)
(require 'tree-sitter-langs)
(require 'org-mime)

(require 'multiple-cursors)
(global-set-key
 (kbd "C-.")
 'mc/mark-next-like-this)

(defun volatile-kill-buffer()
  "Kill current buffer unconditionally"
  (interactive)
  (let (( buffer-modified-p nil))
    (kill-buffer (current-buffer))))
(global-set-key
 (kbd "C-x k")
 'volatile-kill-buffer)

(add-hook 'nix-mode-hook 'eglot-ensure)
(global-set-key
 (kbd "C-x f")
 'eglot-format-buffer)


(defun mm/generate-temp-buffer (buf)
  "A function to generate temprory buffers using either  a random name or given name"
  (interactive "sNew temp buffer name: ")
  (switch-to-buffer
   (get-buffer-create
    (concat "*tmp*"
            (if (equal buf "")
                (make-temp-name "")
              buf)
            "*")
    )))

(setq c-tab-always-indent nil)
(setq-default case-fold-search nil)
(setq vc-follow-symlinks t)
(setq indent-tabs-mode t
      tab-width 4)

;; speed 
(setq bedrock--initial-gc-threshold gc-cons-threshold)
(setq gc-cons-threshold 10000000)
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)

(line-number-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-interval 20)
 '(auto-save-timeout 3)
 '(custom-enabled-themes '(modus-vivendi-tinted))
 '(evil-auto-indent t)
 '(package-selected-packages
   '(## aggressive-indent auto-complete avy-embark-collect colorful-mode
	company corfu doc-view-follow eglot-inactive-regions
	electric-cursor evil flycheck format-all golden-ratio jinx
	json-mode latex-extra lsp-latex lsp-pyright lsp-python-ms
	lsp-treemacs lsp-ui lua-mode magit multiple-cursors nix-buffer
	nix-mode nixos-options nixpkgs-fmt org-beautify-theme
	org-bullets org-mime org-pretty-tags pdf-tools python-mode
	qml-mode rainbow-blocks rainbow-mode transpose-frame
	tree-inspector tree-sitter-indent tree-sitter-langs
	yasnippet-classic-snippets yasnippet-snippets zetteldeft)))
(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))
(add-hook 'after-init-hook 'global-company-mode)
(global-display-line-numbers-mode)
(global-tree-sitter-mode)
(global-corfu-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'css-mode-hook #'aggressive-indent-mode)
(put 'downcase-region 'disabled nil)


;; org mode 
(when (member "Symbola" (font-family-list))
  (set-fontset-font "fontset-default" nil
                    (font-spec :size 20 :name "Symbola")))
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq org-startup-indented t
      org-src-tab-acts-natively t)
(add-hook 'org-mode-hook
          (lambda ()
            (variable-pitch-mode 1)
            visual-line-mode))
(setq org-hide-emphasis-markers t
      org-fontify-done-headline t
      org-hide-leading-stars t
      org-pretty-entities t
      org-odd-levels-only t)
(setq org-list-demote-modify-bullet
      (quote (("+" . "-") ("-" . "+") ("*" . "-") ("1." . "-") ("1)" . "-") ("A)" . "-") ("B)" . "-")
              ("a)" . "-") ("b)" . "-") ("A." . "-") ("B." . "-") ("a." . "-") ("b." . "-"))))
(use-package org-bullets
  :custom
  (org-bullets-bullet-list '("◉" "☯" "○" "☯" "✸" "☯" "✿" "☯" "✜" "☯" "◆" "☯" "▶"))
  (org-ellipsis "⤵")
  :hook (org-mode . org-bullets-mode))
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([+]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "◦"))))))




;; opeing docx and pdf
(defvar-local my/docx-generated-pdf nil)
(defvar-local my/zathura-process nil)

(defun my/delete-docx-pdf ()
  (when (and my/docx-generated-pdf
             (file-exists-p my/docx-generated-pdf))
    (delete-file my/docx-generated-pdf)))

(defun my/open-zathura (file delete-after)
  (setq my/zathura-process
        (start-process "zathura" nil "zathura" file))

  (set-process-sentinel
   my/zathura-process
   (lambda (proc event)
     (when (memq (process-status proc) '(exit signal))
       (when delete-after
         (my/delete-docx-pdf))))))

(defun my/open-docx ()
  (let* ((file (expand-file-name buffer-file-name))
         (dir (file-name-directory file))
         (name (file-name-sans-extension
                (file-name-nondirectory file)))
         (pdf (concat dir name ".pdf")))

    (unless (file-exists-p pdf)
      (call-process "libreoffice" nil "*docx-convert*" nil
                    "--headless"
                    "--convert-to" "pdf"
                    file))

    (setq my/docx-generated-pdf pdf)
    (my/open-zathura pdf t)))

(defun my/open-pdf ()
  (my/open-zathura buffer-file-name nil))

(defun my/doc-handler ()
  (when buffer-file-name
    (cond
     ((string-match "\\.docx\\'" buffer-file-name)
      (my/open-docx))
     ((string-match "\\.pdf\\'" buffer-file-name)
      (my/open-pdf)))))

(add-hook 'find-file-hook #'my/doc-handler)
