;;; ~/dotfiles/doom-emacs/.doom.d/torrents.el -*- lexical-binding: t; -*-

;; read torrents from rtorrent daemon
(after! mentor
  :init
  (setq mentor-rtorrent-external-rpc "/torrents/rtorrent.sock")
  (map!
   :map mentor-mode-map

   ;; download list actions
   :nm "DEL" 'mentor-download-load-torrent
   :nm "l" 'mentor-download-load-magnet-link-or-url
   :nm "g" 'mentor-update
   :nm "G" 'mentor-reload
   :nm "M-g" 'mentor-update-item

   ;; item actions
   :nm "+" 'mentor-increase-priority
   :nm "-" 'mentor-decrease-priority

   ;; single download actions
   :nm "C" 'mentor-download-copy-data
   :nm "R" 'mentor-download-move
   :nm "b" 'mentor-download-set-inital-seeding
   :nm "e" 'mentor-download-set-create-resized-queued-flags
   :nm "o" 'mentor-download-change-target-directory
   :nm "d" 'mentor-download-stop
   :nm "D" 'mentor-download-remove
   :nm "k" 'mentor-download-close
   :nm "K" 'mentor-download-remove-including-files
   :nm "r" 'mentor-download-hash-check
   :nm "s" 'mentor-download-start
   :nm "x" 'mentor-call-command

   ;; misc actions
   :nm "RET" 'mentor-show-download-files
   :nm "TAB" 'mentor-toggle-item

   :nm "m" 'mentor-mark
   :nm "u" 'mentor-unmark
   :nm "M" 'mentor-mark-all
   :nm "U" 'mentor-unmark-all

   :nm "v" 'mentor-dired-jump

   ;; sort functions
   :nm "t c" 'mentor-sort-by-state
   :nm "t D" 'mentor-sort-by-directory
   :nm "t d" 'mentor-sort-by-download-speed
   :nm "t n" 'mentor-sort-by-name
   :nm "t p" 'mentor-sort-by-property-prompt
   :nm "t s" 'mentor-sort-by-size
   :nm "t t" 'mentor-sort-by-tied-file-name
   :nm "t u" 'mentor-sort-by-upload-speed

   :nm "q" 'bury-buffer
   :nm "Q" 'mentor-shutdown

   ;; view bindings
   :nm "a" 'mentor-add-torrent-to-view
   :nm "w" 'mentor-switch-to-view
   :nm "1" 'mentor-switch-to-view-1
   :nm "2" 'mentor-switch-to-view-2
   :nm "3" 'mentor-switch-to-view-3
   :nm "4" 'mentor-switch-to-view-4
   :nm "5" 'mentor-switch-to-view-5
   :nm "6" 'mentor-switch-to-view-6
   :nm "7" 'mentor-switch-to-view-7
   :nm "8" 'mentor-switch-to-view-8
   :nm "9" 'mentor-switch-to-view-9
   :nm "0" 'mentor-switch-to-view-0
   ))
