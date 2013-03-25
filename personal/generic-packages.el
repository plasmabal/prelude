;;; generic-packages.el --- setting up color-theme mode
;;
;; Copyright © 2013 plasma
;;
;; Author: plasma chen <plasmaball@gmail.com>
;; URL:
;; Version: 0.0.1
;; Keywords:
;;

;;; Commentary:

;; This script sets up generic packages

;;; Code:

;; preference
(tool-bar-mode -1)                      ; No tool bar
(put 'narrow-to-region 'disabled nil)   ; Allow narrowing
(setq-default indent-tabs-mode nil)     ; Use space, no tab
(column-number-mode 1)                  ; Display colunm number

;; color-theme
(disable-theme 'zenburn)
(require 'color-theme)
(color-theme-initialize)
(color-theme-charcoal-black)

;; Ibuffer
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("perl" (mode . cperl-mode))
               ("erc" (mode . erc-mode))
               ("planner" (or
                           (name . "^\\*Calendar\\*$")
                           (name . "^diary$")
                           (mode . muse-mode)))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")
                         (name . "^.emacs$")
                         (name . "^\\*Gnu Emacs\\*$")
                         (mode . help-mode)
                         (name . "^\\*Completions\\*$")
                         ))
               ("xcode" (or
                         (mode . objc-mode)))
               ("gnus" (or
                        (mode . message-mode)
                        (mode . bbdb-mode)
                        (mode . mail-mode)
                        (mode . gnus-group-mode)
                        (mode . gnus-summary-mode)
                        (mode . gnus-article-mode)
                        (name . "^\\.bbdb$")
                        (name . "^\\.newsrc-dribble")))))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; w3m mode
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(setq w3m-use-cookies t)
(setq w3m-default-display-inline-images t)

;; windows move
(defun windmove-c-x-keybindings ()
  "Set up default keybindings for `windmove'."
  (interactive)
  (global-set-key (kbd "C-x <left>")  'windmove-left)
  (global-set-key (kbd "C-x <up>")    'windmove-up)
  (global-set-key (kbd "C-x <right>") 'windmove-right)
  (global-set-key (kbd "C-x <down>")  'windmove-down))
(if (or (eq window-system 'w32)
        (eq window-system 'ns))
    (set-scroll-bar-mode 'left)            ; Put scroll bar at left side
)
(when (fboundp 'windmove-default-keybindings)
  (windmove-c-x-keybindings))       ; Easy for window nav. Shift-ArrowKeys

;; zencoding
(require 'zencoding-mode)

;;; generic-packages ends here
