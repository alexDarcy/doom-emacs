;;; ../../../usr/home/alex/dotfiles/doom-emacs/.doom.d/+music.el -*- lexical-binding: t; -*-

;; ----- Emms
;; NB : :commands allow to load emms only when needed. Also `(require)' is replaced by def-package
(map!
 (:leader
  (:prefix-map ("o" . "open")
   (:desc "Emms" "m" #'emms)
   )))

;; -- Emms with mpd has some bugs being corrected, so we use dired + emms
(use-package emms
  :config
  (require 'emms-setup)
  (emms-all)
  (emms-default-players)
  (setq emms-source-file-default-directory "/data/music/")

  (map! :map dired-mode-map :n "M" 'emms-add-dired)
  )
