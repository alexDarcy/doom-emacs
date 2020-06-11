;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Warning: using emacs daemon + emacsclient -nc lose the highlight. So we need
;; to reload the theme each time we start a new emacs.
;; SPC h r t (or M-x doom/reload-theme)
(load-theme 'doom-one t)
(setq doom-one-brighter-comments t) ;; We want the comments visible

;; Modules
(load! "+bepo") ; Adapt to bepo keyboard layout
(load! "+mail") ; Mail configuration
(load! "+org") ; Org configuration
(load! "+torrents") ; Org configuration

;; French
(setq calendar-week-start-day 1)
(setq ispell-dictionary "fr")

; TODO : activate more properly ? Doom is lazy
;; Sometimes magit ask for SSH passphrase... Use keychain to avoid that
(keychain-refresh-environment)

(add-to-list 'exec-path "/home/alex/.local/bin/")

;; No delay for completion
(after! company
  :config
  (setq company-idle-delay 0))


(after! eshell
  (require 'em-tramp) ; to load eshell’s sudo
  ;; Switch to eshell’s sudo to avoid typing the password each time
  (setq eshell-prefer-lisp-functions t)
  ;; Aliases do not seem to be written on file...
  (set-eshell-alias!
   "sudo"  "eshell/sudo $*")

  ;;   ;; Fish completion in eshell.
  ;;   ;; The doc tells us to use "nil t" as argument but it does not work in doom...
  ;;   (when (and (executable-find "fish")
  ;;              (require 'fish-completion)
  ;;              (global-fish-completion-mode))))
  )

;; ----- Emms
;; NB : :commands allow to load emms only when needed. Also `(require)' is replaced by def-package
(map!
 (:leader
  (:prefix-map ("o" . "open")
   (:desc "Emms" "m" #'emms))))

(use-package! emms-setup
  :commands (emms)
  :config
  (emms-standard)
  (emms-default-players)
  (setq emms-source-file-default-directory "/Data/Music/"))

;; LSP
;; Haskell : using ghcide instead of haskell-ide (completion hangs when using it...)
(after! lsp-haskell
  :config
  (setq lsp-haskell-process-path-hie "ghcide")
  (setq lsp-haskell-process-args-hie '())
  ;; Comment/uncomment this line to see interactions between lsp client/server.
  ;;(setq lsp-log-io t)
  )

;; ---- ERC
;; A helper function to auto-start bitlbee
(defun bitlbee-start ()
  (interactive)
  (erc :server "localhost" :port 6667 :nick "alex" :password "sharingan"))

;; Here we start ERC at boot, with the password here for minimal coding
(use-package! erc
  ;; Bitlbee by default
  :commands (bitlbee-start)
  :init
  (map!
   (:leader
    (:prefix "o"
     (:desc "Chat (bitlbee)" "c" 'bitlbee-start)
     (:desc "Gnus" "g" 'gnus))))
  :config
  ;; Autojoin must be done inside bitlbee directly
  (setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
  )

;; Circe + bitlbee does not work
;; (after! irc
;;    (set-irc-server! "Bitlbee"
;;      '(:host "localhost" :port 6667
;;             :nick "alex"
;;             :nickserv-password "sharingan"
;;             :nickserv-identify-challenge "use the \x02identify\x02 command to identify yourself"
;;             :nickserv-identify-command "PRIVMSG &bitlbee :identify {password}"
;;             :nickserv-identify-confirmation "Password accepted, settings and accounts loaded"
;;             :lagmon-disabled t)))
;; (use-package! circe
;;   :config
;;   (setq circe-network-options
;;    '(("Bitlbee"
;;       :host "localhost" :port 6667
;;       :nick "alex"
;;       :nickserv-password "sharingan"
;;       :nickserv-identify-challenge "use the \x02identify\x02 command to identify yourself"
;;       :nickserv-identify-command "PRIVMSG &bitlbee :identify {password}"
;;       :nickserv-identify-confirmation "Password accepted, settings and accounts loaded"
;;       :lagmon-disabled t))))


;; ;; Reading RSS feeds : not longeur
;; ;; Issue with org config
;; (use-package! elfeed
;;   :init
;;   (map!
;;    (:leader
;;      (:prefix "o"
;;        (:desc "RSS" "R" 'elfeed))))
;;   :config
;;   (elfeed-org)
;;   (setq rmh-elfeed-org-files (list "~/.doom.d/rss.org"))
;;   (setq-default elfeed-search-filter "@2-days-ago +unread ")
;; )

