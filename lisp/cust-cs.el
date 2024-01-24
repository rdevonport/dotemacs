(use-package csharp-mode
  :ensure t
  :defer t)

(add-hook 'csharp-mode-hook #'lsp)
(add-hook 'csharp-mode-hook #'electric-pair-mode)

(ligature-set-ligatures '(csharp-mode) '("=>" "==" "!=" "<=" ">=" "==="))
(add-hook 'csharp-mode-hook
          #'ligature-mode)

(provide 'cust-cs)
