(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(setq backup-directory-alist '(("." . "~/dotfiles/emacs_backups"))
      backup-by-copying      t  
      version-control        t  
      delete-old-versions    t  
      kept-old-versions      1) 


(require 'tree-sitter)
(require 'tree-sitter-langs)

(require 'multiple-cursors)
(global-set-key
 (kbd "C-.")
 'mc/mark-next-like-this)


(setq c-tab-always-indent nil)
(setq-default case-fold-search nil)
(setq vc-follow-symlinks t)

(line-number-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi-tinted))
 '(evil-auto-indent t)
 '(package-selected-packages
   '(company eglot-inactive-regions flycheck lsp-latex
	     lsp-mode lsp-python-ms lsp-ui multiple-cursors
	     tree-inspector tree-sitter tree-sitter-indent
	     tree-sitter-langs)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-hook 'after-init-hook 'global-company-mode)
(global-display-line-numbers-mode)
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(put 'downcase-region 'disabled nil)
