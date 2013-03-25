;;; 0_init.el --- initialize script for setting up personal environment.
;;
;; Copyright © 2013 plasma
;;
;; Author: plasma chen <plasmaball@gmail.com>
;; URL:
;; Version: 0.0.1
;; Keywords:
;;

;;; Commentary:

;;; Code:

;; Disable flyspell-mode.  Provided by Prelude by default, and quite annoying.
(setq prelude-flyspell nil)

;;; setting up environment for different os
(cond ((eq system-type 'darwin)
       (progn (add-to-list 'exec-path (expand-file-name "/opt/local/bin") t)
              (set-variable 'mac-command-modifier 'meta)
 )))

;;; Package management
;; (require 'package)

;; ;; package repo settings
;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; ;; helpers for package management
;; (defun install-package-if-needed (name)
;;   "Check and install specified package named NAME.
;; NAME should be the name of one of the available packages in an archive in `package-archives`.
;; "
;;   (unless (package-installed-p name)
;;     (package-install name))
;;   )

;; ;; check and install required packages
;; (install-package-if-needed 'color-theme)

(prelude-ensure-module-deps '(color-theme
                              zencoding-mode
                              w3m
                              ;; required by objc
                              auto-complete
                              etags-table
                              ))

;;; keybindings
(global-set-key "\M- " 'set-mark-command)
(global-set-key "\C-cg" 'goto-line)

;;; 0_init ends here
