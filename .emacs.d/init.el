(require 'windmove)
(global-set-key (kbd "s-J")  'windmove-left)
(global-set-key (kbd "s-L") 'windmove-right)
(global-set-key (kbd "s-I")    'windmove-up)
(global-set-key (kbd "s-K")  'windmove-down)

(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)
(package-initialize)

(load-theme 'solarized t)

;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                               (interactive)
                               (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                               (interactive)
                               (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
  )

;; Manage backup files
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq
 backup-by-copying t      ; don't clobber symlinks
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
    version-control t)       ; use versioned backups

(require 'fill-column-indicator)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 0)

;; copying and pasting to main clipboard
(defun pbcopy ()
  (interactive)
  (call-process-region (point) (mark) "pbcopy")
  (setq deactivate-mark t))

(defun pbpaste ()
  (interactive)
  (call-process-region (point) (if mark-active (mark) (point)) "pbpaste" t t))

(defun pbcut ()
  (interactive)
  (pbcopy)
  (delete-region (region-beginning) (region-end)))

(global-set-key (kbd "S-c") 'pbcopy)
(global-set-key (kbd "S-v") 'pbpaste)
(global-set-key (kbd "S-x") 'pbcut)

;;; No sleeping!
(global-unset-key (kbd "C-z"))

;;; Hide ~ files in directories
(require 'dired-x)
(setq-default dired-omit-files-p t) ; Buffer-local variable

;;; Column indication
;; make column number mode the default
(setq column-number-mode t)t
(setq fci-rule-column 79)

;;; I hate tabs.
(setq-default indent-tabs-mode nil)


;;; Use flycheck!
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(asm-comment-char 47)
 '(dired-listing-switches "-alh")
 '(dired-omit-files "^#\\|^\\.$\\$")
 '(fill-column 79)
 '(flycheck-eslintrc "(substitute-in-file-name \"$HOME/.eslintrc\")")
 '(dired-listing-switches "-alh")
 '(dired-omit-files "^#\\|^\\.$\\$")
 '(fci-rule-color "yellow")
 '(fci-rule-column 79)
 '(flymake-allowed-file-name-masks
   (quote
    ((".+\\.go$" goflymake-init nil nil)
     ("\\.py\\'" flymake-pyflakes-init nil nil)
     ("\\.\\(?:c\\(?:pp\\|xx\\|\\+\\+\\)?\\|CC\\)\\'" flymake-simple-make-init nil nil)
     ("\\.cs\\'" flymake-simple-make-init nil nil)
     ("\\.p[ml]\\'" flymake-perl-init nil nil)
     ("\\.php[345]?\\'" flymake-php-init nil nil)
     ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup nil)
     ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup nil)
     ("\\.tex\\'" flymake-simple-tex-init nil nil)
     ("\\.idl\\'" flymake-simple-make-init nil nil))))
 '(global-fci-mode nil)
 '(js2-basic-offset 2)
 '(js2-global-externs (quote ("require")))
 '(js2-highlight-level 3)
 '(package-archives
   (quote
    (("melpa" . "http://melpa.milkbox.net/packages/")
     ("elpa" . "http://elpa.gnu.org/packages/"))))
 '(puppet-include-indent 2)
 '(require-final-newline t)
 '(terraform-indent-level 2)
 '(tidy-shell-command "/usr/local/bin/tidy --tidy-mark false -indent")
 '(web-mode-code-indent-offset 2)
 '(web-mode-markup-indent-offset 2))
;;(add-hook 'find-file-hook 'flymake-find-file-hook)
 '(require-final-newline t)
 '(terraform-indent-level 2))
(add-hook 'find-file-hook 'flymake-find-file-hook)

;;; Electric Pairs
(add-hook 'python-mode-hook
     (lambda ()
      (define-key python-mode-map "\"" 'electric-pair)
      (define-key python-mode-map "\'" 'electric-pair)
      (define-key python-mode-map "(" 'electric-pair)
      (define-key python-mode-map "[" 'electric-pair)
      (define-key python-mode-map "{" 'electric-pair)))
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

;; Path configuration from shell
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(if window-system (set-exec-path-from-shell-PATH))
(setenv "PATH" (concat (getenv "PATH") ":/sw/bin"))

(setq exec-path (append exec-path '("/sw/bin")))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((t (:background "yellow" :foreground "black" :weight bold))))
 '(flymake-warnline ((((class color)) (:background "yellow")))))

;;; Golang stuff
(defun go-mode-setup ()
  ;; gofmt all go code - use goimports though
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  ;; Bind M-. to jump to definition of go code at point
  (local-set-key (kbd "M-.") 'godef-jump)
  ;; C-c C-c for compilation + testing
  (setq compile-command "go vet && go test -v && go build && godep save ./...")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  ;; Use tabs of width 4
  (setq tab-width 4)
  ;; load go-oracle
  (load-file (concat (getenv "GOPATH") "/src/golang.org/x/tools/cmd/oracle/oracle.el"))
  )

;; Use flymake for go!
(add-to-list 'load-path (concat (getenv "GOPATH") "/src/github.com/dougm/goflymake"))
(setq exec-path (append exec-path (list (expand-file-name (concat (getenv "GOPATH") "/bin")))))

(require 'go-flycheck)
(add-hook 'go-mode-hook 'go-mode-setup)
(require 'server)
(unless (server-running-p)
    (server-start))
(put 'narrow-to-region 'disabled nil)

;; Web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; JS2 mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'js2-mode)

;; Use nasm-mode because it provides better x86 formatting
(require 'nasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm\\'" . nasm-mode))
(require 'ld-mode "/Users/spencer/go/src/github.com/spenczar/ld-mode/ld-mode.el")
;; protobuf should have 2-space indentation
(defconst my-protobuf-style
  '((c-basic-offset . 2)
    (indent-tabs-mode . t)))

(add-hook 'protobuf-mode-hook
          (lambda () (c-add-style "my-style" my-protobuf-style t)))

(provide 'init.el)
;;; init.el ends here

