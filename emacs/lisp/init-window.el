
;; Restore old window configurations
(use-package winner
  :ensure nil
  :commands (winner-undo winner-redo)
  :hook (after-init . winner-mode)
  :init (setq winner-boring-buffers '("*Completions*"
                                      "*Compile-Log*"
                                      "*inferior-lisp*"
                                      "*Fuzzy Completions*"
                                      "*Apropos*"
                                      "*Help*"
                                      "*cvs*"
                                      "*Buffer List*"
                                      "*Ibuffer*"
                                      "*esh command on file*"))
  :config
  (winner-mode )
  )

(use-package resize-window
  :init
  (defvar resize-window-dispatch-alist
    '((?n resize-window--enlarge-down " Resize - Expand down" t)
      (?p resize-window--enlarge-up " Resize - Expand up" t)
      (?f resize-window--enlarge-horizontally " Resize - horizontally" t)
      (?b resize-window--shrink-horizontally " Resize - shrink horizontally" t)
      (?r resize-window--reset-windows " Resize - reset window layout" nil)
      (?w resize-window--cycle-window-positive " Resize - cycle window" nil)
      (?W resize-window--cycle-window-negative " Resize - cycle window" nil)
      (?2 split-window-below " Split window horizontally" nil)
      (?3 split-window-right " Slit window vertically" nil)
      (?0 resize-window--delete-window " Delete window" nil)
      (?K resize-window--kill-other-windows " Kill other windows (save state)" nil)
      (?y resize-window--restore-windows " (when state) Restore window configuration" nil)
      (?? resize-window--display-menu " Resize - display menu" nil))
    )
  )

;; Quickly switch windows
(use-package ace-window
  :bind (
	 ("C-x o" . ace-window)
	 )
  :defer 1
  :init
  (defvar aw-dispatch-alist
    '(
      "Actions"
      (?x aw-delete-window "Delete Window")
      (?o delete-other-windows "Delete Other Windows")
      (?s aw-swap-window "Swap Windows")
      (?m aw-move-window "Move Window")
      (?c aw-copy-window "Copy Window")
      (?j aw-switch-buffer-in-window "Select Buffer")
      "Split"
      (?v aw-split-window-horz "Split right Window")
      (?h aw-split-window-vert "Split verti Window")
      (?F aw-split-window-fair "Split Fair Window")
      "others"
      (?f aw-flip-window)
      (?e aw-execute-command-other-window "Execute Command Other Window")
      (?T aw-transpose-frame "Transpose Frame")
      ;; ?i ?r ?t are used by hyperbole.el
      )
    )
  :config
  (set-face-attribute
   'aw-leading-char-face nil
   :foreground "deep sky blue"
   :weight 'bold
   :height 3.0)
  (set-face-attribute
   'aw-mode-line-face nil
   :inherit 'mode-line-buffer-id
   :foreground "lawn green")
  (setq
   aw-dispatch-always t
   )
  (ace-window-display-mode t)
  )


;; Enforce rules for popups
(use-package popper
  :defines popper-echo-dispatch-actions
  :autoload popper-group-by-directory
  :bind (:map popper-mode-map
         ("C-h z"     . popper-toggle-latest)
         ("C-<tab>"   . popper-cycle)
         ("C-M-<tab>" . popper-toggle-type))
  :hook (emacs-startup . popper-mode)
  :init
  (setq popper-group-function #'popper-group-by-directory)
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$" "\\*Pp Eval Output\\*$"
          "^\\*eldoc.*\\*$"
          "\\*Compile-Log\\*"
          "\\*Completions\\*"
          "\\*Warnings\\*"
          "\\*Async Shell Command\\*"
          "\\*Apropos\\*"
          "\\*Backtrace\\*"
          "\\*Calendar\\*"
          "\\*Finder\\*"
          "\\*Kill Ring\\*"
          "\\*Go-Translate\\*"
          "\\*Embark \\(Collect\\|Live\\):.*\\*"

          bookmark-bmenu-mode
          comint-mode
          compilation-mode
          help-mode helpful-mode
          tabulated-list-mode
          Buffer-menu-mode

          flymake-diagnostics-buffer-mode
          flycheck-error-list-mode flycheck-verify-mode

          gnus-article-mode devdocs-mode
          grep-mode occur-mode rg-mode deadgrep-mode ag-mode pt-mode
          youdao-dictionary-mode osx-dictionary-mode fanyi-mode

          "^\\*Process List\\*" process-menu-mode
          list-environment-mode cargo-process-mode

          "^\\*eshell.*\\*.*$"       eshell-mode
          "^\\*shell.*\\*.*$"        shell-mode
          "^\\*terminal.*\\*.*$"     term-mode
          "^\\*vterm[inal]*.*\\*.*$" vterm-mode

          "\\*DAP Templates\\*$" dap-server-log-mode
          "\\*ELP Profiling Restuls\\*" profiler-report-mode
          "\\*Paradox Report\\*$" "\\*package update results\\*$" "\\*Package-Lint\\*$"
          "\\*[Wo]*Man.*\\*$"
          "\\*ert\\*$" overseer-buffer-mode
          "\\*gud-debug\\*$"
          "\\*lsp-help\\*$" "\\*lsp session\\*$"
          "\\*quickrun\\*$"
          "\\*tldr\\*$"
          "\\*vc-.*\\*$"
          "^\\*macro expansion\\**"

          "\\*Agenda Commands\\*" "\\*Org Select\\*" "\\*Capture\\*" "^CAPTURE-.*\\.org*"
          "\\*Gofmt Errors\\*$" "\\*Go Test\\*$" godoc-mode
          "\\*docker-.+\\*"
          "\\*prolog\\*" inferior-python-mode inf-ruby-mode swift-repl-mode
          "\\*rustfmt\\*$" rustic-compilation-mode rustic-cargo-clippy-mode
          rustic-cargo-outdated-mode rustic-cargo-run-mode rustic-cargo-test-mode))

  (with-eval-after-load 'doom-modeline
    (setq popper-mode-line
          '(:eval (let ((face (if (doom-modeline--active)
                                  'mode-line-emphasis
                                'mode-line-inactive)))
                    (if (and (icons-displayable-p)
                             (bound-and-true-p doom-modeline-mode))
                        (format " %s "
                                (nerd-icons-octicon "nf-oct-pin" :face face))
                      (propertize " POP" 'face face))))))

  (setq popper-echo-dispatch-actions t)
  :config
  (popper-echo-mode 1)

  (with-no-warnings
    (defun my-popper-fit-window-height (win)
      "Determine the height of popup window WIN by fitting it to the buffer's content."
      (fit-window-to-buffer
       win
       (floor (frame-height) 3)
       (floor (frame-height) 3)))
    (setq popper-window-height #'my-popper-fit-window-height)

    (defun popper-close-window-hack (&rest _)
      "Close popper window via `C-g'."
      ;; `C-g' can deactivate region
      (when (and (called-interactively-p 'interactive)
                 (not (region-active-p))
                 popper-open-popup-alist)
        (let ((window (caar popper-open-popup-alist)))
          (when (window-live-p window)
            (delete-window window)))))
    (advice-add #'keyboard-quit :before #'popper-close-window-hack))
  )

(provide 'init-window)
