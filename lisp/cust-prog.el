(use-package magit
  :ensure t)

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(require 'cust-cpp)
(require 'cust-py)

(provide 'cust-prog)
