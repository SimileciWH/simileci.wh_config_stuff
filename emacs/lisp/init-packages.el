;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;package management

(require 'package)
(setq package-archives
	       '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                 ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                 ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;package install
;; Setup `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; can install from github
(use-package quelpa)

(unless (package-installed-p 'quelpa-use-package)
  (quelpa
   '(quelpa-use-package
     :fetcher git
     :url "https://github.com/quelpa/quelpa-use-package.git"))
  )

(use-package quelpa-use-package
  :demand t
  :init
  (setq quelpa-use-package-inhibit-loading-quelpa t)
  )

(require 'aweshell)
(setq eshell-up-ignore-case nil
      eshell-up-print-parent-dir t
      ;; exec-path-from-shell-check-startup-files
      )

(require 'keyfreq)
(keyfreq-mode t)
(keyfreq-autosave-mode t)
(setq keyfreq-excluded-commands
      '(self-insert-command
        forward-char
        backward-char
        previous-line
        next-line
	delete-backward-char
	))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package restart-emacs)

(use-package nerd-icons)


(use-package keycast
  :init
  (add-to-list 'global-mode-string '("" keycast-mode-line))
  :config
  (keycast-mode-line-mode t)
  )

(use-package doom-modeline
  :config
  (doom-modeline-mode t)
  )

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-opera-light t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  )


(use-package vertico
  :config
  (vertico-mode t)
  )

(use-package orderless
  :init
  (setq completion-styles '(orderless))
  )

(use-package marginalia
  :config
  (marginalia-mode t)
  )

(use-package embark
  :init
  (setq prefix-help-command 'embark-prefix-help-command)
  )



(use-package embark-consult)
(use-package wgrep)
(setq wgrep-auto-save-buffer t)

(use-package consult
  :init
  (setq
	consult-narrow-key "<"
	consult-line-numbers-widen t
	consult-async-min-input 2
	consult-async-refresh-delay  0.15
	consult-async-input-throttle 0.2
	consult-async-input-debounce 0.1
	)
  )
(use-package multiple-cursors
  ;; "https://github.com/magnars/multiple-cursors.el"
  )

(use-package mwim)

(use-package dashboard
  :config
  (setq
   dashboard-banner-logo-title "Welcome to Emacs!"
   dashboard-startup-banner 'official
   dashboard-center-content t
   dashboard-display-icons-p t
   dashboard-set-navigator t
   dashboard-set-init-info t
   dashboard-icon-type 'nerd-icons
   dashboard-items '((recents  . 5)
                     (bookmarks . 5)
                     (projects . 5)
                     ;; (agenda . 5)
                     ;; (registers . 5)
		     )
   )
  (dashboard-modify-heading-icons '((recents . "nf-oct-file_text")
                                  (bookmarks . "nf-oct-book")))
  (dashboard-setup-startup-hook)
  )


(provide 'init-packages)
