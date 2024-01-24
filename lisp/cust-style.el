(add-to-list 'default-frame-alist '(font . "JetBrains Mono-12"))
(add-to-list 'default-frame-alist '(line-spacing . 0.2))

(setq base16-theme-256-color-source "colors")
(use-package base16-theme
	     :ensure t
	     :config
	     (load-theme 'base16-default-dark t))

(use-package ligature
  :ensure t
  :defer t)


(use-package treemacs-all-the-icons
      :ensure t
      :defer t
      :config
    )

(use-package treemacs
  :ensure t
  :defer t
  :config
  (progn
    (setq treemacs-position 'left)
    (treemacs-resize-icons 16)
    (set-face-attribute 'treemacs-root-face nil
                        :height 1.0
                        :underline nil
                        )
    (set-face-attribute 'treemacs-directory-face nil
                        :font "JetBrains Mono-11")
    (set-face-attribute 'treemacs-file-face nil 
                        :font "JetBrains Mono-11")
    (set-face-attribute 'treemacs-git-renamed-face nil
                        :font "JetBrains Mono-11")
    (set-face-attribute 'treemacs-git-modified-face nil
                        :font "JetBrains Mono-11")
    (set-face-attribute 'treemacs-git-conflict-face nil
                        :font "JetBrains Mono-11")
    (set-face-attribute 'treemacs-git-added-face nil
                        :font "JetBrains Mono-11")
    (set-face-attribute 'treemacs-git-untracked-face nil
                        :font "JetBrains Mono-11")
    (set-face-attribute 'treemacs-git-unmodified-face nil
                        :font "JetBrains Mono-11")
    (set-face-attribute 'treemacs-git-commit-diff-face nil
                        :font "JetBrains Mono-11")
    (set-face-attribute 'treemacs-git-ignored-face nil
                        :font "JetBrains Mono-11")
    (require 'treemacs-all-the-icons)
    (treemacs-load-theme "all-the-icons")
    )
  )
  


(defun toggle-treemacs ()
  "Custom function to start the speedbar."
  (interactive)
  (treemacs)
  )

(use-package powerline
	     :ensure t
	     :config
	     (powerline-default-theme))
(setq powerline-gui-use-vcs-glyph t)

(provide 'cust-style)
