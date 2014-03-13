;;
;; emacs init.el
;; Based on emacs kicker --- kick start emacs setup (Copyright (C) 2010 Dimitri Fontaine)
;;

;; jlc: add melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

;; common lisp goodies (loop)
(require 'cl)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.

;; set local recipes
(setq
 el-get-sources
 '(;;(:name buffer-move			; have to add your own keys
	 ;; :after (lambda ()
		;;   (global-set-key (kbd "<C-S-up>")     'buf-move-up)
		;;   (global-set-key (kbd "<C-S-down>")   'buf-move-down)
		;;   (global-set-key (kbd "<C-S-left>")   'buf-move-left)
		;;   (global-set-key (kbd "<C-S-right>")  'buf-move-right)))

   (:name smex				; a better (ido like) M-x
	  :after (progn
		   (setq smex-save-file "~/.emacs.d/.smex-items")
		   (global-set-key (kbd "M-x") 'smex)
		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

   (:name magit				; git meet emacs, and a binding
	  :after (progn
		   ;;(global-set-key (kbd "C-x C-z") 'magit-status)))
     ))

   ;; (:name goto-last-change		; move pointer back to last change
	 ;;  :after (lambda ()
	 ;;	   ;; when using AZERTY keyboard, consider C-x C-_
		;;   (global-set-key (kbd "C-x C-/") 'goto-last-change)))

   (:name helm
    :after (progn
      (require 'helm-config)
      (global-set-key (kbd "C-c h") 'helm-mini)
      (global-set-key (kbd "C-c ,") 'helm-cmd-t)
      (helm-mode 1) ;; helm for package install and others
   ))

   (:name projectile
    :after (progn
      (projectile-global-mode)
      (setq projectile-completion-system 'grizzl)
   ))

   (:name auto-complete
    :after (progn
      (require 'auto-complete-config)
      (add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/dict")

      (set-default 'ac-sources
                   '(ac-source-abbrev
                     ac-source-dictionary
                     ac-source-yasnippet
                     ac-source-words-in-buffer
                     ac-source-words-in-same-mode-buffers
                     ac-source-semantic))

      (ac-config-default)

      (dolist (m '(c-mode c++-mode java-mode css-mode javascript-mode))
        (add-to-list 'ac-modes m))

      (global-auto-complete-mode t)
   ))

   (:name evil
    :before (progn
      ; try to avoid delay before interpret esc
      (setq evil-esc-delay 0.0)
    )
    :after (progn
      ; enable scroll-up
      (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

      ;;; C-g as general purpose escape key sequence.
      ;;;
      (defun my-esc (prompt)
        "Functionality for escaping generally.  Includes exiting Evil insert state and C-g binding. "
        (cond
          ;; If we're in one of the Evil states that defines [escape] key, return [escape] so as
          ;; Key Lookup will use it.
          ((or (evil-insert-state-p) (evil-normal-state-p) (evil-replace-state-p) (evil-visual-state-p)) [escape])
          ;; This is the best way I could infer for now to have C-c work during evil-read-key.
          ;; Note: As long as I return [escape] in normal-state, I don't need this.
          ;;((eq overriding-terminal-local-map evil-read-key-map) (keyboard-quit) (kbd ""))
          (t (kbd "C-g"))))
      (define-key key-translation-map (kbd "C-g") 'my-esc)
      ;; Works around the fact that Evil uses read-event directly when in operator state, which
      ;; doesn't use the key-translation-map.
      (define-key evil-operator-state-map (kbd "C-g") 'keyboard-quit)

      ;; reenable great indent-region feature (indent selected region)
      (global-set-key (kbd "C-TAB") 'indent-region)

      (evil-mode 1)
   ))
    
   (:name flycheck
    :after (progn
      (add-hook 'after-init-hook #'global-flycheck-mode)
   ))
    
 ))

;; now set our own packages
(setq
 my:el-get-packages
 '(el-get				; el-get is self-hosting
   switch-window			; takes over C-x o
   color-theme		                ; nice looking emacs
   color-theme-solarized	                ; check out color-theme-solarized
   yasnippet          ; powerful snippet mode
   grizzl
   scala-mode2
   ensime
   coffee-mode
   less-css-mode ; recipe copied from https://github.com/clear-code/emacs.d/blob/master/config/el-get/recipes/less-css-mode.rcp
   ))

;; default packages from dimitri (jlc)
   ;;escreen            			; screen for emacs, C-\ C-h
   ;;php-mode-improved			; if you're into php...
   ;;zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding => should be replaced by emmet (emmet.io)
 
;;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;
;; jlc: not used
;;(when (el-get-executable-find "cvs")
;;  (add-to-list 'my:el-get-packages 'emacs-goodies-el)) ; the debian addons for emacs

;; jlc: not used
;; (when (el-get-executable-find "svn")
;;  (loop for p in '(psvn    		; M-x svn-status
;;		   yasnippet		; powerful snippet mode
;;		   )
;;	do (add-to-list 'my:el-get-packages p)))

(setq my:el-get-packages
      (append
       my:el-get-packages
       (loop for src in el-get-sources collect (el-get-source-name src))))

;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)

;; on to the visual settings
(setq inhibit-startup-message t)  ; no startup message
(setq inhibit-splash-screen t)		; no splash screen, thanks
(line-number-mode 1)			; have line numbers and
(column-number-mode 1)			; column numbers in the mode line

;; turn off tool-bar, scroll-bar, menu-bar
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))
(menu-bar-mode -1)     ; no menu bar

;; choose your own fonts, in a system dependant way
(if (string-match "apple-darwin" system-configuration)
    (set-face-font 'default "Monaco-13")
  (set-face-font 'default "Monospace-10"))

(global-hl-line-mode)			; highlight current line
(global-linum-mode 1)			; add line numbers on the left

;; avoid compiz manager rendering bugs
(add-to-list 'default-frame-alist '(alpha . 100))

;; copy/paste with C-c and C-v and C-x, check out C-RET too
(cua-mode)

;; under mac
(when (string-match "apple-darwin" system-configuration)
  (setq mac-allow-anti-aliasing t)
  ; have Command as Meta and keep Option for localized input
  ;(setq mac-command-modifier 'meta)
  ;(setq mac-option-modifier 'none)
  )

;; Use the clipboard, pretty please, so that copy/paste "works"
(setq x-select-enable-clipboard t)

;; Navigate windows with M-<arrows>
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

; winner-mode provides C-<left> to get back to previous window layout
(winner-mode 1)

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)

;; M-x shell is a nice shell interface to use, let's make it colorful.  If
;; you need a terminal emulator rather than just a shell, consider M-x term
;; instead.
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; If you do use M-x term, you will notice there's line mode that acts like
;; emacs buffers, and there's the default char mode that will send your
;; input char-by-char, so that curses application see each of your key
;; strokes.
;;
;; The default way to toggle between them is C-c C-j and C-c C-k, let's
;; better use just one key to do the same.
(require 'term)
(define-key term-raw-map  (kbd "C-'") 'term-line-mode)
(define-key term-mode-map (kbd "C-'") 'term-char-mode)

;; Have C-y act as usual in term-mode, to avoid C-' C-y C-'
;; Well the real default would be C-c C-j C-y C-c C-k.
(define-key term-raw-map  (kbd "C-y") 'term-paste)

;; use ido for minibuffer completion
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)

;; default key to switch buffer is C-x b, but that's not easy enough
;;
;; when you do that, to kill emacs either close its frame from the window
;; manager or do M-x kill-emacs.  Don't need a nice shortcut for a once a
;; week (or day) action.
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-x C-c") 'ido-switch-buffer)
(global-set-key (kbd "C-x B") 'ibuffer)

;; C-x C-j opens dired with the cursor right on the file you're editing
(require 'dired-x)

;; full screen
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)

;; -- end of dimitri's kick-starter

;; theme
(load-theme 'solarized-dark t)

;; line numbering
(setq linum-format "%4d ")

;; locate on macosx
(setq locate-command "mdfind")

;; scroll-preserve-screen-position
(setq scroll-preserve-screen-position t)

;; uniquify (buffers' names will be prefixed with directory names)
(require 'uniquify)
  (setq uniquify-buffer-name-style 'forward)

;; saveplace (save location when kill a buffer and returns to it next time)
(require 'saveplace)
  (setq-default save-place t)

;; show matching parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;; save backup in user directory (.emacs.d)
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                                "backups"))))

;; auto-refresh buffers when files have changed on disk
(global-auto-revert-mode t)

;; -- indentations
;; change html indentation
(add-hook 'html-mode-hook
  (lambda ()
    (setq sgml-basic-offset 2)))

(add-hook 'nxml-mode-hook
  (lambda ()
    (setq tab-width 4)
    (setq nxml-child-indent tab-width)
    (setq nxml-outline-child-indent tab-width)))

(add-hook 'css-mode-hook
  (lambda ()
    (setq tab-width 4)))

(add-hook 'js-mode-hook
  (lambda ()
    (setq tab-width 2)))

(add-hook 'coffee-mode-hook
  (lambda ()
    (setq tab-width 2)))

;; tab width
(setq tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;; force use of spaces instead of tab characters
(setq-default indent-tabs-mode nil)

