(use-package company
  :bind (:map company-active-map
              ("C-n" . 'company-select-next)
              ("C-p" . 'company-select-previous))
  :init
  (setq company-minimum-prefix-length 3
        company-idle-delay 0
        company-show-numbers t
        company-transformers '(company-sort-by-occurrence)
        company-selection-wrap-around t
        company-tooltip-align-annotations t
        )
  :config
  (global-company-mode t)
  )

(use-package yasnippet
  :hook
  (prog-mode . yas-minor-mode)
  :config
  (setq yas-snippet-dirs `(, (concat *WinMac-PATH* "/emacs/snippets/")))
  (yas-global-mode 1)
  (yas-reload-all)
  ;; add company-yasnippet to company-backends
  ;; (defun company-mode/backend-with-yas (backend)
  ;;   (if (and (listp backend) (member 'company-yasnippet backend))
  ;;    backend
  ;;     (append (if (consp backend) backend (list backend))
  ;;             '(:with company-yasnippet))))
  ;; (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  ;; unbind <TAB> completion
  (define-key yas-minor-mode-map [(tab)]        nil)
  (define-key yas-minor-mode-map (kbd "TAB")    nil)
  (define-key yas-minor-mode-map (kbd "<tab>")  nil)
  :bind
  (:map yas-minor-mode-map ("S-<tab>" . yas-expand))
  )

(use-package yasnippet-snippets
  :after yasnippet)

(provide 'init-company)
