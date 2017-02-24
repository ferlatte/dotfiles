;;; init.el --- my personal init.
;;; Commentary:
;;; Code:
(server-start)

(global-set-key "\C-x\C-m" 'execute-extended-command)

(defvar anaconda-mode-port)
(defvar js2-basic-offset)
(defvar js2-strict-trailing-comma-warning)

(setq anaconda-mode-port 9000)
(setq js2-basic-offset 2)
(setq js2-strict-trailing-comma-warning nil)

(defun my/use-eslint-from-node-modules ()
  "Use local eslint in node_modules instead of global install."
  (defvar flycheck-javascript-eslint-executable)
  (let* ((root (locate-dominating-file
                 (or (buffer-file-name) default-directory)
                 "node_modules"))
          (eslint (and root
                       (expand-file-name "node_modules/.bin/eslint" root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

(provide 'init)
;;; init.el ends here
