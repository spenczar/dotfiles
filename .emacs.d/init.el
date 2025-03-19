;;;;;;;;;;;;;;;;;;;;;;
;;; Package Management
;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Use Quelpa to install packaged from source, and do it via use-package.

(unless (package-installed-p 'quelpa)
  (package-initialize)
  (package-refresh-contents)
  (package-install 'quelpa))

(unless (package-installed-p 'quelpa-use-package)
  (quelpa
   '(quelpa-use-package
     :fetcher git
     :url "https://github.com/quelpa/quelpa-use-package.git")))
(require 'quelpa-use-package)
(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-ensure-function 'quelpa)

;;;;;;;;;;;;;;;
;;; UI features
;;;;;;;;;;;;;;;
(use-package vertico
  :init (vertico-mode))

(use-package company)

(use-package marginalia
  :init (marginalia-mode))

(use-package consult
  :bind (
	 ("C-x b" . consult-buffer)
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
	 ("M-s r" . consult-ripgrep)
	 ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
	 ("M-s d" . consult-find)))

(use-package savehist
  :init (savehist-mode))

(use-package rg)

(use-package highlight-indentation)

(use-package visual-fill-column)

(use-package solarized-theme
  :config (load-theme 'solarized-selenized-light t))

;; Hide uninteresting files by default
(add-hook 'dired-mode-hook
	  (lambda ()
	    (dired-omit-mode 1)))


(setq frame-background-mode 'dark)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)

;;;;;;;;;;;;;;;;;;;;;;;;
;;; Generic coding tools
;;;;;;;;;;;;;;;;;;;;;;;;

(use-package gnu-elpa-keyring-update)
(use-package lsp-mode)


(use-package magit)

(use-package projectile)

(use-package xref
  :init
  (setq xref-search-program 'ripgrep))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;;;;;;;;;;;
;;; Copilot
;;;;;;;;;;;
(defvar swn/no-copilot-modes '(term-mode
			       vterm-mode
			       comint-mode
			       dired-mode
			       dired-mode-hook
			       debugger-mode
			       compilation-mode
			       compilation-mode-hook)
  "modes which should not be enabled for copilot")

(defun swn/copilot-disable-predicate ()
  "predicate to disable copilot"
  (member major-mode swn/no-copilot-modes))

(use-package s)

;; (use-package copilot
;;   :quelpa (copilot.el :fetcher github
;;                       :repo "copilot-emacs/copilot.el"
;;                       :files ("dist" "*.el"))
;;   :hook prog-mode
;;   :bind
;;   (("M-n" . copilot-accept-completion-by-line)
;;   ("M-TAB" . copilot-accept-completion-by-word)  
;;   ("M-RET" . copilot-accept-completion))
;;   :config
;;   (add-to-list 'copilot-disable-predicates 'swn/copilot-disable-predicate))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Language-specific behavior
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package go-mode
  :config
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package rust-mode)

;;; Python
(use-package python)
(use-package blacken)
(use-package python-docstring)

(use-package pyvenv
  :config
  (pyvenv-mode))

;;; C++
(use-package clang-format
  :config
  (setq clang-format-style-option "file"))

(use-package irony
  :hook (c++-mode . irony-mode))

(use-package rtags)

(use-package cuda-mode)

;;; Misc languages
(use-package zig-mode)
(use-package dockerfile-mode)
(use-package yaml-mode)
(use-package json-mode)
(use-package markdown-mode
  :config
  (setq markdown-fontify-code-blocks-natively t)
  (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
	      ("M-n" . nil)
	      ("M-RET" . nil)
	      ("M-TAB" . nil)))
(use-package typescript-mode)

(use-package cmake-mode)


(defun swn-get-credentials (host)
  (let ((creds (auth-source-search :host host)))
    (if creds
        (auth-info-password (car creds))
      (warn "No credentials found for host: %s" host)
      nil)))

(require 'ert)

(ert-deftest test-swn-get-credentials ()
  (let ((host "test-host")
        (test-credentials '((:host "test-host" :user "test-user" :secret "test-password"))))
    ;; Mock auth-source-search to return test-credentials    
    (flet ((auth-source-search (&rest args) test-credentials))
      (let ((password (swn-get-credentials host)))
        (should (equal password "test-password"))))))

(use-package gptel
  :quelpa (gptel :fetcher github
                 :repo "karthink/gptel")
  :config
  (setq gptel-api-key (swn-get-credentials "openai-api")))

(provide 'init.el)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-omit-files "\\`[.]?#\\'")
 '(package-selected-packages
   '(cython-mode gptel company lsp-mode gnu-elpa-keyring-update lv ht f zig-mode reformatter rtags irony cuda-mode typescript-mode markdown-mode json-mode json-snatcher yaml-mode dockerfile-mode pyvenv python-docstring blacken rust-mode visual-fill-column vertico solarized-theme s rg quelpa-use-package projectile marginalia magit highlight-indentation go-mode editorconfig copilot.el consult)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
