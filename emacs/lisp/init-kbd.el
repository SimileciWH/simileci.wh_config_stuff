;;key binding set

(cond  (*is-mac*
	(setq mac-option-modifier 'meta)
	(setq mac-command-modifier 'super))
       (*is-windows*
	"need change lwindow and lALT with keyboard or powertoy"
	;; (setq w32-pass-lwindow-to-system nil)
	(setq w32-apps-modifier 'super)
	(w32-register-hot-key [s-])
	
	)
       (t "need check for linux")
       
       )

(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-x") 'kill-region)
(global-set-key (kbd "s-i") 'goto-line)

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-x b") 'consult-buffer)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "C-h k") 'counsel-descbinds)
(global-set-key (kbd "C-h C-v") 'consel-describe-symbol)

(global-set-key [remap move-beginning-of-line] 'mwim-beginning)
(global-set-key [remap move-end-of-line] 'mwim-end)

(use-package which-key
  :init
  (setq which-key_idle-delay 0.01)
  :config
  (which-key-mode t)
  )

(use-package general
  :init
  (general-create-definer my-global-definer
    :keymaps 'override
    :prefix "C-SPC"
    :non-normal-prefix "C-SPC"
    )
  (general-create-definer global-definer
    :prefix "C-c"
    )

  (defmacro +general-global-menu! (name infix-key &rest body)
    "Create a definer named +general-global-NAME wrapping global-definer.Create prefix map: +general-global-NAME. Prefix bindings in BODY with INFIX-KEY."
    (declare (indent 2))
    `(progn
       (general-create-definer ,(intern (concat "+general-global-" name))
	 :wrapping global-definer
	 :prefix-map ',(intern (concat "+general-global-" name "-map"))
	 :infix ,infix-key
	 :wk-full-keys nil
	 "" '(:ignore t :which-key ,name))
       (,(intern (concat "+general-global-" name))
	,@body)))
  )


(my-global-definer
  "SPC" 'execute-extended-command
  
  )
(+general-global-menu! "layout-left" "l"
  "e" 'treemacs  ;; enable it
  "w" 'treemacs-select-windows
  "b" 'treemacs-bookmark
  "f" 'treemacs-find-tag
  
  )
(+general-global-menu! "layout-right" "r"
  "e" 'imenu-list-minor-mode  ;; enable it
  "t" 'imenu-list-smart-toggle

  )
(+general-global-menu! "layout-down" "d"

  )
(+general-global-menu! "buffer" "b"
  "b" 'consult-project-buffer
  "k" 'kill-current-buffer
  
  )
(+general-global-menu! "file" "f"
  "o" 'recentf-open-files
  "f" 'find-file
  "r" 'consult-recent-file
  "L" 'consult-locate
  "j" 'dired-jump
  ;; "R" 'my/rename-current-buffer-file
  "p" 'project-find-file
  
  )
(+general-global-menu! "tabspace" "t"
  "c" 'tabspaces-clear-buffers
  "d" 'tabspaces-close-workspace
  "k" 'tabspaces-kill-buffers-close-workspace
  "f" 'tabspaces-project-switch-project-open-file
  "o" 'tabspaces-open-or-create-project-and-workspace
  "R" 'tabspaces-remove-current-buffer
  "r" 'tabspaces-remove-selected-buffer
  "b" 'tabspaces-switch-to-buffer
  "s" 'tabspaces-switch-or-create-workspace
  "t" 'tabspaces-switch-buffer-and-tab
  "S" 'tabspaces-save-session
  )



(+general-global-menu! "search" "s"
  "m" 'consult-imenu
  "g" 'consult-ripgrep
  "e" 'embark-export-write  ;;export consult-ripgrep result
  "s" 'my/search-project-for-symbol-at-point
  "G" 'counsel-etags-grep
  "d" 'counsel-etags-grep-current-directory
  "f" 'counsel-etags-list-tag-in-current-file
  ;; "" 'counsel-etags-grep-extra-arguments
  "p" 'project-find-regexp
  )

(+general-global-menu! "view" "v"
  "d" 'dired-jump-other-window
  "a" 'annotate-annotate
  "k" 'annotate-delete-annotation
  "s" 'annotate-show-annotation-summary
  "[" 'annotate-goto-previous-annotation
  "S" 'tabspaces-save-session
  "]" 'annotate-goto-next-annotation
  "h" 'symbol-overlay-put
  "n" 'symbol-overlay-jump-next
  "p" 'symbol-overlay-jump-prev
  "N" 'symbol-overlay-switch-forward
  "P" 'symbol-overlay-switch-backward
  "c" 'symbol-overlay-remove-all
  ;; code review
  "b" 'pop-tag-mark
  "j" 'counsel-etags-find-tag-at-point
  )


(+general-global-menu! "edit" "e"
  "y" 'avy-copy-line
  "d" 'kill-whole-line
  "f" 'astyle-region
  "h" 'hippie-expand
  "k" 'h_wang/kill-cur-line-string
  "/" 'h_wang/insert-new-line-next
  "?" 'h_wang/insert-new-line-previous
  ;; "w" 'iedit-mode
  ;; "e" 'iedit-restrict-function
  ;; "l" 'iedit-restrict-current-line
  "a" 'mc/mark-all-like-this
  "n" 'mc/mark-next-like-this
  "w" 'mc/mark-next-like-this-word  ;;a word
  "q" 'mc/mark-next-like-this-symbol ;; a sentence
  "c" 'mc/mark-next-word-like-this  ;; a char
  "Q" 'mc/mark-next-symbol-like-this
  ;; "" 'mc/mark-previous-like-this
  ;; "" 'mc/mark-previous-like-this-word
  ;; "" 'mc/mark-previous-like-this-symbol
  ;; "" 'mc/mark-previous-word-like-this
  ;; "" 'mc/mark-previous-symbol-like-this
  ;; "" 'mc/mark-pop
  ;; "" 'mc/unmark-next-like-this
  ;; "" 'mc/unmark-previous-like-this
  "[" 'mc/skip-to-next-like-this
  "]" 'mc/skip-to-previous-like-this
  "b" 'mc/edit-beginnings-of-lines
  "e" 'mc/edit-ends-of-lines
  ;; "" 'mc/mark-all-words-like-this
  ;; "" 'mc/mark-all-symbols-like-this
  ;; "" 'mc/mark-all-in-region
  ;; "" 'mc/mark-all-like-this-in-defun
  ;; "" 'mc/mark-all-words-like-this-in-defun
  ;; "" 'mc/mark-all-symbols-like-this-in-defun
  ;; "" 'mc/mark-all-dwim

  "r" 'set-rectangular-region-anchor
  ;; "" 'mc/mark-sgml-tag-pair
  "l" 'mc/insert-numbers
  ;; "" 'mc/insert-letters
  ;; "" 'mc/sort-regions
  "R" 'mc/reverse-regions
  ;; "" 'mc/vertical-align
  "A" 'mc/vertical-align-with-space
  )

(+general-global-menu! "project" "p"
  "d" 'project-dired
  "e" 'project-eshell
  "p" 'project-switch-project
  "a" 'project-remember-projects-under
  "x" 'project-forget-project
  
  )

(+general-global-menu! "eshell" "z"
  "c" 'aweshell-new
  "n" 'aweshell-next
  "p" 'aweshell-prev
  "k" 'aweshell-clear-buffer
  "e" 'aweshell-dedicated-toggle
  "o" 'aweshell-dedicated-open
  "d" 'aweshell-dedicated-close
  "s" 'aweshell-switch-buffer
  )

(+general-global-menu! "func" "x"
  "e" 'restart-emacs
  "n" 'tab-rename
  "t" 'counsel-etags-scan-code
  "u" 'counsel-etags-update-tags-force
  "r" 'quickrun
  "w" 'resize-window
  )

(+general-global-menu! "bookmarks" "m"
  "j" 'counsel-bookmark  ;;create or jump
  "n" 'bookmark-rename
  "d" 'bookmark-delete
  "e" 'edit-bookmarks
  "l" 'list-bookmarks
  "w" 'bookmark-write
  "L" 'bookmark-load
  )



(provide 'init-kbd)
