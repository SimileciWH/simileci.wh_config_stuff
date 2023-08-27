(use-package lsp-mode
  :bind
  ("s-l s" . lsp-ivy-workspace-symbol)
  :hook 
  (lsp-mode . lsp-enable-which-key-integration) 
  (c-mode . lsp-deferred)
  (c++-mode . lsp-deferred)
  (c++-mode . c-toggle-hungry-state)
  :commands (lsp lsp-deferred)
  :config
  (setq
   lsp-keymap-prefix "s-l"
   lsp-file-watch-threshold 500
   lsp-completion-provider :none
   lsp-headerline-breadcrumb-enable t
   )
  )

(use-package lsp-ivy
  :after (lsp-mode)
  )

(provide 'init-lsp)
