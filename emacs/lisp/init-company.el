(use-package company
  :bind (:map company-active-map
	      ("C-n" . 'company-select-next)
	      ("C-p" . 'company-select-previous))
  :init
  (setq company-minimum-prefix-length 3
        company-idle-delay 0)
  :config
  (global-company-mode t)
  )






















(provide 'init-company)
