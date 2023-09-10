
(use-package org
  :ensure nil
  :init
  (setq org-directory "/Volumes/SS980/SWStuff/OneDrive/WinMacSwapStuff/org_dir"
	org-enforce-todo-dependencies t
	org-enforce-todo-checkbox-dependencies t
	org-log-done 'time
	;; Tags setting
	org-use-tag-inheritance nil
	)
  (setq org-todo-keywords
	'((sequence "TODO(t)" "|" "DONE(d!)")
	  (type "cy_tang(c)" "yl_zhang(y)" "xg_yang(x)" "zq_zhu(z)" "|")
	  (sequence "VERIFY(v)" "ASSIGN(a)" "|" "FIXED(f@/!)")
	  (sequence "|" "SUSPEND(s@/!)" "CANCELED(c@)")

	  )
	)
  (setq org-todo-keyword-faces
	'(("TODO" . org-warning) ("STARTED" . "yellow")
          ("CANCELED" . (:foreground "blue" :weight bold))
          ("SUSPEND" . (:foreground "blue" :weight nil))
	  )
	)
  (setq org-tag-alist '((:startgrouptag)
			("purpose")
			(:grouptags)
			("@work" . ?w)
			("@basic_skills" . ?s)
			("@improve"" . ?i")
			(:endgrouptag)
			(:startgrouptag)
			("status")
			(:grouptags)
			("learn" . ?l)
			("done". ?d)
			("canceled" . ?c)
			("suspended". ?h)
			("pending" . ?p)
			("know" . ?k)
			(:endgrouptag)
			)
	)
  :config
  (defun org-summary-todo (n-done n-not-done)
    "Switch entry to DONE when all subentries are done, to TODO otherwise."
    (let (org-log-done org-log-states)   ; turn off logging
      (org-todo (if (= n-not-done 0) "DONE" "TODO")))
    )

  (add-hook 'org-after-todo-statistics-hook #'org-summary-todo)
  )
  


(provide 'init-org)
