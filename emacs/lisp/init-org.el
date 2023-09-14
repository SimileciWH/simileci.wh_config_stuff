
(setq org-return-follows-link t)

(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil))
  )
(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil))
  )

(use-package org
  :ensure nil
  :init
  ;; . is reprenst for org-directory
  (setq org-directory (concat  *WinMac-PATH* "/org_dir")
	org-agenda-files (list (concat org-directory "/agenda"))
	)
  (setq org-capture-templates
	'(
	  ("1" "IMPT&Urgency" entry (file "./agenda/1_IMPT_UGY.org")
	   "* TODO [#5] %?\n  %i\n %U"
	   :empty-lines 1)
	  ("2" "!IMPT&Urgency" entry (file "./agenda/2_Not_IMPT_UGY.org")
	   "* TODO [#5] %?\n  %i\n %U"
	   :empty-lines 1)
	  ("3" "IMPT&!Urgency" entry (file "./agenda/3_IMPT_Not_UGY.org")
	   "* TODO [#5] %?\n  %i\n %U"
	   :empty-lines 1)
	  ("4" "!IMPT&!Urgency" entry (file "./agenda/4_Not_IMPT_Not_UGY.org")
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
	'((sequence "TODO(t)" "MEETING" "|" "DONE(d!)")
	  (sequence "BUG(b@)" "REPORT(r!)" "VERIFY(v)" "ASSIGN(a)" "|" "FIXED(f@/!)")
	  (sequence "|" "SUSPEND(s@/!)" "CANCELED(c@)" "WAITTING(w@/!)")

	  )
	)
  (setq org-todo-keyword-faces
	(quote (("TODO" :foreground "goldenrod1" :weight bold)
		("DONE" :foreground "SpringGreen2" :weight bold)
		("FIXED" :foreground "SpringGreen2" :weight nil)
		("VERIFY" :foreground "Yellow" :weight bold)
		("ASSIGN" :foreground "LightSalmon1" :weight bold)
		("WAITING" :foreground "LightSalmon1" :weight bold)
		("CANCELLED" :foreground "LavenderBlush4" :weight bold)
		("MEETING" :foreground "IndianRed1" :weight bold))
	       )
	)
  (setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("SUSPEND" ("WAITING") ("SUSPEND" . t))
              (done ("WAITING") ("SUSPEND"))
              ("TODO" ("WAITING") ("CANCELLED") ("SUSPEND"))
              ("DONE" ("WAITING") ("CANCELLED") ("SUSPEND"))
              ("FIXED" ("WAITING") ("CANCELLED") ("SUSPEND")))
	     )
      )
  (setq org-tag-alist '(("work") ("basic_skills") ("improve") ("meeting")
			("learn") ("suspend") ("processing") ("waitting")
			("pending") ("canceled") ("know")
			
			("bash") ("c") ("elisp") ("spi") ("spic") ("fcv2")
			("fcv3") ("ftl") ("llf") ("RDT") ("ROM") ("RISCV") ("MIPS") 

			("@customer") ("@WK") ("@XKR") ("@HJ")
			("xg_yang") ("cy_tang") ("yl_zhang") ("zq_zhu")
			("c_zhao") ("jl_jin") ("j_luo") ("h_wang")
			
			)
	)
  (setq org-agenda-custom-commands
	'(("d" "Daily agenda and all TODOs"
           ((tags "PRIORITY=\"A\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "High-priority unfinished tasks:")))
            (agenda "" ((org-agenda-ndays 1)))
            (alltodo ""
                     ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                     (air-org-skip-subtree-if-priority ?A)
                                                     (org-agenda-skip-if nil '(scheduled deadline))))
                      (org-agenda-overriding-header "ALL normal priority tasks:"))))
           ((org-agenda-compact-blocks t)))))
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
