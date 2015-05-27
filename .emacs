(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(add-to-list 'load-path "~/.emacs.d/magit-1.2.0")
(add-to-list 'load-path "~/.emacs.d/mustache-mode.el")
;;; yasnippet
(require 'yasnippet)
(yas-reload-all)
(add-hook 'python-mode-hook
          (lambda ()
            (yas-minor-mode)))

(add-hook 'html-mode-hook
          (lambda ()
            (yas-minor-mode)))

(add-hook 'js-mode-hook
          (lambda ()
            (yas-minor-mode)))

(add-hook 'css-mode-hook
          (lambda ()
            (yas-minor-mode)))

;;; Ack
(require 'full-ack)
(add-to-list 'load-path "/path/to/full-ack")
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;;; Tramp
(require 'tramp)

;;; Magit
(require 'magit)
(global-set-key (kbd "C-c g") 'magit-status)

;;; unique buffer names
(require 'uniquify)

;;; window moves
(require 'windmove)
(global-set-key (kbd "s-J")  'windmove-left)
(global-set-key (kbd "s-L") 'windmove-right)
(global-set-key (kbd "s-I")    'windmove-up)
(global-set-key (kbd "s-K")  'windmove-down)

;;; Some key resets
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-k") 'kill-region)

;; OSX Fullscreen
(require 'maxframe)
(defvar maxframe-maximized-p nil "maxframe is in fullscreen mode")
(defun toggle-maxframe ()
  "Toggle maximized frame"
  (interactive)
  (setq maxframe-maximized-p (not maxframe-maximized-p))
  (cond (maxframe-maximized-p (maximize-frame))
        (t (restore-frame))))
(define-key global-map [(C-return)] 'toggle-maxframe)

;; Hotkey for open-a-terminal
(require 'term)
(defun open-terminal()

  "If the current buffer is:
     1) a running ansi-term named *ansi-term*, rename it.
     2) a stopped ansi-term, kill it and create a new one.
     3) a non ansi-term, go to an already running ansi-term
        or start a new one while killing a defunt one"
  (interactive)

  (defun pop-new-ansi-term (new-buffer-name program &rest switches)
    "Start an ANSI terminal buffer and pop to it (rather than switching)"
    (interactive (list (read-from-minibuffer "Run program: "
					   (or explicit-shell-file-name
					       (getenv "ESHELL")
					       (getenv "SHELL")
					       "/bin/sh"))))

    (setq term-ansi-buffer-name
          (if new-buffer-name
              new-buffer-name
            (if term-ansi-buffer-base-name
                (if (eq term-ansi-buffer-base-name t)
                    (file-name-nondirectory program)
                  term-ansi-buffer-base-name)
              "ansi-term")))

    (setq term-ansi-buffer-name (concat "*" term-ansi-buffer-name "*"))
    (setq term-ansi-buffer-name (generate-new-buffer-name term-ansi-buffer-name))
    (setq term-ansi-buffer-name (term-ansi-make-term term-ansi-buffer-name program))

    (set-buffer term-ansi-buffer-name)
    (term-mode)
    (term-char-mode)

    (term-set-escape-char ?\C-x)
    
    (pop-to-buffer term-ansi-buffer-name))

  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (term-cmd "~/.emacs.d/shell_command.sh")
        (term-switches "--login")
        (anon-term (get-buffer "*ansi-term*")))
    (if is-term
        (if is-running
            (if (string= "*ansi-term*" (buffer-name))
                (call-interactively 'rename-buffer)
              (if anon-term
                  (pop-to-buffer "*ansi-term*")
                (pop-new-ansi-term "ansi-term" term-cmd term-switches)))
          (pop-new-ansi-term term-cmd))
      (if anon-term
          (if (term-check-proc "*ansi-term*")
              (pop-to-buffer "*ansi-term*")
            (kill-buffer "*ansi-term*")
            (pop-new-ansi-term "ansi-term" term-cmd term-switches))
        (pop-new-ansi-term "ansi-term" term-cmd term-switches)))))

(global-set-key (kbd "s-t") 'open-terminal)

;;; Set PAGER and EDITOR so git doesn't complain: terminal is not fully functional
(setenv "PAGER" "cat")
(setenv "EDITOR" "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient")


;; Sort of silly, but yanking into ipython being run under ansi-term
;; is a pain.

(defun term-ipython-yank ()
  (interactive)
  (term-send-raw-string "%autoindent\r")
  (term-send-raw-string (car kill-ring))
  (term-send-raw-string "\r%autoindent\r"))

(global-set-key (kbd "s-p") 'term-ipython-yank)

(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

(defun kill-prev-linebreak() 
  ;; Merges this line at point w/ previous line
  (interactive)
  (beginning-of-line)
  (re-search-forward "[^[:space:]]")
  (backward-char)
  (setq end (point-marker))
  (previous-line)
  (end-of-line)
  (delete-region (point-marker) end)
  (insert ?\s))

(global-set-key (kbd "s-k") 'kill-prev-linebreak)

;;; Basic utility to reload this file's contents
(defun reload-emacs-file ()
  (interactive)
  (load-file "~/.emacs"))

;;; Custom large macros
(defun bigmacro-reload ()
  (interactive)
  (load-file "~/.emacs.d/bigmacros.el"))


;;; Color themes
(require 'color-theme)
(load "color-theme-tangotango")
(color-theme-initialize)
(color-theme-tangotango)
(if (>= emacs-major-version 23)
    (set-default-font "DejaVu Sans Mono-12")) ; .Xdefaults
(load "color-theme-buffer-local")

;;; Different color for terminal-like modes
(defun init-terminal-color-theme () 
  (color-theme-buffer-local 'color-theme-billw (current-buffer))
  (setq term-default-fg-color "cornsilk")
  (setq term-default-bg-color "black")
  )

(add-hook 'term-mode-hook 'init-terminal-color-theme)

;;; Column indication
;; make column number mode the default
(setq column-number-mode t)t
(setq fci-rule-column 79)
(require 'fill-column-indicator)


;;; I hate tabs.
(setq-default indent-tabs-mode nil)


;;; rsync up to zc local
(defcustom rsync-target "zclocal"
  "SSH identity of the target for rsync using C-c C-f"
  :type 'string
)

(defun rsync-to-zclocal ()
  (interactive)
  (defun parse-rsync-output (output)
    (setq slice-start (+ 9 (string-match "... done" output)))
    (setq slice-end (- (string-match "sent [1234567890]*" output) 2))
    (if (< slice-start slice-end)
        (replace-regexp-in-string "\n"
                                  ", "
                                  (substring output
                                             slice-start
                                             slice-end))
      ""))
  (message (concat "Performing rsync with " rsync-target "..."))
  (setq rsync-output
        (shell-command-to-string (concat "rsync --verbose --delete --compress --rsh=/usr/bin/ssh --recursive --times --perms --links --exclude '*git*' --exclude '*pyc' --exclude '*.*~' --exclude '.git' --exclude 'zerocater/bin' ~/Coding/ZeroCater/ " rsync-target ":/project/zerocater/current/ ")))
  (shell-command (concat "ssh " rsync-target " sudo service apache2 restart"))
  (message (concat "Done! Changed files: " (parse-rsync-output rsync-output)))

)
(global-set-key (kbd "C-c f") 'rsync-to-zclocal)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;        python        ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; pyflakes and flymake for automatic syntax checking

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ack-executable "/usr/local/bin/ack")
 '(column-number-mode t)
 '(haskell-mode-hook (quote (turn-on-haskell-indentation)))
 '(initial-buffer-choice "~/Coding/Zerocater/")
 '(mf-display-padding-height 130)
 '(org-capture-templates (quote (("i" "Hack Project Ideas" entry (file "~/org/hackideas.org") " " :empty-lines 1) ("n" "Notes" entry (file "~/org/notes.org") "") ("t" "New To-do" entry (file+headline "/Users/spenczar/gtd/gtd.org" "Tasks") "** TODO %^{Brief Description} %^g
%?
Added: %U") ("c" "New Calnedar Entry" entry (file+headline "/Users/spenczar/gtd/gtd.org" "Calendar") "** %^{Event Name} 
%?
SCHEDULED: %^{Date and Time}T"))))
 '(org-drawers (quote ("PROPERTIES" "CLOCK" "LOGBOOK" "RESULTS" "COMMENTS")))
 '(py-pychecker-command "~/.emacs.d/pychecker.sh")
 '(py-pychecker-command-args (quote ("")))
 '(python-check-command "~/.emacs.d/pychecker.sh")
 '(rsync-target "clean")
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))

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
  )

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


;;; Ipython
(require 'python-mode)
(setenv "PYTHONPATH" "/Library/Python/2.7/site-packages:/Library/Python/2.7/site-packages/PIL")
(defvar py-mode-map python-mode-map)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(setq ipython-command "/usr/local/bin/ipython")
(setq py-python-command "/usr/local/bin/ipython")
(require 'ipython)


;;; scheme stuff
;;; Always do syntax highlighting
(global-font-lock-mode 1)

;;; Also highlight parens
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(show-paren-mode 1)

;;; This is the binary name of my scheme implementation
(setq scheme-program-name "/usr/local/bin/scheme")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;         HTML         ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun flymake-html-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "tidy" (list local-file))))


(add-to-list 'flymake-allowed-file-name-masks
	     '("\\.html\\'" flymake-html-init)) 

(add-to-list 'flymake-err-line-patterns
	     '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
	      nil 1 2 4))
(put 'downcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-added ((t (:inherit diff-changed :foreground "Green"))))
 '(flymake-errline ((((class color)) (:background "red"))))
 '(flymake-warnline ((((class color)) (:background "yellow")))))

(require 'mustache-mode)

;;;;;;;;;;;;;;;;;;;;
;;; JavaScript   ;;;
;;;;;;;;;;;;;;;;;;;;
;; Add coffeescript
(require 'coffee-mode)
(require 'flymake-coffee)
(add-hook 'coffee-mode-hook 'flymake-coffee-load)

;; jslint
(defgroup flymake-jslint nil
  "Flymake checking of Javascript using jslint"
  :group 'programming
  :prefix "flymake-jslint-")

;;;###autoload
(defcustom flymake-jslint-detect-trailing-comma t
  "Whether or not to report warnings about trailing commas."
  :type 'boolean :group :flymake-jslint)

;;;###autoload
(defcustom flymake-jslint-command "/usr/local/bin/jsl"
  "Name (and optionally full path) of jslint executable."
  :type 'string :group 'flymake-jslint)

(defvar flymake-jslint-err-line-patterns
  '(("^\\(.+\\)\:\\([0-9]+\\)\: \\(SyntaxError\:.+\\)\:$" nil 2 nil 3)
    ("^\\(.+\\)(\\([0-9]+\\)): \\(SyntaxError:.+\\)$" nil 2 nil 3)
    ("^\\(.+\\)(\\([0-9]+\\)): \\(lint \\)?\\(warning:.+\\)$" nil 2 nil 4)))
(defvar flymake-jslint-trailing-comma-err-line-pattern
  '("^\\(.+\\)\:\\([0-9]+\\)\: strict \\(warning: trailing comma.+\\)\:$" nil 2 nil 3))

(defun flymake-jslint--create-temp-in-system-tempdir (file-name prefix)
  "Return a temporary file name into which flymake can save buffer contents.

This is tidier than `flymake-create-temp-inplace', and therefore
preferable when the checking doesn't depend on the file's exact
location."
  (make-temp-file (or prefix "flymake-jslint") nil ".js"))

(defun flymake-jslint-init ()
  "Construct a command that flymake can use to check javascript source."
  (list flymake-jslint-command (list "-process" (flymake-init-create-temp-buffer-copy
                                                 'flymake-jslint--create-temp-in-system-tempdir))))


;;;###autoload
(defun flymake-jslint-load ()
  "Configure flymake mode to check the current buffer's javascript syntax.

This function is designed to be called in `js-mode-hook' or
equivalent; it does not alter flymake's global configuration, so
function `flymake-mode' alone will not suffice."
  (interactive)
  (set (make-local-variable 'flymake-allowed-file-name-masks) '(("." flymake-jslint-init)))
  (set (make-local-variable 'flymake-err-line-patterns) flymake-jslint-err-line-patterns)
  (when flymake-jslint-detect-trailing-comma
    (add-to-list 'flymake-err-line-patterns
                 flymake-jslint-trailing-comma-err-line-pattern
                 t))
  (if (executable-find flymake-jslint-command)
      (flymake-mode t)
    (message "Not enabling flymake: jsl command not found")))

(add-hook 'js-mode-hook 'flymake-jslint-load)

(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)

;;;;;;;;;;;;;;;;;;;;
;;; Org Mode     ;;;
;;;;;;;;;;;;;;;;;;;;

;; Installation
(add-to-list 'load-path "~/.emacs.d/org-7.8.11/lisp/")
(add-to-list 'load-path "~/.emacs.d/org-7.8.11/contrib/lisp/")
(require 'org-install)
(require 'org) ;; maybe this line is redundant

;; Global org-mode commands
; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Notes
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

;; Disable flymake on tex generation
(delete '("\\.tex?\\'" flymake-tex-init) flymake-allowed-file-name-masks)

(put 'narrow-to-region 'disabled nil)

;; Haskell
(load "~/.emacs.d/haskell-mode/haskell-site-file.el")

