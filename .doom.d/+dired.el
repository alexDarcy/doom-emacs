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
  :when (featurep! +ranger)
  :config
  (setq dired-guess-shell-alist-user
        '(("\\.webm\\'" "mpv")
          ("\\.docx\\'" "libreoffice")))
  ; Hide dot files
  (setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
  ;
  )
