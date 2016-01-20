;; Initialization
(eval-when-compile
  (add-to-list 'load-path "~/.emacs.d/use-package/")
  (require 'use-package)
  (require 'bind-key)
  (require 'package)
  (package-initialize)
)

;; OS-dependent settings go here
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
    )
  )

;;; Navigation
;; Enable mouse support if in a terminal
(unless window-system
  (use-package mouse
    :config
    (global-set-key [mouse-4] '(lambda ()
				 (interactive)
				 (scroll-down 1)))
    (global-set-key [mouse-5] '(lambda ()
				 (interactive)
				 (scroll-up 1)))
    (xterm-mouse-mode t)
    (defun track-mouse (e))
    (setq mouse-sel-mode t)))

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

;;; Hide ~ files in directories
(require 'dired-x)
(setq-default dired-omit-files-p t)

;;; Column indication
;; make column number mode the default
(setq column-number-mode t)t

;;; I hate tabs.
(setq-default indent-tabs-mode nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(asm-comment-char 47)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(dired-listing-switches "-alh")
 '(dired-omit-files "^#\\|^\\.$\\$")
 '(fci-rule-color "#073642")
 '(fill-column 79)
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
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-global-externs (quote ("require")))
 '(js2-highlight-level 3)
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
 '(terraform-indent-level 2)
 '(tidy-shell-command "/usr/local/bin/tidy --tidy-mark false -indent")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#ff7f00")
     (60 . "#ffbf00")
     (80 . "#b58900")
     (100 . "#ffff00")
     (120 . "#ffff00")
     (140 . "#ffff00")
     (160 . "#ffff00")
     (180 . "#859900")
     (200 . "#aaff55")
     (220 . "#7fff7f")
     (240 . "#55ffaa")
     (260 . "#2affd4")
     (280 . "#2aa198")
     (300 . "#00ffff")
     (320 . "#00ffff")
     (340 . "#00ffff")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(web-mode-code-indent-offset 2)
 '(web-mode-markup-indent-offset 2)
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
  (add-hook 'after-init-hook #'global-flycheck-mode))

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
 '(flymake-errline ((((class color)) (:background "red"))))
 '(flymake-warnline ((((class color)) (:background "yellow")))))

;;; Golang stuff

(use-package go-mode
  :mode "\\.go\\'"
  :ensure t
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

  ;; Use flymake for go!
  (add-to-list 'load-path (concat (getenv "GOPATH") "/src/github.com/dougm/goflymake"))
  (require 'go-flycheck)
  (setq exec-path (append exec-path (list (expand-file-name (concat (getenv "GOPATH") "/bin")))))
)

(put 'narrow-to-region 'disabled nil)

;; Web-mode
(use-package web-mode
  :mode ("\\.html\\'" "\\.mustache\\'")
  :ensure t
  :config
  (flycheck-add-mode 'javascript-eslint 'web-mode)
)

;; JS2 mode
(use-package js2-mode
  :mode "\\.js$"
  :ensure t
  :config
  (flycheck-add-mode 'javascript-eslint 'js2-mode))

;; Typescript mode
(use-package typescript-mode
  :mode "\\.ts$"
  :ensure t)

;; Use nasm-mode because it provides better x86 formatting
(use-package nasm-mode
  :mode "\\.asm"
  :ensure t)

;; Color Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs/emacs-color-theme-solarized")
(load-theme 'solarized t)

;;(require 'ld-mode "/Users/spencer/go/src/github.com/spenczar/ld-mode/ld-mode.el")
(provide 'init.el)
;;; init.el ends here
