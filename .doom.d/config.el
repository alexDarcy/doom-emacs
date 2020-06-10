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


;; Projectile
(map!
 (:leader
  (:prefix-map ("p" . "project")
   :desc "Rg"               "g" #'counsel-projectile-rg
   )
  )
 )

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

;; ----- Deft to manage notes
(after! deft
  :config
  (setq deft-directory "~/projects/blog/notes")
  (setq deft-extensions '("org"))
  ;; BUG in title with zetteldeft
  ;; 1. id is in the title
  ;; https://github.com/EFLS/zetteldeft/issues/41
  ;; TODO : there is still a space in the filename... (cf github issue)
  (setq deft-file-naming-rules '((noslash . "-")))
  ;; 2. Conflicts with doom : duplicate title
  (set-file-template! 'org-mode :ignore t))

;; Zetteldeft on top of deft
(use-package zetteldeft
  :ensure t
  :after deft
  :init
  (map! :leader
        :prefix ("d" . "zetteldeft")
        :desc "deft" "d" #'deft
        :desc "zetteldeft-deft-new-search" "D" #'zetteldeft-new-file
        :desc "deft-refresh" "R" #'deft-refresh
        :desc "zetteldeft-search-at-point" "s" #'zetteldeft-search-at-point
        :desc "zetteldeft-search-current-id" "c" #'zetteldeft-search-current-id
        :desc "zetteldeft-follow-link" "f" #'zetteldeft-follow-link
        :desc "zetteldeft-avy-file-search-ace-window" "F" #'zetteldeft-avy-file-search-ace-window
        :desc "zetteldeft-avy-link-search" "l" #'zetteldeft-avy-link-search
        :desc "zetteldeft-avy-tag-search" "t" #'zetteldeft-avy-tag-search
        :desc "zetteldeft-tag-buffer" "T" #'zetteldeft-tag-buffer
        :desc "zetteldeft-find-file-id-insert" "i" #'zetteldeft-find-file-id-insert
        :desc "zetteldeft-find-file-full-title-insert" "I" #'zetteldeft-find-file-full-title-insert
        :desc "zetteldeft-find-file" "o" #'zetteldeft-find-file
        :desc "zetteldeft-new-file" "n" #'zetteldeft-new-file
        :desc "zetteldeft-new-file-and-link" "N" #'zetteldeft-new-file-and-link
        :desc "zetteldeft-file-rename" "r" #'zetteldeft-file-rename
        :desc "zetteldeft-count-words" "x" #'zetteldeft-count-words)
  :config
)

;; disable smar parens in org mode due to lag
(add-hook 'org-mode-hook #'turn-off-smartparens-mode)

;; Japanes input
(require 'mozc)

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

