;;; ../../../usr/home/alex/dotfiles/doom-emacs/.doom.d/+music.el -*- lexical-binding: t; -*-

;; ----- Emms
;; NB : :commands allow to load emms only when needed. Also `(require)' is replaced by def-package
(map!
 (:leader
  (:prefix-map ("o" . "open")
   (:desc "Emms" "m" #'emms)
   )))

;; -- Emms with mpd has some bugs being corrected, so we use dired + emms
(after! emms
  :config
  (map! :map dired-mode-map :n "M" 'emms-add-dired)
  )
