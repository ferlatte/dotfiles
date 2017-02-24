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

(provide 'init)
;;; init.el ends here
