{...}: {
  flake.homeModules.nbemacs = {pkgs, ...}: {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs;
      extraConfig = ''
          (require 'package)
          (require 'multiple-cursors)
          (require 'tree-sitter)
          (require 'tree-sitter-langs)
          (package-initialize)
          (golden-ratio-mode 1)
          (hide-mode-line-mode 1)
          (line-number-mode 1)
          (global-tree-sitter-mode 1)

          (add-to-list 'custom-theme-load-path
                       (file-name-directory (locate-library "kusanagi-theme")))
          (load-theme 'kusanagi t)

          (setq-default
           left-fringe-width 0
           abbrev-mode t
           case-fold-search nil
           indent-tabs-mode t
           tab-width 4)
          (setq
           c-tab-always-indent nil
           vc-follow-symlinks t
           backup-directory-alist '(("." . "/tmp"))
           backup-by-copying t
           version-control t
           delete-old-versions t
           kept-old-versions 1
           bedrock--initial-gc-threshold gc-cons-threshold
           gc-cons-threshold 10000000
           byte-compile-warnings '(not obsolete)
           warning-suppress-log-types '((comp) (bytecomp))
           native-comp-async-report-warnings-errors 'silent)
          (add-to-list 'auto-mode-alist '("\\\\.nix\\\\'" . nix-mode))

          (menu-bar-mode -1)
          (when (fboundp 'scroll-bar-mode)
            (scroll-bar-mode -1))
          (when (fboundp 'tool-bar-mode)
            (tool-bar-mode -1))

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

          (defun volatile-kill-buffer ()
            "Kill the current buffer without prompting to save changes."
            (interactive)
            (let ((buffer-modified-p nil))
              (kill-buffer (current-buffer))))
          (defun jeff/format-nix-buffer ()
            "Format the current Nix file using Alejandra."
            (interactive)
            (when (eq major-mode 'nix-mode)
              (save-buffer)
              (let ((file buffer-file-name))
                (when file
                  (if (zerop (call-process "alejandra" nil nil nil "--quiet" file))
                      (revert-buffer :ignore-auto :noconfirm)
                    (user-error "Alejandra formatting failed"))))))

          (global-set-key (kbd "C-x a") #'append-to-buffer)
          (global-set-key (kbd "C-.") #'mc/mark-next-like-this)
          (global-set-key (kbd "C-x k") #'volatile-kill-buffer)
          (global-set-key (kbd "C-x f") #'jeff/format-nix-buffer)

          (use-package eglot
            :hook (nix-mode . eglot-ensure))
          (use-package which-key
            :config
            (which-key-mode 1))

          (use-package colorful-mode
            :custom
            (colorful-use-prefix t)
            (colorful-only-strings 'only-prog)
            (css-fontify-colors nil)
            :config
            (global-colorful-mode 1))

          (add-hook 'nix-mode-hook #'hs-minor-mode)
          (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
          (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
          (add-hook 'css-mode-hook #'aggressive-indent-mode)
          (put 'downcase-region 'disabled nil)
          (put 'scroll-left 'disabled nil)
      '';

      extraPackages = epkgs:
        with epkgs; [
          kusanagi-theme
          aggressive-indent
          auto-complete
          colorful-mode
          company
          consult
          eglot-inactive-regions
          format-all
          golden-ratio
          jinx
          json-mode
          lsp-latex
          lsp-pyright
          lsp-python-ms
          lua-mode
          python-mode
          multiple-cursors
          nix-mode
          nixos-options
          org-beautify-theme
          transient
          tree-inspector
          tree-sitter-indent
          tree-sitter-langs
        ];
    };
  };
}
