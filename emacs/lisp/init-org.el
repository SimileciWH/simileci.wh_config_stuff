
(setq org-return-follows-link t)

(use-package org
  :ensure nil
  :init
  (setq org-directory "/Volumes/SS980/SWStuff/OneDrive/WinMacSwapStuff/org_dir"
	org-enforce-todo-dependencies t
	org-enforce-todo-checkbox-dependencies t
	org-log-done 'time
	;; Tags setting
	org-use-tag-inheritance nil
	;; property
	;; org-use-property-inheritance
	;;time stamps
	org-deadline-warning-days 7
	org-image-actual-width nil
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

(use-package org-download
    :demand t
    :after org
    :hook (dired-mode . org-download-enable)
    :config
    (cond  (*is-mac*

	    )
	   (*is-windows*
	    (setq org-download-screenshot-method "powershell -c Add-Type -AssemblyName System.Windows.Forms;$image = [Windows.Forms.Clipboard]::GetImage();$image.Save('%s', [System.Drawing.Imaging.ImageFormat]::Png)")

	    )
	   (t "need check for linux")
	   
	   )
 
    (defun org-download-annotate-default (link)
      "Annotate LINK with the time of download."
      (make-string 0 ?\s))

    (setq-default org-download-heading-lvl nil
		  org-download-image-dir "./img"
		  ;; org-download-screenshot-method "screencapture -i %s"
		  org-download-screenshot-file (expand-file-name "screenshot.jpg" temporary-file-directory)
		  )

    )



(provide 'init-org)