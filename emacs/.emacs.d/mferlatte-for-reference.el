;; For MacOS X Emacs.app. The default PATH is very sparse.
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp") t)

;; This allows the use of customize without mucking up the .emacs
;; For this pass, try to put as much into customization as possible.
(set 'custom-file (expand-file-name "~/.emacs.d/custom.el"))
(load custom-file t)

(cd "~")

(package-initialize)
(server-start)

;; Disable insertion of explicit tabs
;; Need to use setq-default here because indent-tabs-mode is a buffer local
;; variable, so just setting it here doesn't work.
(setq-default indent-tabs-mode nil)

;; applescript-mode
(add-to-list 'magic-mode-alist
             '(".*osascript$" . applescript-mode))


;; css-mode
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

;; ediff
;; If the frame is wide enough, make ediff put the versions next to each
;; other instead of on top of each other.
;; From aaronb@lindenlab.com
(set 'ediff-split-window-function
     (lambda (&optional arg)
       (if (> (frame-width) 150)
           (split-window-horizontally arg)
         (split-window-vertically arg))))

;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'magic-mode-alist
             ;; If the first line of the file end in 'node', it's probably
             ;; a JavaScript file.
             '(".*node$" . js2-mode))
(add-hook 'js2-mode-hook
          (lambda ()
            (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
;; After js2 has parsed a js file, we look for jslint globals decl
;; comment ("/* global Fred, _, Harry */") and add any symbols to a
;; buffer-local var of acceptable global vars Note that we also
;; support the "symbol: true" way of specifying names via a hack
;; (remove any ":true" to make it look like a plain decl, and any
;; ':false' are left behind so they'll effectively be ignored as you
;; can't have a symbol called "someName:false"
(add-hook 'js2-post-parse-callbacks
          (lambda ()
            (when (> (buffer-size) 0)
              (let ((btext (replace-regexp-in-string
                            ": *true" " "
                            (replace-regexp-in-string "[\n\t ]+" " " (buffer-substring-no-properties 1 (buffer-size)) t t))))
                (mapc (apply-partially 'add-to-list 'js2-additional-externs)
                      (split-string
                       (if (string-match "/\\* *global *\\(.*?\\) *\\*/" btext) (match-string-no-properties 1 btext) "")
                       " *, *" t)) ))))

;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook (lambda () (visual-line-mode t)))

;; ruby-mode
(add-to-list 'auto-mode-alist
             '("\\.podspec\\'" . ruby-mode))

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(defun insert-iso8601-date (&optional arg)
  "Insert the current date formatted in ISO-8601 format.  If called with a
prefix argument, also inserts the current time."
  (interactive "P")
  (if arg
      (insert (format-time-string "%Y-%m-%dT%H:%M:%S%z "))
    (insert (format-time-string "%Y-%m-%d "))))

;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-region
(defun unfill-region ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-region (region-beginning) (region-end) nil)))

(defun untabify-buffer ()
  "Convert all tabs in buffer to spaces, preserving columns.  See `untabify'."
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  "Indent the entire buffer. See `indent-region'."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun shell-command-on-buffer (command &optional output-buffer replace)
  "Execute a shell command with the entire buffer as input.
See shell-command-on-region"
  (interactive "MShell command on buffer: \nP")
  (if current-prefix-arg
      (setq output-buffer current-prefix-arg))
  (shell-command-on-region (point-min) (point-max) command output-buffer
                           replace))

;; \C-x\C-m has nothing bound to it by default
(global-set-key "\C-x\C-m" 'execute-extended-command)
;; \C-xt has nothing bound to it by default.
(global-set-key "\C-xt" 'insert-iso8601-date)
;; \C-cg has nothing bound to it by default.
(global-set-key "\C-cg" 'browse-url-at-point)
