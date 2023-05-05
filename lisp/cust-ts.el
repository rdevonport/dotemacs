(use-package typescript-mode
  :ensure t
  :defer t)

(add-hook 'typescript-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'electric-pair-mode)

(ligature-set-ligatures '(typescript-mode) '("=>" "==" "!=" "<=" ">=" "==="))
(add-hook 'typescript-mode-hook
          #'ligature-mode)

(provide 'cust-ts)
