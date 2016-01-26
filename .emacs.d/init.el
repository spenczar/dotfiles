;; Initialization
(eval-when-compile
  (add-to-list 'load-path "~/.emacs.d/use-package/")
  (require 'use-package)
  (setq use-package-verbose t)
  (setq use-package-always-ensure t)
  (require 'bind-key)
  (require 'package)
  (setq package-archives
        '(("elpa" . "http://elpa.gnu.org/packages/")
          ("melpa" . "http://melpa.milkbox.net/packages/")
          ("marmalade" . "http://marmalade-repo.org/packages/")))
  (package-initialize))

;; Project navigation
(use-package projectile
  :config
  (projectile-global-mode 1)
  (setq projectile-enable-caching t
        projectile-require-project-root nil)
  (message "projectile hook hit"))

;;; OS-dependent settings go here
(if (string-equal system-type "darwin")
    (progn
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
      )
  (progn
    ;; On Linux, I use suckless terminal, which maps backspace to C-h;
    ;; C-M-h is thus what emacs receives when pressing
    ;; M-backspace. I'd like M-backspace to delete the previous word.
    (global-set-key (kbd "C-M-h") 'backward-kill-word)
    ;; Lets give a shot towards clipboard integration
    (setq
     x-select-enable-clipboard t
     x-select-enable-primary t
     save-interprogram-paste-before-kill t
     )

    )
  )

;;; Navigation

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
;;; No sleeping!
(global-unset-key (kbd "C-z"))

;;; Column indication
;; make column number mode the default
(setq column-number-mode t)

;;; Formatting
;; Avoid using tabs
(setq-default indent-tabs-mode nil)
;; Fill to 79 columns
(setq fill-column 79)
;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; Files should have a trailing newline.
(setq require-final-newline t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(asm-comment-char 47)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(flycheck-eslintrc (substitute-in-file-name "$HOME/.eslintrc"))
 '(frame-background-mode (quote dark))
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.0)
 '(help-at-pt-timer-display 0.9)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-archives
   (quote
    (("melpa" . "http://melpa.milkbox.net/packages/")
     ("elpa" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/"))))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(puppet-include-indent 2)
 '(require-final-newline t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tidy-shell-command "/usr/local/bin/tidy --tidy-mark false -indent")
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
;;(add-hook 'find-file-hook 'flymake-find-file-hook)

(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (set-face-attribute 'flycheck-error nil :background "red" :foreground "white"))

;; Path configuration from shell
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(if window-system (set-exec-path-from-shell-PATH))
(setenv "PATH" (concat (getenv "PATH") ":/sw/bin"))

(setq exec-path (append exec-path '("/sw/bin")))


;;; Golang stuff

(use-package go-mode
  :mode "\\.go\\'"
  :config
  ;; gofmt all go code - use goimports though
  (message "doing the config dance for go!")
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)

  (defun go-mode-settings ()
    (local-set-key (kbd "M-.") 'godef-jump)
    (setq compile-command "go vet && go test -v && go build")
    (setq tab-width 2)
    (define-key (current-local-map) "\C-c\C-c" 'compile))
  (add-hook 'go-mode-hook 'go-mode-settings)

  ;; Use tabs of width 4
  (setq tab-width 4)

  ;; Add $GOPATH/bin to exec-path
  (setenv "GOPATH" (expand-file-name "~/go"))
  (setq exec-path (append exec-path (list (expand-file-name (concat (getenv "GOPATH") "/bin")))))

  ;; Use flymake for go!
  (use-package "go-flycheck"
    :ensure nil
    :load-path (lambda() (concat (getenv "GOPATH") "/src/github.com/dougm/goflymake")))
  (add-hook 'go-mode-hook 'flycheck-mode)

  ;; Use go-projectile to improve the GOPATH lookup for godep'd packages
  (use-package "go-projectile"))

(put 'narrow-to-region 'disabled nil)

;; Web-mode
(use-package web-mode
  :mode ("\\.html\\'" "\\.mustache\\'")
  :bind ("C-c /" . web-mode-element-close)
  :config
  (setq web-mode-code-indent-offset 2
        web-mode-markup-indent-offset 2)
)

(use-package json-mode
  :mode "\\.json$")

;; JS2 mode
(use-package js2-mode
  :mode "\\.js$"
  :config
  ;; Two-space indentation.
  (setq js2-basic-offset 2)
  ;; Allow usage of 'require' as a global variable.
  (setq js2-global-externs '("require"))
  ;; Highlight ECMA builtin functions
  (setq js2-highlight-level 3))

;; Typescript mode
(use-package typescript-mode
  :mode "\\.ts$")

;; Use nasm-mode because it provides better x86 formatting
(use-package nasm-mode
  :mode "\\.asm")

(use-package terraform-mode
  :mode "\\.tf$"
  :config
  (setq terraform-indent-level 2))

;; Common settings for lisp languages.
(defun lisp-settings ()
  (show-paren-mode 1)

  (use-package rainbow-delimiters
    :config
    (rainbow-delimiters-mode))

  (use-package paredit
    :config
    (enable-paredit-mode))

  (turn-on-eldoc-mode))

(add-hook 'clojure-mode-hook 'lisp-settings)
(add-hook 'cider-mode-hook 'lisp-settings)
(add-hook 'eval-expression-minibuffer-setup-hook 'lisp-settings)
(add-hook 'emacs-lisp-mode-hook 'lisp-settings)
(add-hook 'ielm-mode-hook 'lisp-settings)
(add-hook 'lisp-mode-hook 'lisp-settings)
(add-hook 'lisp-interaction-mode-hook 'lisp-settings)
(add-hook 'scheme-mode-hook 'lisp-settings)

;;; Clojure
;; Clojure-mode
(use-package clojure-mode
  :mode (("\\.clj" . clojure-mode)
         ("\\.boot$" . clojure-mode)
         ("\\.cljs.*$" . clojure-mode)
         ("lein-env" . ruby-mode))
  :config
  ;; Extra font highlighting for clojure
  (use-package clojure-mode-extra-font-locking)

  ;; Integration with the clojure repl
  (use-package cider
    :config
    (setq
     cider-repl-pop-to-buffer-on-connect t
     cider-show-error-buffer t
     cider-auto-select-error-buffer t
     cider-repl-history-file "~/.cider-history"
     cider-repl-wrap-history t
     cider-stacktrace-frames-background-color "#FFFFFF"
     ))

  ;; Useful for working with camel-case tokens, like names of Java classes
  (add-hook 'clojure-mode-hook 'subword-mode)

  (add-hook 'clojure-mode-hook
            (lambda ()
              (setq inferior-lisp-program "lein repl"))))

;;; aya for better macros
(use-package auto-yasnippet
  :config
  (global-set-key (kbd "C-x {") #'aya-create)
  (global-set-key (kbd "C-x E") #'aya-expand))

(use-package protobuf-mode
  :mode "\\.proto$")

;;; Visual themes (these belong last)
;; Color Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
(load-theme 'solarized t)

;; no bell
(setq ring-bell-function 'ignore)

;;(require 'ld-mode "/Users/spencer/go/src/github.com/spenczar/ld-mode/ld-mode.el")
(provide 'init.el)
;;; init.el ends here
