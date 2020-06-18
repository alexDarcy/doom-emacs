;;; ~/dotfiles/doom-emacs/.doom.d/+dired.el -*- lexical-binding: t; -*-

; Minimalist deer
(after! ranger
  :config
  (setq ranger-deer-show-details nil))

; Default shell actions (we use ranger so we lost the defaults
(after! dired-x
  :when (featurep! +ranger)
  :config
  (setq dired-guess-shell-alist-user
                '(("\\.mkv\\'" "mplayer"))))
