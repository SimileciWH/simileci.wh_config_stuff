;; init-markdown.el --- Initialize markdown configurations.	-*- lexical-binding: t -*-

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode))
  :init
  (setq markdown-enable-wiki-links t
        markdown-italic-underscore t
        markdown-asymmetric-header t
        markdown-make-gfm-checkboxes-buttons t
        markdown-gfm-uppercase-checkbox t
        markdown-fontify-code-blocks-natively t

        markdown-content-type "application/xhtml+xml"
        markdown-css-paths '("https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css"
                             "https://cdn.jsdelivr.net/gh/highlightjs/cdn-release/build/styles/github.min.css")
        ;; markdown-xhtml-header-content "
;; <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
;; <style>
;; body {
;;   box-sizing: border-box;
;;   max-width: 740px;
;;   width: 100%;
;;   margin: 40px auto;
;;   padding: 0 10px;
;; }
;; </style>

;; <link rel='stylesheet' href='https://cdn.jsdelivr.net/gh/highlightjs/cdn-release/build/styles/default.min.css'>
;; <script src='https://cdn.jsdelivr.net/gh/highlightjs/cdn-release/build/highlight.min.js'></script>
;; <script>
;; document.addEventListener('DOMContentLoaded', () => {
;;   document.body.classList.add('markdown-body');
;;   document.querySelectorAll('pre code').forEach((code) => {
;;     if (code.className != 'mermaid') {
;;       hljs.highlightBlock(code);
;;     }
;;   });
;; });
;; </script>

;; <script src='https://unpkg.com/mermaid@8.4.8/dist/mermaid.min.js'></script>
;; <script>
;; mermaid.initialize({
;;   theme: 'default',  // default, forest, dark, neutral
;;   startOnLoad: true
;; });
;; </script>
;"
        markdown-gfm-additional-languages "Mermaid")

  ;; `multimarkdown' is necessary for `highlight.js' and `mermaid.js'
  (when (executable-find "multimarkdown")
    (setq markdown-command "multimarkdown"))
  :config
  ;; Support `mermaid'
  (add-to-list 'markdown-code-lang-modes '("mermaid" . mermaid-mode))

  (with-no-warnings
    ;; Use `which-key' instead
    (advice-add #'markdown--command-map-prompt :override #'ignore)
    (advice-add #'markdown--style-map-prompt   :override #'ignore)

    ;; Preview with built-in webkit
    (defun my-markdown-export-and-preview (fn)
      "Preview with `xwidget' if applicable, otherwise with the default browser."
      (if (featurep 'xwidget-internal)
          (centaur-webkit-browse-url (concat "file://" (markdown-export)) t)
        (funcall fn))
      )
    (advice-add #'markdown-export-and-preview :around #'my-markdown-export-and-preview)
    )

  ;; Preview via `grip'
  ;; Install: pip install grip
  ;; (use-package grip-mode
  ;;   :defines org-mode-map
  ;;   :hook ((markdown-mode org-mode) . grip-mode)
  ;;   :init
  ;;   (setq
  ;;    grip-update-after-change nil
  ;;    ;; grip-preview-use-webkit t
  ;;    )
  ;;   (when-let ((credential (auth-source-user-and-password "api.github.com")))
  ;;     (setq grip-github-user (car credential)
  ;;           grip-github-password (cadr credential)
  ;; 	    )
  ;;     )
  ;;   )

  ;; Table of contents
  (use-package markdown-toc
    :diminish
    :hook (markdown-mode . markdown-toc-mode)
    :init
    (setq
     markdown-toc-indentation-space 4
     markdown-toc-header-toc-title "\n## Table of Contents"
     markdown-toc-user-toc-structure-manipulation-fn 'cdr
     )
    )
  )

(provide 'init-markdown)
