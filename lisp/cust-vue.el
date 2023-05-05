(use-package web-mode
  :ensure t
  :defer t)


(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))

(add-hook 'web-mode-hook #'lsp)


(provide 'cust-vue)
