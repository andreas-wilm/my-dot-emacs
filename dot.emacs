;; -*- mode: lisp -*-
;;
;; NOTE: tested on Emacs 24 only
;;


;; startup
(setq debug-on-error t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
;; non-elpa libraries should go here
(add-to-list 'load-path "~/.emacs.d/lisp")


;; ELPA
;; http://emacswiki.org/emacs/ELPA
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
(package-initialize)


;; http://www.emacswiki.org/emacs/ShowParenMode
(show-paren-mode t)
(setq show-paren-delay 0)

;; http://emacswiki.org/emacs/InteractivelyDoThings
(require 'ido)
(ido-mode t)
;;?  (setq ido-enable-flex-matching t); fuzzy matching
;;?  (setq ido-everywhere t)

;; markdown
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))


;; http://www.emacswiki.org/emacs/insert-time-string.el
(require 'insert-time-string)
(setq insert-time-string-default-format "iso-8601")


;; default tab behaviour
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)


;; numbering
(line-number-mode t)
(column-number-mode t)


;; line handling
(setq-default truncate-lines t)
;; make sure your text files end in a newline (setq
;; require-final-newline 't) or let Emacs ask about any time it is
;; needed
(setq require-final-newline 'query)


;; python
(load-file "~/.emacs.python.el")


;; http://www.emacswiki.org/cgi-bin/emacs-en/QuickYes
(defalias 'yes-or-no-p 'y-or-n-p)


;; hungry-delete
(require 'hungry-delete)
(global-set-key (kbd "C-c C-d") 'hungry-delete-forward)


;; scrolling
;; http://www.emacswiki.org/cgi-bin/wiki/SmoothScrolling
(setq scroll-step 1
      scroll-conservatively 10000)


;; http://auto-complete.org/
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(ac-config-default)
(ac-flyspell-workaround)
;; If you are being annoyed with displaying completion menu, you can disable
;; automatic starting completion by setting ac-auto-start to nil.
;; (setq ac-auto-start nil)
;; Enable auto-complete-mode automatically for specific modes
;; (add-to-list 'ac-modes 'brandnew-mode)


;; http://www.emacswiki.org/emacs/MidnightMode
;; Midnight mode is a package by SamSteingold that comes with Emacs for running configured actions at every “midnight”.
;; By default, the ‘midnight-hook’ is configured to just run the CleanBufferList command.
(require 'midnight)
(midnight-delay-set 'midnight-delay "11:59am")


;; http://www.emacswiki.org/emacs/RecentFiles
(require 'recentf)
(progn
  (setq recentf-menu-path '("File"))
  ;; when using trampmode with recentf.el, it's advisable to turn
  ;; off the cleanup feature of recentf
  (setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
  (recentf-mode t))


;; uniquify
;; show path info in buffers with otherwise identical filenames
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)


;; window-system specifics
(if window-system
    (progn
      (message "Setting window-system specific stuff")
      (server-start)

      (global-unset-key "\C-z"); iconify-or-deiconify-frame (C-x C-z)

      ;; del genuinley deletes region, ie it's not put on the kill ring
      (delete-selection-mode t)

      (tool-bar-mode -1)

      (message "Setting up font")
      (condition-case nil
          (set-face-attribute 'default nil :font "Inconsolata-13:weight=normal")
          (error (message "Couldn't load Inconsolata")))

      ;; https://github.com/juba/color-theme-tangotango via MELPA
      (load-theme 'tangotango t)
   ))


;; MacOSX specifics
;;
;; Inspired by http://xahlee.org/emacs/xah_emacs_mac.el
;;
;; OS X Window System
(if (string-equal system-type "darwin")
  (progn
    (message "Customising for Darwin")
    ; delete char on external keyboard (kp) is bound to
    ; backward-delete-char-untabify instead of delete-char on Mac Os X.
    (global-set-key [kp-delete] 'delete-char)
    ; Needed on MacOS x for mc-gpg to find gpg
    ; FIXME Why is this not set by environment?
    ; delete next line and you get: *ERROR*: gpg could not be found
    (setenv "PATH" (concat (getenv "PATH") ":/opt/local/bin"))
    ; delete next line and you get: *ERROR*: Searching for program: No such file or directory, gpg
    (setq exec-path (append exec-path '("/opt/local/bin")))
    (if (eq window-system 'ns); Not 'mac!
        (progn
          (message "Customising for OS X window-system")
          ;;(setq mac-command-modifier 'meta)
          ;;(setq mac-option-modifier 'hyper)
          ;; the following replaces the two lines above
          ;; see also http://lojic.com/blog/2010/03/17/switching-from-carbonemacs-to-emacs-app/
          (setq ns-command-modifier 'meta)))))
;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
