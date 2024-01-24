;;; Key bindings
(global-set-key (kbd "C-c c") 'company-yasnippet)
(global-set-key (kbd "C-.") 'company-filter-candidates)


(global-set-key (kbd "C-c s") 'toggle-treemacs)
(global-set-key (kbd "C-c d") 'display-line-numbers-mode)

(defun tdd-zen-toggle ()
  "Custom function to reduce prompting."
  (interactive)
  (if compilation-read-command (setq compilation-read-command nil) (setq compilation-read-command t))
  )

(global-set-key (kbd "C-c y") 'projectile-toggle-between-implementation-and-test)
(global-set-key (kbd "C-c o") 'projectile-find-other-file)
(global-set-key (kbd "C-c t") 'projectile-test-project)
(global-set-key (kbd "C-c z") 'tdd-zen-toggle)
(global-set-key (kbd "C-c i") 'dap-debug)

(global-set-key (kbd "C-c g") 'magit-status)

(provide 'cust-keymap)
