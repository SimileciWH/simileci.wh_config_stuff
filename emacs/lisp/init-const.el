(defconst *is-mac* (eq system-type 'darwin))
(defconst *is-linux* (eq system-type 'gnu/linux))
(defconst *is-windows* (or (eq system-type 'ms-dos) (eq system-type 'windows-nt)))
(cond  (*is-mac*
	(defconst *WinMac-PATH* "/Volumes/SS980/SWStuff/OneDrive/WinMacSwapStuff")
	)
       (*is-windows*
	(defconst *WinMac-PATH* "e:/NewE/OneDrive/WinMacSwapStuff")
	)
       (t "need check for linux"

	  )
       
       )

(provide 'init-const)
