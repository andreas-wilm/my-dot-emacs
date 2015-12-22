;; emacs 24 only

;; ELPA
;; http://emacswiki.org/emacs/ELPA
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")))
(package-initialize)


;; http://www.emacswiki.org/emacs/ShowParenMode
;;
(show-paren-mode t)
(setq show-paren-delay 0)


;; http://emacswiki.org/emacs/InteractivelyDoThings
;;
(require 'ido)
(ido-mode t)

(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))


;; default tab behaviour
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)


;;  Numbering
;;
(line-number-mode t)
(column-number-mode t)


;; lines
;;
(setq-default truncate-lines t)
;; make sure your text files end in a newline
;; (setq require-final-newline 't)
;; Or let Emacs ask about any time it is needed
(setq require-final-newline 'query)


;; python
(load-file "~/.emacs.python.el")

;; http://www.emacswiki.org/cgi-bin/emacs-en/QuickYes
(defalias 'yes-or-no-p 'y-or-n-p)

(require 'hungry-delete)
(global-set-key (kbd "C-c C-d") 'hungry-delete-forward)


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

