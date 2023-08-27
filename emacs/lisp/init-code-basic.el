
(add-hook 'prog-mode-hook #'hs-minor-mode)

(use-package quickrun
    :commands (quickrun)
    :init
    (quickrun-add-command "c/gcc"
    '((:command . "gcc")
	(:exec . ("%c %o -o %e %s"
		"%e %a"))
	(:remove . ("%e")))
;    :mode 'c-mode
    :default "c")
    )
;; (use-package eglot
;;   :hook ((c-mode c++-mode) . eglot-ensure)
;;   )

(use-package treesit-auto
  :init
  (setq treesit-auto-install 'prompt
	treesit-font-lock-level 4
	;; treesit-extra-load-path "~/.emacs.d/tree-sitter"
	)
  :config
  ;; (global-treesit-auto-mode)
 )

(use-package eglot
  :hook ((prog-mode . (lambda ()
                        (unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode 'makefile-mode 'snippet-mode)
                          (eglot-ensure))))
         ((markdown-mode yaml-mode yaml-ts-mode) . eglot-ensure)
	 (c-mode . eglot-ensure)
	 (c++-mode . eglot-ensure)
	 )
  :config
  (use-package consult-eglot
    :bind (:map eglot-mode-map
		("C-M-." . consult-eglot-symbols))
    )
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
  )

(use-package imenu-list
  :init
  (setq
   imenu-list-focus-after-activation t
   imenu-list-auto-resize t
   imenu-list-position 'right
   )
  :config
  ;; (imenu-list-minor-mode t)
  )

;; (setq-default c-basic-offset 4
;;               tab-width 4
;;               indent-tabs-mode t)

(use-package flycheck
  :config
  (global-flycheck-mode)
  )
(provide 'init-code-basic)
