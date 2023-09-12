(eval-after-load 'consult
  '(eval-after-load 'embark
     '(progn (require 'embark-consult)
	(add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode))))
(defun embark-export-write ()
  "Export the current vertico results to a writable buffer if possible.
supports exporting consult-grep to wgrep, file to wdeired, and consult-location to occur-edit"
  (interactive)
  (require 'embark)
  (require 'wgrep)
  (pcase-let ((`(,type . , candidates)
               (run-hook-with-args-until-success 'embark-candidate-collectors)))
    (pcase type
      ('consult-grep (let ((embark-after-export-hook #'wgrep-change-to-wgrep-mode))
                       (embark-export)))
      ('file (let ((embark-after-export-hook #'wdired-change-to-wdired-mode))
               (embark-export)))
      ('consult-location (let ((embark-after-export-hook #'occur-edit-mode))
                           (embark-export)))
      (x (user-error "embark category %S doesn't support writable export" x)))))


(defun my/search-project-for-symbol-at-point ()
  (interactive)
  (if (use-region-p)
      (progn
	(consult-ripgrep (project-root (project-current))
			 (buffer-substring (region-beginning) (region-end)))))
  )




(defvar astyle-command "astyle --style=allman --max-code-length=100 --pad-oper")
(defun astyle-region(start end)
  "Run astyle on region or buffer"
  (interactive (if mark-active
		   (list (region-beginning) (region-end))
		 (list (point-min) (point-max))
		 ))
  (save-restriction
    (shell-command-on-region start end
			     astyle-command
			     (current-buffer) t
			     (get-buffer-create "*Astyle Errors*") t)
    )
  )

(defun h_wang/emacs-frame-change ()
  (if (window-system nil)
      (progn
	;; top, left ... must be integer
	(add-to-list 'default-frame-alist
                     (cons 'top  (/ (x-display-pixel-height) 10)))
	(add-to-list 'default-frame-alist
                     (cons 'left (/ (x-display-pixel-width) 10)))
	(add-to-list 'default-frame-alist
                     (cons 'height (/ (* 4 (x-display-pixel-height))
                                      (* 5 (frame-char-height)))))
	(add-to-list 'default-frame-alist
                     (cons 'width (/ (* 4 (x-display-pixel-width))
                                     (* 5 (frame-char-width)))))
	)
    )
  )

(defun h_wang/scroll-bar-mode ()
  (if (window-system)
      (scroll-bar-mode -1)
    )
  )

(defun h_wang/insert-new-line-next ()
  (interactive)
  (move-end-of-line 1)
  (open-line 1)
  (next-line 1)
  )
(defun h_wang/insert-new-line-previous ()
  (interactive)
  (move-beginning-of-line 1)
  (open-line 1)
  )
(defun h_wang/kill-cur-line-string ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line 1)
  )



(provide 'init-func)
