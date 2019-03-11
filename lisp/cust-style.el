(setq base16-theme-256-color-source "colors")
(use-package base16-theme
	     :ensure t
	     :config
	     (load-theme 'base16-default-dark t))


(use-package sr-speedbar
	     :ensure t)

(defun hide-speedbar-fringes ()
  "Hides the fringes of the Speedbar."
  (set-window-fringes (get-window-with-predicate
                       (lambda (window)
                         (string-equal "*SPEEDBAR*" (buffer-name (window-buffer window)))))
                      5 5))
(defun toggle-speedbar ()
  "Custom function to start the speedbar."
  (interactive)
  (sr-speedbar-toggle)
  (if (sr-speedbar-exist-p)
      (hide-speedbar-fringes))
  )

;;; Key bindings
(global-set-key (kbd "C-c s") 'toggle-speedbar)
(global-set-key (kbd "C-c d") 'linum-mode)


(use-package powerline
	     :ensure t
	     :config
	     (powerline-default-theme))
(setq powerline-gui-use-vcs-glyph t)

(provide 'cust-style)
