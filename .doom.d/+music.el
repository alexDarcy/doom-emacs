;;; ../../../usr/home/alex/dotfiles/doom-emacs/.doom.d/+music.el -*- lexical-binding: t; -*-

;; ----- Emms
;; NB : :commands allow to load emms only when needed. Also `(require)' is replaced by def-package
(map!
 (:leader
  (:prefix-map ("o" . "open")
   (:desc "Emms" "m" #'emms)
   )))

;; -- Emms with mpd does not reallay work, see my question https://emacs.stackexchange.com/questions/64532/emms-and-mpd-configuration
(use-package emms
  :config
    (require 'emms-setup)
    (require 'emms-player-mpd)
    (emms-all) ; don't change this to values you see on stackoverflow questions if you expect emms to work
    (setq emms-player-list '(emms-player-mpd))
    (add-to-list 'emms-info-functions 'emms-info-mpd)
    (add-to-list 'emms-player-list 'emms-player-mpd)

    ;; Socket is not supported
    (setq emms-player-mpd-server-name "localhost")
    (setq emms-player-mpd-server-port "6600")
    (setq emms-player-mpd-music-directory "/data/music")
  ;; :bind
  ;;   ("s-m p" . emms)
  ;;   ("s-m b" . emms-smart-browse)
  ;;   ("s-m r" . emms-player-mpd-update-all-reset-cache)
  ;;   ("<XF86AudioPrev>" . emms-previous)
  ;;   ("<XF86AudioNext>" . emms-next)
  ;;   ("<XF86AudioPlay>" . emms-pause)
  ;;   ("<XF86AudioStop>" . emms-stop))
  )
