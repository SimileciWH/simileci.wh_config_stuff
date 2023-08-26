(defcustom centaur-completion-style 'childframe
  "Completion display style."
  :group 'centaur
  :type '(choice (const :tag "Minibuffer" minibuffer)
                 (const :tag "Child Frame" childframe))
  )

(provide 'init-custom)
