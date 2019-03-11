(use-package helm
  :ensure t)

(use-package yasnippet-snippets
  :ensure t)
(use-package projectile
  :ensure t)

(menu-bar-mode -1)
;(scroll-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode 1)
(show-paren-mode t)
(projectile-global-mode 1)
(yas-global-mode 1)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(provide 'cust-global)
