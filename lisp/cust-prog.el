(setq-default indent-tabs-mode nil)

(use-package yasnippet-snippets
  :ensure t
  :defer t)

(use-package magit
  :ensure t
  :defer t)

(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

(use-package company
  :ensure t)
(setq company-idle-delay 0)

(use-package flycheck
  :ensure t
  :defer t)

(use-package lsp-mode
  :ensure t
  :defer t
  :commands lsp
  :config
  ;; same definition as mentioned earlier
  (advice-add 'json-parse-string :around
              (lambda (orig string &rest rest)
		(apply orig (s-replace "\\u0000" "" string)
                       rest)))
  (setq lsp-progress-prefix " ") ;" … "
  ;; minor changes: saves excursion and uses search-forward instead of re-search-forward
  (advice-add 'json-parse-buffer :around
              (lambda (oldfn &rest args)
		(save-excursion 
                  (while (search-forward "\\u0000" nil t)
                    (replace-match "" nil t)))
		(apply oldfn args))))


(use-package dap-mode
  :defer t
  :ensure t)
(setq dap-auto-configure-features '(sessions locals tooltip))
(add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra)))

;;; Key bindings
(global-set-key (kbd "C-c c") 'company-yasnippet)
(global-set-key (kbd "C-.") 'company-filter-candidates)

(require 'cust-ts)
(require 'cust-py)
(require 'cust-vue)
(require 'cust-elisp)
;; (require 'cust-cpp)


(provide 'cust-prog)
