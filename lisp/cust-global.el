(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode 1)
(show-paren-mode t)
(projectile-global-mode 1)
(yas-global-mode 1)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(setq initial-scratch-message ";; Emacs\n\n")

(use-package helm
  :ensure t
  :defer t)

(use-package helm-ag
  :ensure t
  :defer t)

(use-package projectile
  :ensure t
  :defer t)

(add-to-list 'projectile-globally-ignored-directories "^node_modules$")

(use-package helm-projectile
  :ensure t
  :defer t)

(provide 'cust-global)
