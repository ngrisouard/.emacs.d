;; From https://realpython.com/blog/python/emacs-the-best-python-editor/

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; (add-to-list
;;  'package-archives
;;  '("elpy" . "http://jorgenschaefer.github.io/packages/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein  ;; emacs ipython notebook
    elpy  ;; better python mode
    flycheck  ;; better python syntax checking
    py-autopep8  ;; python script fixing
    )
  )
;;    material-theme))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)


;; BASIC CONFIGURATION
;; --------------------------------------

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#272822" :foreground "#F8F8F2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "nil" :family "Menlo")))))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; (load-theme 'monokai t)
;; (load-theme 'material t)
(global-linum-mode t) ;; enable line numbers globally
(scroll-bar-mode -1) ;; thinner vertical divider for split


;; CUSTOMIZATION
;; --------------------------------------
;; python suff

(when (memq window-system '(mac ns))  ;; otherwise I get the wrong python distro on a Mac
  (exec-path-from-shell-initialize))

(elpy-enable)
(elpy-use-ipython)

;(defun ipython ()
;    (interactive)
;    (term "/Users/NicoG/anaconda/bin/ipython"))

;(require 'python)
;(setq python-shell-interpreter "ipython")
;(setq python-shell-interpreter-args "--pylab")

;(require 'ein)

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; --------------------------------------
;; TeX stuff

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(custom-safe-themes
   (quote
    ("67a0265e2497207f5f9116c4d2bfbbab4423055e3ab1fa46ea6bd56f7e322f6a" "fe230d2861a13bb969b5cdf45df1396385250cc0b7933b8ab9a2f9339b455f5c" default)))
 '(fci-rule-color "#383838")
 '(inhibit-startup-echo-area-message "NicoG")
 '(inhibit-startup-screen t)
 '(initial-buffer-choice "~/.emacs.d/init.el")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (ein py-autopep8 flycheck exec-path-from-shell anaconda-mode auctex)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))

;; Nouse scrolling
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)
(setq ispell-program-name "/usr/local/bin/ispell")
(setenv "DICTIONARY" "en_CA")

;; AucTeX
;; Taken from http://www.stefanom.org/setting-up-a-nice-auctex-environment-on-mac-os-x/
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

(setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:$PATH" t)

;; Use Skim as viewer, enable source <-> PDF sync
;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))
;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background  
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
;; End http://www.stefanom.org/setting-up-a-nice-auctex-environment-on-mac-os-x/

;; AucTeX settings from
;; http://tex.stackexchange.com/questions/316787/getting-synctex-to-work-with-emacs-auctex-and-skim-os-x-el-capitan

;; end http://tex.stackexchange.com/questions/316787/getting-synctex-to-work-with-emacs-auctex-and-skim-os-x-el-capitan

