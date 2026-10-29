{...}: {
  flake.homeModules.nbemacs = {pkgs, ...}: {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraConfig = ''
          (require 'package)
          (package-initialize)

          (defun jeff/format-nix-buffer ()
            "Format the current Nix file using Alejandra."
            (interactive)
            (when (eq major-mode 'nix-mode)
              (save-buffer)
              (let ((file buffer-file-name))
                (when file
                  (if (zerop
                       (call-process "alejandra" nil nil nil file))
                      (revert-buffer :ignore-auto :noconfirm)
                    (user-error "Alejandra formatting failed"))))))

          (global-set-key (kbd "C-x f") #'jeff/format-nix-buffer)
          (global-set-key (kbd "C-x a") #'append-to-buffer)

          (use-package corfu
            :custom
            (corfu-auto t)
            (corfu-auto-delay 0)
            (corfu-auto-trigger ".")
            :config
            (global-corfu-mode 1))

          (menu-bar-mode -1)
          (when (fboundp 'scroll-bar-mode)
            (scroll-bar-mode -1))
          (when (fboundp 'tool-bar-mode)
            (tool-bar-mode -1))

          (setq-default
           abbrev-mode t
           case-fold-search nil
           indent-tabs-mode t
           tab-width 4)

          (define-abbrev-table 'global-abbrev-table
            '(("fx" "{config,inputs,lib,pkgs,...}:{
          flake.nixosModules.<name> = {config,inputs,lib,pkgs,...}: {
          };
        }")
              ("hx" "{config,inputs,lib,pkgs,...}:{
          flake.homeModules.<name> = {config,inputs,lib,pkgs,...}: {
          };
        }")
              ("wp" "{inputs,moduleWithSystem,...}:{
          flake.nixosModules.placeholder = moduleWithSystem ({pkgs,self',...}: { });
          perSystem = {pkgs,lib,...}: { };
        }")))

          (use-package eglot
            :hook (nix-mode . eglot-ensure))

          (add-to-list 'auto-mode-alist '("\\\\.nix\\\\'" . nix-mode))

          (setq backup-directory-alist '(("." . "/tmp"))
                backup-by-copying t
                version-control t
                delete-old-versions t
                kept-old-versions 1)

          (use-package colorful-mode
            :custom
            (colorful-use-prefix t)
            (colorful-only-strings 'only-prog)
            (css-fontify-colors nil)
            :config
            (global-colorful-mode 1))

          (use-package which-key
            :config
            (which-key-mode 1))

          (require 'multiple-cursors)
          (global-set-key (kbd "C-.") #'mc/mark-next-like-this)

          (defun volatile-kill-buffer ()
            "Kill the current buffer without saving changes."
            (interactive)
            (let ((buffer-modified-p nil))
              (kill-buffer (current-buffer))))

          (global-set-key (kbd "C-x k") #'volatile-kill-buffer)

          (setq c-tab-always-indent nil
                vc-follow-symlinks t)

          (setq bedrock--initial-gc-threshold gc-cons-threshold
                gc-cons-threshold 10000000
                byte-compile-warnings '(not obsolete)
                warning-suppress-log-types '((comp) (bytecomp))
                native-comp-async-report-warnings-errors 'silent)

          (line-number-mode 1)
          (global-display-line-numbers-mode 1)

          (require 'tree-sitter)
          (require 'tree-sitter-langs)
          (global-tree-sitter-mode 1)
          (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

          (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
          (add-hook 'css-mode-hook #'aggressive-indent-mode)

          (put 'downcase-region 'disabled nil)
          (put 'scroll-left 'disabled nil)

          (load-theme 'modus-vivendi-tinted t)
      '';
      extraPackages = epkgs:
        with epkgs; [
          aggressive-indent
          auto-complete
          avy-embark-collect
          colorful-mode
          company
          consult
          corfu
          doc-view-follow
          eglot-inactive-regions
          electric-cursor
          empv
          flycheck
          format-all
          golden-ratio
          hide-mode-line
          jinx
          json-mode
          latex-extra
          lsp-latex
          lsp-pyright
          lsp-python-ms
          lsp-treemacs
          lsp-ui
          lua-mode
          multiple-cursors
          nix-buffer
          nix-mode
          nixos-options
          nixpkgs-fmt
          org-beautify-theme
          org-bullets
          org-mime
          org-pretty-tags
          python-mode
          qml-mode
          rainbow-blocks
          rainbow-mode
          transient
          transpose-frame
          tree-inspector
          tree-sitter-indent
          tree-sitter-langs
          yasnippet
          yasnippet-classic-snippets
          yasnippet-snippets
          zetteldeft
        ];
    };
  };
}
