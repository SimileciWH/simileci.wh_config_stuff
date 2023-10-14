(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))
(cond  (*is-mac*
    (defconst *WinMac-PATH* "/Volumes/SS980/SWStuff/OneDrive/WinMacSwapStuff")
    (defconst *work-space-PATH* "/Volumes/SS980/work_space")
    )
       (*is-windows*
    (defconst *WinMac-PATH* "e:/NewE/OneDrive/WinMacSwapStuff")
    (defconst *work-space-PATH* "d:/work_space")
    )
       (t "need check for linux"

      )

       )
(defadvice align-regexp (around align-regexp-with-spaces activate)
  (let ((old-indent-tabs-mode indent-tabs-mode))
    (setq indent-tabs-mode nil)
    ad-do-it
    (setq indent-tabs-mode old-indent-tabs-mode))
  )

(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (add-hook 'before-save-hook 'whitespace-cleanup)

;; (add-hook 'before-save-hook 'delete-blank-lines)


(provide 'init-const)
