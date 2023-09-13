
(setq org-return-follows-link t)

(use-package org
  :ensure nil
  :init
  ;; . is reprenst for org-directory
  (setq org-directory (concat  *WinMac-PATH* "/org_dir")
	org-agenda-files (list (concat org-directory "/agenda"))
	)
  (setq org-capture-templates
	'(
	  ("1" "Important&Urgency" entry (file "./agenda/1_important_and_urgency.todo.org")
	   "* TODO [#5] %?\n  %i\n %U"
	   :empty-lines 1)
	  ("2" "!Important&Urgency" entry (file "./agenda/2_not_important_but_urgency.todo.org")
	   "* TODO [#5] %?\n  %i\n %U"
	   :empty-lines 1)
	  ("3" "Important&!Urgency" entry (file "./agenda/3_important_but_not_urgency.todo.org")
	   "* TODO [#5] %?\n  %i\n %U"
	   :empty-lines 1)
	  ("4" "!Important&!Urgency" entry (file "./agenda/4_not_important_and_not_urgency.todo.org")
	   "* TODO [#5] %?\n  %i\n %U"
	   :empty-lines 1)
	  )
	)
  (setq	org-enforce-todo-dependencies t
	org-enforce-todo-checkbox-dependencies t
	org-agenda-span 'day
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

  (setq org-tag-alist '(("work") ("basic_skills") ("improve") ("meeting")
			("learn") ("suspend") ("processing") ("waitting") ("pending") ("canceled") ("know")
			("bash") ("c") ("elisp") ("spi") ("spic") ("fcv2") ("fcv3") ("ftl") ("llf") ("RDT") ("ROM") ("RISCV") ("MIPS") 
			("@customer") ("@WK") ("@XKR") ("@HJ")
			("xg_yang") ("cy_tang") ("yl_zhang") ("zq_zhu") ("c_zhao") ("jl_jin") ("j_luo") ("h_wang")
			
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
	    (setq org-download-screenshot-method "screencapture -i %s")

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
		  org-download-screenshot-file (expand-file-name "screenshot.jpg" temporary-file-directory)
		  )

    )

(use-package org-contrib
  :pin nongnu
  :config
  (require 'org-checklist)
  ;; need repeat task and properties
  (setq org-log-into-drawer t)
  )

(provide 'init-org)
