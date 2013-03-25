;;; objc.el --- setting up environment for obj-c programming
;;
;; Copyright © 2013 plasma
;;
;; Author: plasma chen <plasmaball@gmail.com>
;; URL:
;; Version: 0.0.1
;; Keywords:
;;

;;; Commentary:

;; Config after http://roupam.github.com/ .

;;; Code:

;; Object-C mode
(add-to-list 'auto-mode-alist '("\\.mm?$" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

;; compile xcode
(defun xcode:buildandrun ()
  (interactive)
  (do-applescript
   (format
    (concat
     "tell application \"Xcode\" to activate \r"
     "tell application \"System Events\" \r"
     "     tell process \"Xcode\" \r"
     "          key code 36 using {command down} \r"
     "    end tell \r"
     "end tell \r"
     ))))
(add-hook 'objc-mode-hook
          (lambda ()
            (define-key objc-mode-map (kbd "C-c C-r") 'xcode:buildandrun)
            ))

;; ;; yasnippet
(require 'yasnippet)
(yas--initialize)

;; ;; auto-complete
;; (require 'auto-complete-config)
;; (setq-default ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;; (add-hook 'auto-complete-mode-hook 'ac-common-setup)
;; (global-auto-complete-mode t)
;; (add-to-list 'ac-modes 'objc-mode)


;; xcode-document-viewer
(require 'xcode-document-viewer)
(setq xcdoc:document-path "/Users/plasma/Library/Developer/Shared/Documentation/DocSets/com.apple.adc.documentation.AppleiOS6.1.iOSLibrary.docset")
;(setq xcdoc:document-path "/Developer/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiOS5_0.iOSLibrary.docset")
;(setq xcdoc:document-path "/Developer/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiOS4_3.iOSLibrary.docset")
(setq xcdoc:open-w3m-other-buffer t)
(add-hook 'objc-mode-hook
          (lambda ()
            ;; 用 C-c w 来检索文档
            (message "hook xcode document in objc-mode-hook")
            (define-key objc-mode-map (kbd "C-c w") 'xcdoc:ask-search)))

;; helpers for finding files
(ffap-bindings)
;; 设定搜索的路径 ffap-c-path
;; (setq ffap-c-path
;;     '("/usr/include" "/usr/local/include"))
;; 如果是新文件要确认
(setq ffap-newfile-prompt t)
;; ffap-kpathsea-expand-path 展开路径的深度
(setq ffap-kpathsea-depth 5)

(setq ff-other-file-alist
      '(("\\.mm?$" (".h"))
        ("\\.cc$"  (".hh" ".h"))
        ("\\.hh$"  (".cc" ".C"))

        ("\\.c$"   (".h"))
        ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

        ("\\.C$"   (".H"  ".hh" ".h"))
        ("\\.H$"   (".C"  ".CC"))

        ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
        ("\\.HH$"  (".CC"))

        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))

        ("\\.hpp$" (".cpp" ".c"))))
(add-hook 'objc-mode-hook
          (lambda ()
            (define-key c-mode-base-map (kbd "C-x t") 'ff-find-other-file)
            ))


;; auto-complete for object-c
(require 'auto-complete)
(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/lib/lisp/auto-complete-1.3.1/dict")
;;(ac-config-default)

(set-default 'ac-sources '(ac-source-abbrev ac-source-words-in-same-mode-buffers ac-source-yasnippet ac-source-dictionary))
(setq ac-delay 0.2)

(global-auto-complete-mode t)

(require 'ac-company)
(ac-company-define-source ac-source-company-xcode company-xcode)

(require 'etags-table)
;; find /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS3.1.2.sdk/System/Library/Frameworks -name "*.h" | xargs etags -f obcj.TAGS -l objc
;; find /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk/System/Library/Frameworks/ -name "*.h" | xargs etags -f obcj.TAGS -l objc
(add-to-list 'etags-table-alist
             '("\\.[mh$]" "~/.emacs.d/personal/objc.TAGS"))
;; (add-to-list 'etags-table-alist
;;              '("/Users/plasma/Documents/iphone_news/" "/Users/plasma/Documents/iphone_news/TAGS"))
(defvar ac-source-etags
  '((candidates . (lambda ()
                    (all-completions ac-target (tags-completion-table))))
    (candidate-face . ac-candidate-face)
    (selection-face . ac-selection-face)
    (symbole . "e")
    (requires . 3))
  "etags source")
(add-hook 'objc-mode-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            (push 'ac-source-etags ac-sources)))

;; 设定 objc-mode 中补全 ac-mode
(setq ac-modes (append ac-modes '(objc-mode)))
;; hook
(add-hook 'objc-mode-hook
         (lambda ()
           (define-key objc-mode-map (kbd "\t") 'ac-complete)
           ;; 使用 XCode 的补全功能有效
           (push 'ac-source-company-xcode ac-sources)
           ;; ;; C++ 关键词补全
           ;; (push 'ac-source-c++-keywords ac-sources)
         ))
;; 补全窗口中的热键
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)
(define-key ac-completing-map (kbd "M-/") 'ac-stop)
;; 是否自动启动补全功能
(setq ac-auto-start nil)
;; 启动热键
(ac-set-trigger-key "TAB")
(setq ac-candidate-limit nil)
(setq ac-use-comphist t)
(setq ac-use-quick-help nil)

(require 'ac-anything)
(define-key ac-completing-map (kbd "C-:") 'ac-complete-with-anything)

;; coding style for object-c
(add-hook 'c-mode-common-hook
         '(lambda()
             (c-set-style "linux")
             (setq c-basic-offset 4)))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; set face
(defface ac-yasnippet-candidate-face
  '((t (:background "sandybrown" :foreground "black")))
  "Face for yasnippet candidate.")
(defface ac-yasnippet-selection-face
  '((t (:background "coral3" :foreground "white")))
  "Face for the yasnippet selected candidate.")

;; pragma sections
(require 'anything-config)

(defvar anything-c-source-objc-headline
  '((name . "Objective-C Headline")
    (headline  "^[-+@]\\|^#pragma mark")))

(defun objc-headline ()
  (interactive)
  ;; Set to 500 so it is displayed even if all methods are not narrowed down.
  (let ((anything-candidate-number-limit 500))
    (anything-other-buffer '(anything-c-source-objc-headline)
                           "*ObjC Headline*")))

(global-set-key "\C-xp" 'objc-headline)

;;; objc ends here
