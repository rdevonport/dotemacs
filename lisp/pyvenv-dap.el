(setq pyvenv-debug--debug-target-function `(, "-m unittest discover ."))
(setq pyvenv-last-conf '())


(setq pyvenv-debug--last-script-path nil)

(defun pyvenv-debug--script-prompt ()
  (if pyvenv-debug--last-script-path
      (concat "Select a python script (default " pyvenv-debug--last-script-path "):")
    "Select a python script: "))


(defun pyvenv-debug--valid-script-path (path)
  (string-match-p
   (concat "^" (expand-file-name (projectile-project-root)) ".*" "\\.py$")
   (expand-file-name path))
  )

(defun pyvenv-debug--prompt-for-script ()
(setq pyvenv-debug--last-script-path
      (substring
       (expand-file-name (read-file-name
        (pyvenv-debug--script-prompt)
        (projectile-project-root)
        pyvenv-debug--last-script-path nil nil
        (lambda (x) (pyvenv-debug--valid-script-path x))))
       (length (expand-file-name (projectile-project-root))))
      )
)

(defun pyvenv-debug--check-requires-script (conf)
  (if
      (and (not (plist-get conf :module))
           (not (plist-get conf :program)))
      (plist-put conf :program (pyvenv-debug--prompt-for-script)))
  conf)

(defun
    pyvenv-debug--populate-start-file-args (conf)
  (-> conf
      (pyvenv-debug--check-requires-script)
      (dap--put-if-absent :dap-server-path (list (executable-find "python") "-m" "debugpy.adapter"))
      (dap--put-if-absent :type "pyvenv-debugpy")
      (dap--put-if-absent :name "Pyvenv DebugPy Debug")
      (dap--put-if-absent :cwd (projectile-project-root))
      )
  )

(eval-after-load "dap-mode"
  '(progn
     (dap-register-debug-provider "pyvenv-debugpy" 'pyvenv-debug--populate-start-file-args)
     (dap-register-debug-template "PyVenv :: DebugPy - unittest"
                             (list :type "pyvenv-debugpy"
                                   :request "launch"
                                   :module "unittest"
                                   :args (list "discover" ".")
                                   :name "PyVenv::DebugPy::unittest"))
     (dap-register-debug-template "PyVenv :: DebugPy - script"
                             (list :type "pyvenv-debugpy"
                                   :request "launch"
                                   :args (list "")
                                   :name "PyVenv::DebugPy::script"))))
(provide 'pyvenv-dap)
