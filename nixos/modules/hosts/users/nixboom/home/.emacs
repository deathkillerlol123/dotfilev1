(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(setq package-install-upgrade-built-in t)
(package-initialize)

(defun jeff/format-nix-buffer ()
  "Format the current nix file using alejadra."
  (interactive)
  (when (eq major-mode 'nix-mode)
    (save-buffer)
    (shell-command (format "alejandra %s" (shell-quote-argument buffer-file-name)))
    (revert-buffer :ignore-auto :noconfirm)))
(global-set-key (kbd "C-x f") #'jeff/format-nix-buffer)
(global-set-key (kbd "C-x a") #'append-to-buffer)
(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0)
  (corfu-auto-trigger ".")
  :config
  (global-corfu-mode))


(menu-bar-mode -1) 
(toggle-scroll-bar -1) 
(tool-bar-mode -1) 

(define-abbrev-table 'global-abbrev-table
  '(("fx" "{config,inputs,lib,pkgs,...}:{\n  flake.nixosModules.<name> = {config,inputs,lib,pkgs,...}:\n  {\n  };\n}")))
(define-abbrev-table 'global-abbrev-table
  '(("hx" "{config,inputs,lib,pkgs,...}:{\n  flake.homeModules.<name> = {config,inputs,lib,pkgs,...}:\n  {\n  };\n}")))
(setq-default abbrev-mode t)

(use-package eglot
  :hook (nix-mode . eglot-ensure))

(setq backup-directory-alist '(("." . "/tmp"))
      backup-by-copying      t  
      version-control        t  
      delete-old-versions    t  
      kept-old-versions      1)
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
	electric-cursor evil flycheck format-all golden-ratio
	hide-mode-line jinx json-mode latex-extra lsp-latex
	lsp-pyright lsp-python-ms lsp-treemacs lsp-ui lua-mode
	multiple-cursors nix-buffer nix-mode nixos-options nixpkgs-fmt
	org-beautify-theme org-bullets org-mime org-pretty-tags
	pdf-tools python-mode qml-mode rainbow-blocks rainbow-mode
	transient transpose-frame tree-inspector tree-sitter-indent
	tree-sitter-langs yasnippet yasnippet-classic-snippets
	yasnippet-snippets zetteldeft)))
(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))
(use-package company
  :ensure t
  :config
  (global-company-mode))
(global-display-line-numbers-mode)
(global-tree-sitter-mode)

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
(put 'scroll-left 'disabled nil)
