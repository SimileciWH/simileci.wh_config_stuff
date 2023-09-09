
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")
	(type "cy_tang(c)" "yl_zhang(y)" "xg_yang(x)" "zq_zhu(z)" "|")
	(sequence "VERIFY(v)" "ASSIGN(a)" "|" "FIXED(f)")
	(sequence "|" "SUSPEND(s)" "CANCELED(c)")

	)
      )
(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("STARTED" . "yellow")
        ("CANCELED" . (:foreground "blue" :weight bold))
        ("SUSPEND" . (:foreground "blue" :weight nil))
	)
      )

;; (setq org-todo-keywords '((type "Fred" "Sara" "Lucy" "|" "DONE")))

(provide 'init-org)
