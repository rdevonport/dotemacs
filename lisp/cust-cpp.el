(add-hook 'c++-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'electric-pair-mode)

(ligature-set-ligatures '(c++-mode) '("=>" "==" "!=" "<=" ">=" "==="))
(add-hook 'c++-mode-hook
          #'ligature-mode)

(add-hook 'c-mode-hook #'lsp)
(add-hook 'c-mode-hook #'electric-pair-mode)

(ligature-set-ligatures '(c-mode) '("=>" "==" "!=" "<=" ">=" "==="))
(add-hook 'c-mode-hook
          #'ligature-mode)

(use-package meson-mode
  :ensure t
  :defer t)

(require 'meson-dap)

(provide 'cust-cpp)
