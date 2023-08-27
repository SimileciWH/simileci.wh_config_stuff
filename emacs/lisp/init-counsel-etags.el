
(use-package counsel-etags
  :init
  (add-hook 'prog-mode-hook
        (lambda ()
          (add-hook 'after-save-hook
		    'counsel-etags-virtual-update-tags 'append 'local))
	)
  (setq
   counsel-etags-update-interval 60
   ;; counsel-etags-extra-tags-files '("D/work_space/rl6643_pipeline_b/TAGS")
   )
  :config
  ;; we need view build dir dont ignore
  ;; (push "build" counsel-etags-ignore-directories)
  (with-eval-after-load 'counsel-etags
    ;; counsel-etags-ignore-directories does NOT support wildcast
    (push "build_clang" counsel-etags-ignore-directories)
    (push "build_clang" counsel-etags-ignore-directories)
    (push "cppcheck-cppcheck-build-dir" counsel-etags-ignore-directories)
    (push "alg" counsel-etags-ignore-directories)
    (push "obj" counsel-etags-ignore-directories)
    (push "si" counsel-etags-ignore-directories)
    ;; counsel-etags-ignore-filenames supports wildcast
    (push "TAGS" counsel-etags-ignore-filenames)
    (push "*.json" counsel-etags-ignore-filenames)
    (push "*.json" counsel-etags-ignore-filenames)
    (push "*.log" counsel-etags-ignore-filenames)
    (push "*.cppcheck" counsel-etags-ignore-filenames)
    )
  (defun h_wang/counsel-extra-tags()
    (cond (*is-windows*
	   (setq counsel-etags-extra-tags-files '("D/work_space/rl6643_pipeline_b/TAGS")))
	  (*is-mac*
	   (setq counsel-etags-extra-tags-files '("/Volumes/SS980/work_space/unicore/TAGS")))
	  (t "need check for linux")
	  )
    )
  (defun h_wang/counsel-ignore-files()
    (cond (*is-windows*
	   (setq counsel-etags-ignore-config-files '("e:/OneDrive/WinMacSwapStuff/git/.gitignore")))
	  (*is-mac*
	   (setq counsel-etags-ignore-config-files '("/Volumes/SS980/SWStuff/OneDrive/WinMacSwapStuff/git/.gitignore")))
	  (t "need check for linux")
	  )
    )
  (h_wang/counsel-ignore-files)
  (h_wang/counsel-extra-tags)
  (defun my-update-tags-file (tags-file)
    "Update TAGS-FILE."
    (when (memq major-mode '(pron-mode))
      (let ((s3 (mapconcat (lambda (tagname)
                             (counsel-etags-tag-line tagname tagname 0))
                           '(current-time-string
			     *is-mac* *is-windows* *is-linux*) "")))
	(counsel-etags-append-to-tags-file
	 (list (cons "Append content(by simileci.WH):%s" s3))
	 tags-file)))
    )
  (add-hook 'counsel-etags-after-update-tags-hook 'my-update-tags-file)

  ;; auto update tags file
  ;; Don't ask before rereading the TAGS files if they have changed
  (setq tags-revert-without-query t)
  ;; Don't warn when TAGS files are large
  (setq large-file-warning-threshold nil)
  ;; Setup auto update now
  (add-hook 'prog-mode-hook
	    (lambda ()
	      (add-hook 'after-save-hook
			'counsel-etags-virtual-update-tags 'append 'local)))
  )

(use-package counsel
  ;; https://oremacs.com/swiper/
  :init
  ;; (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "
	ivy-re-builders-alist
	'((t . ivy--regex-plus))
	
	)
  :config
  ;; (ivy-mode 1)
  )



(provide 'init-counsel-etags)
