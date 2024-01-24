(defun meson-debug--file-and-executable
    (attribute-modes)
  (and
   (not(string-equal "d" (substring attribute-modes 0 1)))
   (string-equal "x" (substring attribute-modes 9 10)))
  )

(defun meson-debug--get-executables
    (directory)
  (-filter
   (lambda (f)
     (meson-debug--file-and-executable
      (file-attribute-modes (file-attributes (concat directory "/" f))))
     )
   (directory-files directory)
   )
  )

(defun meson-debug--build-dir (project-root)
  (concat project-root "/build/"))

(setq meson-debug--target-history (list))

(defun meson-debug--get-default-target ()
  (if (length= meson-debug--target-history 0)
      nil (car (last meson-debug--target-history))
    )
  )

(defun meson-debug--get-target-prompt ()
  (if (meson-debug--get-default-target)
      (concat "Select debug target (default " (meson-debug--get-default-target) "): ")
    "Select debug target: ")
  )

(defun meson-debug--get-target ()
  (concat (meson-debug--build-dir (projectile-project-root))
          (completing-read
   (meson-debug--get-target-prompt)
   (meson-debug--get-executables
    (meson-debug--build-dir (projectile-project-root)))
   nil t nil
   'meson-debug--target-history (meson-debug--get-default-target)
   ))
  )

(setq meson-debug--debug-target-function 'meson-debug--get-target)
(setq meson-debug--debug-server-path `(,"lldb-vscode"))


(defun
    meson-debug--populate-start-file-args (conf)
  (-> conf
      (dap--put-if-absent :dap-server-path meson-debug--debug-server-path)
      (dap--put-if-absent :type "lldb-meson")
      (dap--put-if-absent :cwd default-directory)
      (dap--put-if-absent :program (if (commandp meson-debug--debug-target-function)
                                       (call-interactively meson-debug--debug-target-function)
                                     (funcall meson-debug--debug-target-function)))
      (dap--put-if-absent :name "Meson LLDB Debug")))


(eval-after-load "dap-mode"
  '(progn
     (dap-register-debug-provider "lldb-meson" 'meson-debug--populate-start-file-args)
     (dap-register-debug-template "Meson :: LLDB"
                             (list :type "lldb-meson"
                                   :cwd nil
                                   :request "launch"
                                   :program nil
                                   :name "Meson::LLDB"))))

(provide 'meson-dap)
