(defun pipenv--is-valid-pipenv (dir)
  (and
   (file-directory-p dir)
   (file-exists-p (concat (string-trim-right dir "/") "/Pipfile"))
   ))


(defun pipenv--guess-pipenv ()
  (let (
	(current-guess-path (or buffer-file-name "/"))
	)
    (or current-guess-path (setq current-guess-path "~/"))
    (let ((current-guess-path-list (split-string current-guess-path "/")))
      (while (not (or (pipenv--is-valid-pipenv current-guess-path) (string= "/" current-guess-path)))
      (setq current-guess-path-list (butlast current-guess-path-list 1))
      (setq current-guess-path (concat (string-join current-guess-path-list "/")))
    )
    (if (string= current-guess-path "/") (setq current-guess-path "~/") (setq current-guess-path (concat current-guess-path "/")))
    )
    current-guess-path
  ))


(defun pipenv--prompt-pipenv-dir (current-trial &optional invalid)
  (let ((prompt "Select Pipenv working directory: "))
    (if invalid (setq prompt (concat "Invalid Pipenv. " prompt)))
  (read-directory-name prompt current-trial)
  ))

(defun pipenv--prompt-valid-pipenv-dir ()
    (let
	((current-trial "") (invalid nil))
      (while (not (pipenv--is-valid-pipenv current-trial))
	(or (not (string= "" current-trial)) (setq current-trial (pipenv--guess-pipenv)))
	(setq current-trial (pipenv--prompt-pipenv-dir current-trial invalid))
	(setq invalid "t")
	)
      current-trial
      ))

(defun pipenv--pipenv-get-venv (pipenv-dir)
  (string-trim-right
   (shell-command-to-string
    (concat "cd " pipenv-dir ";pipenv --venv")
    )
   ))


(defun pipenv--pyvenv-workon-set-pipenv (pipenv-dir)
  (pyvenv-activate pipenv-dir)
  )

(defun pipenv--pipenv-workon ()
  (let ((pipenv-dir (pipenv--pipenv-get-venv (pipenv--prompt-valid-pipenv-dir))))
    (pipenv--pyvenv-workon-set-pipenv pipenv-dir) (lsp))
  )

(defun pipenv-activate () (interactive) (pipenv--pipenv-workon))

(provide 'pipenv)
