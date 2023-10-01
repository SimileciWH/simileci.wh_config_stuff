
(use-package evil
  :init
  (setq evil-want-keybinding nil
	evil-want-C-u-scroll t
	)
  (evil-mode)
  (setcdr evil-insert-state-map nil)

  ;; https://emacs.stackexchange.com/questions/46371/how-can-i-get-ret-to-follow-org-mode-links-when-using-evil-mode
  (with-eval-after-load 'evil-maps
    (define-key evil-motion-state-map (kbd "RET") nil))
  )
(use-package undo-tree
  :diminish
  :init
  (setq
   undo-tree-mode t
   global-undo-tree-mode t
   global-undo-tree-mode-buffers t
   undo-tree-visualizer-diff t
   undo-tree-visualizer-timestamps t
   undo-tree-auto-save-history nil
   )
  (evil-set-undo-system 'undo-tree)
  )

(use-package evil-tutor-sc)
(use-package evil-anzu
  :after evil
  :diminish
  :demand t
  :init
  (global-anzu-mode t)
  )
(use-package evil-collection
  :demand t
  :config
  (setq evil-collection-mode-list (remove 'lispy evil-collection-mode-list))
  (evil-collection-init)

  (cl-loop for (mode . state) in
	       '((org-agenda-mode . normal)
	         (Custom-mode . emacs)
	         (eshell-mode . emacs)
	         (makey-key-mode . motion))
	       do (evil-set-initial-state mode state)
           )
  )
(use-package evil-surround
  :ensure t
  :init
  (global-evil-surround-mode 1)
  )
(use-package evil-nerd-commenter)

(use-package evil-snipe
  :diminish
  :init
  (evil-snipe-mode +1)
  (evil-snipe-override-mode +1)
  )
(use-package evil-matchit
  :ensure
  :init
  (global-evil-matchit-mode 1)
  )
(require 'init-evil-kbd)

(provide 'init-evil)
