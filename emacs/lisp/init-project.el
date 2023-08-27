;;(require 'init-ctags)
(require 'init-counsel-etags)
(require 'init-code-basic)
(require 'init-coding-request)
;; (require 'init-lsp)

(use-package projectile
  ;; :bind (("C-c k" . projectile-command-map))
  :config
  (setq
   projectile-mode-line "Projectile"
   projectile-track-known-projects-automatically nil
   )
  (projectile-mode)
  )

(use-package counsel-projectile
  :after (projectile)
  :config
  (counsel-projectile-mode)
  )

(provide 'init-project)
