(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(require 'windmove)
(global-set-key (kbd "s-J")  'windmove-left)
(global-set-key (kbd "s-L") 'windmove-right)
(global-set-key (kbd "s-I")    'windmove-up)
(global-set-key (kbd "s-K")  'windmove-down)

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

;;; Color Theme
(require 'color-theme)
(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (select-frame frame)
                (load-theme 'solarized-dark t)))
  (load-theme 'solarized-dark t))
(color-theme-initialize)
(color-theme-solarized-dark)

;;; Column indication
;; make column number mode the default
(setq column-number-mode t)t
(setq fci-rule-column 79)
(require 'fill-column-indicator)

;;; I hate tabs.
(setq-default indent-tabs-mode nil)

;;; Use magit!
(require 'magit)
(global-set-key (kbd "C-c g") 'magit-status)

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "/usr/local/bin/pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init))
  (custom-set-faces
   '(flymake-errline ((((class color)) (:background "red"))))
   '(flymake-warnline ((((class color)) (:background "yellow")))))

  (global-set-key (kbd "M-n") 'flymake-goto-next-error)
  (global-set-key (kbd "M-p") 'flymake-goto-prev-error)
  )

(custom-set-variables
 '(help-at-pt-timer-delay 0.0)
      '(help-at-pt-display-when-idle '(flymake-overlay)))
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-listing-switches "-alh")
 '(dired-omit-files "^#\\|^\\.$\\$")
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
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-display 0.9)
 '(js-indent-level 2)
 '(require-final-newline t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:background "red"))))
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
(require 'go-flymake)
(add-hook 'go-mode-hook 'go-mode-setup)
(require 'server)
(unless (server-running-p)
    (server-start))
(put 'narrow-to-region 'disabled nil)

