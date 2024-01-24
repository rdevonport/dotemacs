

(defun cust-projects--split-dir-filename-fileext (var-file-path)
  (let ((parts (string-split var-file-path "/")))
    (append
     (list :path
           (concat (string-join (take (max 1 (- (length parts) 1)) parts) "/") "/"))
     (let ((file-parts (string-split (car (last parts)) "\\.")))   
       (list :name (pop file-parts) :ext (concat "." (string-join file-parts ".")))
       
       )
     )
    ))

(defun cust-projects--get-other-file-regex (filename ext)
  (concat ".*/" filename (string-join (string-split ext "\\.") "\\.") "$")
  )


(defun cust-projects--find-project-file (project-dir filename ext)
  (-filter
   (lambda (f) (string-match-p (cust-projects--get-other-file-regex filename ext) f))
   (projectile-project-files project-dir)
   )
  )

(setq cust-projects--other-files-cache (make-hash-table :test 'equal))

(defun cust-projects--meson-file-is-decl (file)
  (string-match-p ".*\\.test\\.hpp$" file)
  )

(defun cust-projects--meson-file-is-test (file)
  (string-match-p ".*\\.test\\.cpp$" file)
  )

(defun cust-projects--meson-file-is-impl (file)
  (and (string-match-p ".*\\.cpp$" file) (not (cust-projects--meson-file-is-test file)))
  )


(defun cust-projects--find-meson-files
    (file)
  (let ((fileparts (cust-projects--split-dir-filename-fileext (expand-file-name file))))
    (append
     (if (not (cust-projects--meson-file-is-impl file))
         (list :impl (
                      cust-projects--find-project-file
                      "/home/rory/source/ghoti/"
                      (plist-get fileparts :name )
                      ".cpp")) nil
         )
     (if (not (cust-projects--meson-file-is-test file))
         (list :test (
                      cust-projects--find-project-file
                      "/home/rory/source/ghoti/"
                      (plist-get fileparts :name )
                      ".test.cpp")) nil
         )

     (if (not (cust-projects--meson-file-is-decl file))
         (list :decl (
                      cust-projects--find-project-file
                      "/home/rory/source/ghoti/"
                      (plist-get fileparts :name )
                      ".hpp")) nil)
     
     )
    )
  )


(defun cust-projects--try-cache-fine-meson-files (file)
  (if (gethash file cust-projects--other-files-cache)
      (gethash file cust-projects--other-files-cache)
    (puthash file (cust-projects--find-meson-files file)
             cust-projects--other-files-cache)
    )
  )

(defun cust-projects--meson-related-files (path)
  (cust-projects--try-cache-fine-meson-files path)
  )

(projectile-register-project-type 'meson '("meson.build")
                                  :project-file "meson.build"
                                  :compilation-dir "build"
                                  :configure "meson %s"
                                  :compile "ninja"
                                  :test "ninja test"
                                  :related-files-fn #'cust-projects--meson-related-files
                                  )

;(projectile--related-files-plist (projectile-project-root) (buffer-file-name))

(provide 'cust-projects)
