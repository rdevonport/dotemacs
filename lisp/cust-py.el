(use-package pyvenv
  :ensure t
  :defer t)

(require 'pipenv)

(ligature-set-ligatures '(python-mode) '("->" "==" "!=" "<=" ">="))
(add-hook 'python-mode-hook
          #'ligature-mode)
(add-hook 'python-mode-hook
          (lambda () (local-set-key (kbd "C-c v") #'pipenv-activate)))

(require 'dap-python)
;; if you installed debugpy, you need to set this
;; https://github.com/emacs-lsp/dap-mode/issues/306
(setq dap-python-debugger 'debugpy)

(add-hook 'inferior-python-mode-hook #'company-mode)

(provide 'cust-py)
