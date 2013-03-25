;;; webdev.el --- setting up environment for web programming
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

(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
(autoload 'xml-mode "psgml" "Major mode to edit XML files." t)
(setq auto-mode-alist
      (append
       (list
        '("\\.html$" . sgml-mode)
        '("\\.xml$" . xml-mode)
        '("\\.sgml$" . sgml-mode))
       auto-mode-alist))

; got these from http://www.messengers-of-messiah.org/~csebold/emacs/dot_emacs.html
(setq-default sgml-set-face t)
(make-face 'sgml-comment-face)
(make-face 'sgml-doctype-face)
(make-face 'sgml-end-tag-face)
(make-face 'sgml-entity-face)
(make-face 'sgml-ignored-face)
(make-face 'sgml-ms-end-face)
(make-face 'sgml-ms-start-face)
(make-face 'sgml-pi-face)
(make-face 'sgml-sgml-face)
(make-face 'sgml-short-ref-face)
(make-face 'sgml-start-tag-face)
(setq sgml-indent-data t)

(set-face-foreground 'sgml-comment-face "indian red")
(set-face-foreground 'sgml-doctype-face "red")
(set-face-foreground 'sgml-end-tag-face "dark turquoise")
(set-face-foreground 'sgml-entity-face "magenta")
(set-face-foreground 'sgml-ignored-face "gray40")
(set-face-background 'sgml-ignored-face "gray60")
(set-face-foreground 'sgml-ms-end-face "green")
(set-face-foreground 'sgml-ms-start-face "yellow")
(set-face-foreground 'sgml-pi-face "green")
(set-face-foreground 'sgml-sgml-face "brown")
(set-face-foreground 'sgml-short-ref-face "deep sky blue")
(set-face-foreground 'sgml-start-tag-face "dark turquoise")

(setq-default sgml-markup-faces
              '((comment . sgml-comment-face)
                (doctype . sgml-doctype-face)
                (end-tag . sgml-end-tag-face)
                (entity . sgml-entity-face)
                (ignored . sgml-ignored-face)
                (ms-end . sgml-ms-end-face)
                (ms-start . sgml-ms-start-face)
                (pi . sgml-pi-face)
                (sgml . sgml-sgml-face)
                (short-ref . sgml-short-ref-face)
                (start-tag . sgml-start-tag-face)))

; don't automatically insert comments
(setq sgml-insert-missing-element-comment nil)

; automatically parse the dtd if you can
(setq sgml-auto-activate-dtd t)

; setting catalog file of sgml dtds
(if (eq system-type 'windows-nt)
    (setq sgml-catalog-files '("c:/plasma/lib/sgml-lib/catalog"))
  (setq sgml-catalog-files '("~/.emacs.d/personal/lib/DTD/catalog"))
  )
;; (setq sgml-custom-dtd
;;       '(("HTML 4.01" "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\">")
;;         ("XHTML 1.0" "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\">")
;;          )
;;       )
;;; from http://www.dzr-web.com/people/darren/projects/emacs-webdev/
;; Set up "DTD->Insert DTD" menu.

(setq sgml-custom-dtd
  '(
    ( "HTML 4.01 Strict"
      "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\"\n \"http://www.w3.org/TR/html4/strict.dtd\">"
      sgml-declaration "~/.emacs.d/personal/lib/DTD/html401/HTML4.decl"
      sgml-default-dtd-file "~/.emacs.d/personal/lib/DTD/html401/strict.ced"
      mode sgml-html )
    ( "HTML 4.01 Transitional"
      "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"\n \"http://www.w3.org/TR/html4/loose.dtd\">"
      sgml-declaration "~/.emacs.d/personal/lib/DTD/html401/HTML4.decl"
      sgml-default-dtd-file "~/.emacs.d/personal/lib/DTD/html401/loose.ced"
      mode sgml-html )
    ( "HTML 4.01 Frameset"
      "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\"\n \"http://www.w3.org/TR/html4/frameset.dtd\">"
      sgml-declaration "~/.emacs.d/personal/lib/DTD/html401/HTML4.decl"
      sgml-default-dtd-file "~/.emacs.d/personal/lib/DTD/html401/frameset.ced"
      mode sgml-html )
    ( "XHTML 1.0 Strict"
      "<?xml version=\"1.0\"?>\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">"
      sgml-default-dtd-file "~/.emacs.d/personal/lib/DTD/xhtml1/xhtml1-strict.ced"
      mode xml-html )
    ( "XHTML 1.0 Transitional"
      "<?xml version=\"1.0\"?>\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"
      sgml-default-dtd-file "~/.emacs.d/personal/lib/DTD/xhtml1/xhtml1-transitional.ced"
      mode xml-html )
    ( "XHTML 1.0 Frameset"
      "<?xml version=\"1.0\"?>\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Frameset//EN\"\n \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd\">"
      sgml-default-dtd-file "~/.emacs.d/personal/lib/DTD/xhtml1/xhtml1-frameset.ced"
      mode xml-html )
    ( "XHTML 1.1"
      "<?xml version=\"1.0\"?>\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\"\n \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">"
      sgml-default-dtd-file "~/.emacs.d/personal/lib/DTD/xhtml11/xhtml11.ced"
      mode xml-html )
  )
)

;; ecat support
;; (setq sgml-ecat-files
;;   (list
;;     (expand-file-name "~/lib/DTD/ecatalog")
;;   )
;; )

; some nice stuff in sgml mode (from http://www.snee.com/bob/sgmlfree/emcspsgm.html
(add-hook 'sgml-mode-hook               ; make all this stuff SGML-specific
          (function (lambda()
                      ; --- begin of customized functions in sgml-mode
                      ; Add a comment
                      (defun sgml-comment ()
                        "Insert SGML comment and position cursor."
                        (interactive)
                        (insert "<!--  -->")
                        (backward-char 4))
                      (define-key sgml-mode-map "o" 'sgml-comment)
                      ; Greater-than
                      (defun sgml-gt ()
                        "Insert ISO entity reference for greater-than."
                        (interactive)
                        (insert "&gt;"))
                      (define-key sgml-mode-map ">" 'sgml-gt)
                      ; Less-than
                      (defun sgml-lt ()
                        "Insert ISO entity reference for less-than."
                        (interactive)
                        (insert "&lt;"))
                      (define-key sgml-mode-map "<" 'sgml-lt)
                      ; Non-Breaking Space
                      (defun sgml-nbsp ()
                        "Insert ISO entity reference for non-breaking space."
                        (interactive)
                        (insert "&nbsp;"))
                      (define-key sgml-mode-map " " 'sgml-nbsp)
                      ; right-click selected element for edit attributes popup
                      (define-key sgml-mode-map [mouse-3] 'sgml-attrib-menu)
                      ; --- end of customized functions in sgml-mode
                      )))


;; ;;; from http://www.dzr-web.com/people/darren/projects/emacs-webdev/
;; ;; xxml.el for better syntax highlighting (although we won't use xxml.el's
;; ;; html-mode, but will define our own).

;; ; (autoload 'html-mode "xxml" "Major mode to edit HTML files." t)
;; (autoload 'xxml-mode-routine "xxml")
;; (add-hook 'sgml-mode-hook 'xxml-mode-routine)
;; (add-hook 'xml-mode-hook 'xxml-mode-routine)


;;; webdev ends here
