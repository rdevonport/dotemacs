(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)
(package-refresh-contents)

(dolist (package '(use-package))
   (unless (package-installed-p package)
       (package-install package)))

(provide 'cust-init)
