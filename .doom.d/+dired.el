;;; ~/dotfiles/doom-emacs/.doom.d/+dired.el -*- lexical-binding: t; -*-

;; ; Minimalist deer
;; (after! ranger
;;   :config
;;   (setq ranger-deer-show-details nil))
(after! dired
  :config
 ; Clean view by default
  (add-hook! 'dired-mode-hook
    (dired-hide-details-mode )))


; Default shell actions (we use ranger so we lost the defaults
(after! dired-x
  ;; :when (featurep! +ranger)
  :config
  ;; Taken from doom
  ;; Let OS decide how to open certain files
  (when-let (cmd (cond (IS-MAC "open")
                       (IS-LINUX "xdg-open")
                       (IS-BSD "xdg-open")
                       (IS-WINDOWS "start")))
    (setq dired-guess-shell-alist-user
          `(("\\.\\(?:docx\\|pdf\\|djvu\\|eps\\)\\'" ,cmd)
            ("\\.\\(?:jpe?g\\|png\\|gif\\|xpm\\)\\'" ,cmd)
            ("\\.\\(?:xcf\\)\\'" ,cmd)
            ("\\.csv\\'" ,cmd)
            ("\\.tex\\'" ,cmd)
            ("\\.\\(?:mp4\\|mkv\\|avi\\|flv\\|rm\\|rmvb\\|ogv\\)\\(?:\\.part\\)?\\'" ,cmd)
            ("\\.webm\\'" ,cmd)
            ("\\.docx\\'" "libreoffice")
            ("\\.\\(?:mp3\\|flac\\)\\'" ,cmd)
            ("\\.html?\\'" ,cmd)
            ("\\.md\\'" ,cmd)
            )))
  ; Hide dot files
  (setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
  ;
  )
