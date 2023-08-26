(prefer-coding-system 'utf-8-unix)
(h_wang/scroll-bar-mode)
;; (h_wang/emacs-frame-change)

;; Inhibit resizing frame
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)

;; Initial frame
(setq initial-frame-alist '((top . 0.5)
                            (left . 0.5)
                            (width . 0.628)
                            (height . 0.8)
                            (fullscreen)))

(setq-default line-spacing 0.3)

(use-package recentf
  :hook (after-init . recentf-mode)
  :init
  (setq recentf-max-menu-items 12
        recentf-max-saved-items 300
        recentf-exclude
        '(("\\.?cache" ".cask" "url" "COMMIT_EDITMSG\\'" "bookmarks"
           "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
           "\\.?ido\\.last$" "\\.revive$" "/G?TAGS$" "/.elfeed/"
           "^/tmp/" "^/var/folders/.+$" "^/ssh:" "/persp-confs/"
           (lambda (file) (file-in-directory-p file package-user-dir)))
          )
        )
  :config
  (recentf-mode t)
  )

;; save history 1000
(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :init
  (setq enable-recursive-minibuffers t ; Allow commands in minibuffers
              history-length 1000
              savehist-additional-variables '(mark-ring
                                              global-mark-ring
                                              search-ring
                                              regexp-search-ring
                                              extended-command-history)
              savehist-autosave-interval 300)
  )

;; save cursor position
(use-package saveplace
  :ensure nil
  :hook (after-init . save-place-mode))

(use-package simple
  :ensure nil
  :hook (after-init . size-indication-mode)
  :init (progn (setq column-number-mode t))
  )

(use-package emacs
  :bind (
         ("C-=" . text-scale-increase)
         ("C--" . text-scale-decrease)
         ("C-0" . text-scale-adjust)
         )
  :init
  (setq-default display-fill-column-indicator-character 83
		display-fill-column-indicator-column 100

    )
    (setq display-line-numbers-type 'relative
          ring-bell-function 'ignore
          auto-save-default nil
          make-backup-failes nil
          
          tab-always-indent 'complete
	  inhibit-startup-message t

    )
    :config
    (electric-pair-mode t)
    (show-paren-mode t)
    (delete-selection-mode t)
    (display-fill-column-indicator-mode t)
    (global-display-line-numbers-mode t)
    (global-display-fill-column-indicator-mode t)
    (tool-bar-mode -1)
    (global-auto-revert-mode t)
    (global-hl-line-mode t)
    ;; (global-whitespace-mode t)
    (defalias 'yes-or-no-p 'y-or-n-p)
  )

(require 'crosshairs)
(crosshairs-mode t)
(setq toggle-crosshairs-when-idle 0.1)
(set-face-background 'hl-line "#98fb98")
(set-face-attribute 'col-highlight nil :inherit 'hl-line :background)


(provide 'init-basic)
