
;; ;; ---- ERC --------
;; ;; Use it if you want bitlbee to work... I could not make circe to work with bitlbee
;; Evil mode should be disabled !
;;
;; ;; ;; A helper function to auto-start bitlbee
;; ;; (defun bitlbee-start ()
;; ;;   (interactive)
;; ;;   (erc :server "localhost" :port 6667 :nick "alex" :password "sharingan"))

;; ;; Here we start ERC at boot, with the password here for minimal coding
;; (use-package! erc
;;   ;; Bitlbee by default
;;   ;; :commands (bitlbee-start)
;;   ;; :init
;;   ;; (map!
;;   ;;  (:leader
;;   ;;   (:prefix "o"
;;   ;;    (:desc "Chat (bitlbee)" "c" 'bitlbee-start)
;;   ;;    (:desc "Gnus" "g" 'gnus))))
;;   :config
;;   ;; Autojoin must be done inside bitlbee directly
;;   (setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
;;   ;; Save password
;;   (load "~/.ercpass")
;;   (require 'erc-services)
;;   (erc-services-mode 1)
;;   (setq erc-prompt-for-nickserv-password nil)
;;   )


;; Otherwise, use circe
;; if you omit =:host=, ~SERVER~ will be used instead.
(after! circe
  :config
  (set-irc-server! "chat.freenode.net"
                   `(:tls t
                     :port 6697
                     :nick "biglama"
                     :sasl-username ,(+pass-get-user "irc/freenode.net")
                     :sasl-password (lambda (&rest _) (+pass-get-secret "irc/freenode.net"))
                     :channels ("#freebsd" "#haskell")))
  (set-irc-server! "myanonamouse.net"
                   `(:tls t
                     :port 6697
                     :nick "fitzwillydarcy"
                     :sasl-username ,(+pass-get-user "irc/myanonamouse.net")
                     :sasl-password (lambda (&rest _) (+pass-get-secret "irc/myanonamouse.net"))
                     :channels (" #anonamouse.net")))
  ;; no joins, quits etc
  (setq circe-reduce-lurker-spam t)
  )
