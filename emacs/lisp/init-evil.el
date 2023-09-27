(use-package evil
  :init
  (setq evil-want-keybinding nil
	evil-want-C-u-scroll t
	)
  (evil-mode)

  ;; https://emacs.stackexchange.com/questions/46371/how-can-i-get-ret-to-follow-org-mode-links-when-using-evil-mode
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd "RET") nil))
  )
(use-package undo-tree
  :diminish
  :config
  (setq
   undo-tree-mode t
   global-undo-tree-mode t
   global-undo-tree-mode-buffers t
   undo-tree-visualizer-diff t
   undo-tree-visualizer-timestamps t
   )
  (evil-set-undo-system 'undo-tree)
  )

(use-package evil-tutor-sc)


(provide 'init-evil)
