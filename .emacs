(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

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
  ;; :diminish
  ;; :ensure t ; Optional
  :custom
  (colorful-use-prefix t)
  (colorful-only-strings 'only-prog)
  (css-fontify-colors nil)
  :config
  (global-colorful-mode t)
  (add-to-list 'global-colorful-modes 'helpful-mode))


(require 'tree-sitter)
(require 'tree-sitter-langs)
(require 'org-mime)

(require 'multiple-cursors)
(global-set-key
 (kbd "C-.")
 'mc/mark-next-like-this)

(global-set-key
 (kbd "C-q")
 'ace-swap-window)

(defun volatile-kill-buffer()
  "Kill current buffer unconditionally"
  (interactive)
  (let (( buffer-modified-p nil))
    (kill-buffer (current-buffer))))
(global-set-key
 (kbd "C-x k")
 'volatile-kill-buffer)

(defun mm/generate-temp-buffer (buf)
  "A function to generate temprory buffers using either
a random name or given name"
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


(line-number-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi-tinted))
 '(evil-auto-indent t)
 '(package-selected-packages
   '(ace-windowt avy-embark-collect colorful-mode corfu
		 corfu-candidate-overlay eglot-inactive-regions
		 flycheck json-mode lsp-latex lsp-mode lsp-python-ms
		 lsp-ui lua-mode multiple-cursors org-beautify-theme
		 org-bullets org-pretty-tags org-roam python-mode
		 qml-mode rainbow-mode tree-inspector tree-sitter
		 tree-sitter-indent tree-sitter-langs zetteldeft)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-hook 'after-init-hook 'global-company-mode)
(global-display-line-numbers-mode)
(global-tree-sitter-mode)
(global-corfu-mode)


(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'css-mode-hook #'aggressive-indent-mode)
(put 'downcase-region 'disabled nil)




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
      (quote (("+" . "-")
              ("-" . "+")
              ("*" . "-")
              ("1." . "-")
              ("1)" . "-")
              ("A)" . "-")
              ("B)" . "-")
              ("a)" . "-")
              ("b)" . "-")
              ("A." . "-")
              ("B." . "-")
              ("a." . "-")
              ("b." . "-"))))
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
