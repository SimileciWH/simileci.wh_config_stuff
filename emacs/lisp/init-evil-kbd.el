(define-key evil-insert-state-map (kbd "C-[") 'evil-normal-state)
(define-key evil-normal-state-map (kbd "[ SPC") (lambda () (interactive) (evil-insert-newline-above) (forward-line)))
(define-key evil-normal-state-map (kbd "] SPC") (lambda () (interactive) (evil-insert-newline-below) (forward-line -1)))

(define-key evil-normal-state-map (kbd "[ b") 'previous-buffer)
(define-key evil-normal-state-map (kbd "] b") 'next-buffer)
(define-key evil-motion-state-map (kbd "[ b") 'previous-buffer)
(define-key evil-motion-state-map (kbd "] b") 'next-buffer)

(define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)

;; code review
(define-key evil-normal-state-map (kbd "gr") 'xref-find-references)
(define-key evil-normal-state-map (kbd "g-") 'xref-go-forward)
(define-key evil-normal-state-map (kbd "g=") 'xref-go-back)

(define-key evil-visual-state-map (kbd "gr") 'xref-find-references)
(define-key evil-visual-state-map (kbd "g-") 'xref-go-forward)
(define-key evil-visual-state-map (kbd "g=") 'xref-go-back)



(evil-define-key 'normal dired-mode-map
  (kbd "<RET>") 'dired-find-alternate-file
  (kbd "C-k") 'dired-up-directory
  )

(provide 'init-evil-kbd)
