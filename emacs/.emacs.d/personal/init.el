;;; init.el --- my personal init.
;;; Commentary:
;;; Code:
(server-start)

(defvar my/packages
  '(flycheck-gometalinter solarized-theme toml-mode)
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

(require 'flycheck-gometalinter)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-gometalinter-setup))

;; skips 'vendor' directories and sets GO15VENDOREXPERIMENT=1
(setq flycheck-gometalinter-vendor t)
;; use in tests files
(setq flycheck-gometalinter-test t)
;; Only use fast linters
(setq flycheck-gometalinter-fast t)
;; Set different deadline (default: 5s)
(setq flycheck-gometalinter-deadline "30s")
(setq flycheck-gometalinter-disable-linters (list "gocyclo"))

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

(provide 'init)
;;; init.el ends here
