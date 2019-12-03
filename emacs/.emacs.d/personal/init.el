;;; init.el --- my personal init.
;;; Commentary:
;;; Code:
(server-start)

(defvar my/packages
  '(auto-package-update
    flycheck-golangci-lint
    solarized-theme
    toml-mode
    ggtags)
  "A list of packages to ensure are installed.")

(defun my/packages-installed-p ()
  (loop for p in my/packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (my/packages-installed-p)
  (message "%s" "Refreshing my package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p my/packages)
    (when (not (package-installed-p p))
      (package-install p))))

(global-set-key "\C-x\C-m" 'execute-extended-command)

(defvar anaconda-mode-port)
(defvar js2-basic-offset)
(defvar js2-strict-trailing-comma-warning)

(setq anaconda-mode-port 9000)
(setq js2-basic-offset 2)
(setq js2-strict-trailing-comma-warning nil)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))

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

(add-hook 'markdown-mode-hook 'visual-line-mode)
(defun my/markdown-config ()
  (local-set-key (kbd "M-q") 'ignore)
  (whitespace-mode -1))
(add-hook 'markdown-mode-hook 'my/markdown-config)


(when (memq window-system '(mac ns))
  (exec-path-from-shell-copy-envs '("GOPATH"))
  (exec-path-from-shell-initialize))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)

(add-to-list 'auto-mode-alist '("\\.jsx\\'"    . js2-jsx-mode))

(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(setq cedet-global-command "global")

;; Prelude enables whitespace-mode by default, which makes tabs explode in your
;; face. So we turn it off.
(setq prelude-whitespace nil)

(provide 'init)
;;; init.el ends here
