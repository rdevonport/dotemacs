(setq org-agenda-files '("~/org-local/work" "~/org-local/personal"))

(setq org-todo-keywords
            '((sequence "TODO" "BLOCKED" "ONGOING" "NEXT" "|" "DONE")))


(shell-command "~/org-local/sync-to-local.sh")

;; Auto-sync with s3
(defun org-mode-sync()
  "Auto sync org."
  (shell-command "~/org-local/sync-to-s3.sh &"))

(add-hook 'kill-emacs-hook 'org-mode-sync)

(provide 'cust-org)
;;; cust-org.el ends here
