;; init-markdown.el --- Initialize markdown configurations.	-*- lexical-binding: t -*-

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode))
  :init
  (when (executable-find "multimarkdown")
    (setq markdown-command "multimarkdown")
    )
  :config

  (with-no-warnings
    ;; Use `which-key' instead
    (advice-add #'markdown--command-map-prompt :override #'ignore)
    (advice-add #'markdown--style-map-prompt   :override #'ignore)
    )
  )

(use-package edit-indirect)

;; Preview via `grip'
;; Install: pip install grip
(use-package grip-mode
  :defines org-mode-map
  ;; :hook ((markdown-mode org-mode) . grip-mode)
  :init
  (setq
   grip-update-after-change nil
   grip-preview-use-webkit t
   )
  (when-let ((credential (auth-source-user-and-password "api.github.com")))
    (setq grip-github-user (car credential)
          grip-github-password (cadr credential)
	  )
    )
  )

;; Table of contents
(use-package markdown-toc
  :diminish
  :hook (markdown-mode . markdown-toc-mode)
  :init
  (setq
   markdown-toc-indentation-space 4
   markdown-toc-header-toc-title "\n## Table of Contents"
   markdown-toc-user-toc-structure-manipulation-fn 'cdr
   )
  )
  

(provide 'init-markdown)
