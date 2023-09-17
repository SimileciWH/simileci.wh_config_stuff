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
  (setq which-key_idle-delay 1)
  :config
  (which-key-mode t)
  )
(which-key-setup-side-window-bottom)
(use-package general
  :init
  (general-create-definer my-global-definer
    :keymaps 'override
    :prefix "C-SPC"
    :non-normal-prefix "C-SPC"
    )
  (general-create-definer global-org-mode-definer
    :keymaps 'override
    :prefix "C-o"
    :non-normal-prefix "C-o"
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
  (defmacro +general-global-menu-org-mode! (name infix-key &rest body)
    "Create a definer named +general-global-NAME wrapping global-definer.Create prefix map: +general-global-NAME. Prefix bindings in BODY with INFIX-KEY."
    (declare (indent 2))
    `(progn
       (general-create-definer ,(intern (concat "+general-global-" name))
	 :wrapping global-org-mode-definer
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
  ;; "s" 'lsp-treemacs-symbols
  ;; "F" 'lsp-treemacs-errors-list
  ;; "g" 'lsp-treemacs-goto-symbol
  ;; "h" 'lsp-treemacs-call-hierarchy
  ;; "r" 'lsp-treemacs-references
  ;; "d" 'lsp-treemacs-implementations
  
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
  "r" 'consult-recent-file
  "L" 'consult-locate
  ;; "R" 'my/rename-current-buffer-file
  "p" 'project-find-file
  "f" 'counsel-projectile-find-file
  "d" 'counsel-projectile-find-dir
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
  "e" 'embark-export-write  ;;export consult-ripgrep result
  "fm" 'consult-imenu
  "f/" 'consult-imenu-multi
  "ff" 'counsel-etags-list-tag-in-current-file
  "s" 'my/search-project-for-symbol-at-point
  "t" 'counsel-etags-grep
  "d" 'counsel-etags-grep-current-directory
  "pp" 'project-find-regexp
  "pg" 'consult-ripgrep  ;; "" 'counsel-etags-grep-extra-arguments
  )

(+general-global-menu! "view" "v"
  "aa" 'annotate-annotate
  "ak" 'annotate-delete-annotation
  "as" 'annotate-show-annotation-summary
  "ap" 'annotate-goto-previous-annotation
  "an" 'annotate-goto-next-annotation
  "hn" 'symbol-overlay-jump-next
  "hp" 'symbol-overlay-jump-prev
  "h]" 'symbol-overlay-switch-forward
  "h[" 'symbol-overlay-switch-backward
  "p" 'symbol-overlay-put
  "c" 'symbol-overlay-remove-all
  "s" 'tabspaces-save-session

  ;; code hide
  "fh" 'hs-hide-block
  "fs" 'hs-show-block
  "fa" 'hs-show-all
  "mh" 'hide-ifdef-block
  "ms" 'show-ifdef-block
  "md" 'hide-ifdef-define
  "mu" 'hide-ifdef-undef
  "ma" 'show-ifdefs
  )

(+general-global-menu! "navigation" "n"
  ;; code review
  "b" 'pop-tag-mark
  "j" 'counsel-etags-find-tag-at-point
  "[" 'detour-mark ;;cursor idle > 1s auto mark
  "]" 'detour-back
  "g" 'avy-goto-char-timer
  "l" 'avy-goto-line
  "e"' c-end-of-defun
  "a" 'c-beginning-of-defun
  ";" 'evilmi-jump-items-native
  "d" 'evilmi-delete-items
  "r" 'evilmi-select-items
 )


(+general-global-menu! "edit" "e"
  "cl" 'avy-copy-line
  "cr" 'avy-copy-region
  "h" 'hippie-expand
  "d" 'kill-whole-line
  "k" 'h_wang/kill-cur-line-string
  "/" 'h_wang/insert-new-line-next
  "?" 'h_wang/insert-new-line-previous
  ;; "w" 'iedit-mode
  ;; "e" 'iedit-restrict-function
  ;; "l" 'iedit-restrict-current-line
  "a" 'mc/mark-all-like-this
  "n" 'mc/mark-next-like-this
  "w" 'mc/mark-next-like-this-word  ;;a word
  "s" 'mc/mark-next-like-this-symbol ;; a sentence
  ;; "c" 'mc/mark-next-word-like-this  ;; a char
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
  ;; "R" 'mc/reverse-regions
  ;; "" 'mc/vertical-align
  "A" 'mc/vertical-align-with-space
  "R" 'projectile-replace
  )

(+general-global-menu! "project" "p"
  "e" 'project-eshell
  "p" 'project-switch-project
  "a" 'project-remember-projects-under
  "x" 'project-forget-project
  "s" 'counsel-projectile-switch-project
  
  
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
  "f" 'astyle-region
  "c" 'yas-insert-snippet
  "y" 'yas-new-snippet
  )

(+general-global-menu! "bookmarks" "k"
  "s" 'bookmark-set
  "j" 'counsel-bookmark  ;;create or jump
  "n" 'bookmark-rename
  "d" 'bookmark-delete
  "e" 'edit-bookmarks
  "l" 'list-bookmarks
  "w" 'bookmark-write
  "L" 'bookmark-load
  )
(+general-global-menu! "markdown" "m"
  "v" 'grip-mode
  "l" 'markdown-toc-follow-link-at-point
  "t" 'markdown-toc-generate-or-refresh-toc
  "r" 'markdown-toc-generate-toc
  "d" 'markdown-toc-delete-toc
  "i" 'markdown-insert-gfm-code-block
  "n" 'markdown-outline-next
  "p" 'markdown-outline-up
  "N" 'markdown-outline-next-same-level
  "P" 'markdown-outline-previous-same-level
  )
(+general-global-menu! "roam" "r"
  "l" 'org-roam-buffer-toggle
  "f" 'org-roam-node-find
  "g" 'org-roam-graph
  "i" 'org-roam-node-insert
  "c" 'org-roam-capture
  "j" 'org-roam-dailies-capture-today
  "s" 'org-roam-ui-open
  )

(global-org-mode-definer
 "/" 'org-todo
 "a" 'org-agenda
 "c" 'org-capture
 "b" 'org-insert-todo-heading
 "x" 'org-toggle-checkbox
 "s" 'org-set-property
 "p" 'org-priority
 "'" 'org-set-tags-command
 "o" 'org-open-at-point
 )

(+general-global-menu-org-mode! "Hyperlinks" "l"
  "l" 'org-insert-link
  "s" 'org-mark-ring-push
  "g" 'org-mark-ring-goto
  "n" 'org-next-link
  "p" 'org-previous-link
  )

(+general-global-menu-org-mode! "TODO" "d"
  "t" 'org-show-todo-tree
  "[" 'org-priority-up
  "]" 'org-priority-down
  "u" 'org-update-statistics-cookies
  )

(+general-global-menu-org-mode! "SymbolTags" "t"
  "v" 'org-tags-view
  "S" 'org-match-sparse-tree
  ;; time stamps
  "t" 'org-time-stamp
  "T" 'org-time-stamp-inactive
  "g" 'org-goto-calendar
  "c" 'org-evaluate-time-range
  "d" 'org-deadline
  "s" 'org-schedule
  
  )
(+general-global-menu-org-mode! "Picture" "p"
  "s" 'org-toggle-inline-images
  "v" 'org-download-screenshot
  "V" 'org-download-clipboard
  )


(provide 'init-kbd)
