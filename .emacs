(add-to-list 'load-path "/home/nixboom/dotfiles/")
(setq c-tab-always-indent nil)
(setq-default case-fold-search nil)
(setq vc-follow-symlinks t)

(line-number-mode 1)

(custom-set-variables
 '(custom-enabled-themes '(modus-vivendi-tinted))
 '(package-selected-packages '(company multiple-cursors)))
(custom-set-faces

 )

(add-hook 'after-init-hook 'global-company-mode)
