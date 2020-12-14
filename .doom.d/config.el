;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Warning: using emacs daemon + emacsclient -nc lose the highlight. So we need
;; to reload the theme each time we start a new emacs.
;; SPC h r t (or M-x doom/reload-theme)
(load-theme 'doom-one t)
;; (setq doom-one-brighter-comments t) ;; We want the comments visible

;; (setq doom-font (font-spec :family "MesloLGS NF" :size 12)
      ;; doom-unicode-font (font-spec :family "MesloLGS NF" :size 12)
      ;; doom-variable-pitch-font (font-spec :family "MesloLGS NF")
      ;; )
;; (setq doom-unicode-font doom-font)

;; Modules
(load! "+bepo") ; Adapt to bepo keyboard layout
(load! "+dired") ; Dired/ranger configuration
(load! "+mail") ; Mail configuration
(load! "+org") ; Org configuration
(load! "+torrents") ; mentor configuration

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

;; Disable spell checking by default
(remove-hook 'text-mode-hook #'spell-fu-mode)

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
   (:desc "Emms" "m" #'emms)
   )))

(use-package emms
  :config
    (require 'emms-setup)
    (require 'emms-player-mpd)
    (emms-all) ; don't change this to values you see on stackoverflow questions if you expect emms to work
    ;; (setq emms-seek-seconds 5)
    (setq emms-player-list '(emms-player-mpd))
    (setq emms-info-functions '(emms-info-mpd))
    ;; Socket does not seem to work
    (setq emms-player-mpd-server-name "localhost")
    (setq emms-player-mpd-server-port "6600")
  ;; :bind
  ;;   ("s-m p" . emms)
  ;;   ("s-m b" . emms-smart-browse)
  ;;   ("s-m r" . emms-player-mpd-update-all-reset-cache)
  ;;   ("<XF86AudioPrev>" . emms-previous)
  ;;   ("<XF86AudioNext>" . emms-next)
  ;;   ("<XF86AudioPlay>" . emms-pause)
  ;;   ("<XF86AudioStop>" . emms-stop))
  )

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


; No flyspell by default
(remove-hook! '(org-mode-hook
                markdown-mode-hook
                TeX-mode-hook
                rst-mode-hook
                mu4e-compose-mode-hook
                message-mode-hook
                git-commit-mode-hook)
  #'flyspell-mode)

(after! ytdl
  :config
  (setq ytdl-always-query-default-filename "yes"
        ytdl-video-folder (expand-file-name "~/videos"))
  )

;; Doom disables some latex pairs, here is an example on how to enable them
;; (after! latex
;;   (sp-with-modes '(tex-mode
;;                    plain-tex-mode
;;                    latex-mode
;;                    LaTeX-mode)
;;     (sp-local-pair "\\left(" "\\right)"
;;                    :trigger "\\l("
;;                    :when '(sp-in-math-p)
;;                    :post-handlers '(sp-latex-insert-spaces-inside-pair)))

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

(setq pdf-misc-print-program "/usr/bin/lpr")
(setq pdf-misc-print-program-args "-PBrother_HL-1110_series")

;; Testing ripgrep-all
;; (setq counsel-rg-base-command "rga -M 240 --with-filename --no-heading --line-number --color never %s")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#21242b" "#ff665c" "#7bc275" "#FCCE7B" "#51afef" "#C57BDB" "#5cEfFF" "#bbc2cf"])
 '(custom-safe-themes
   (quote
    ("2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "79278310dd6cacf2d2f491063c4ab8b129fee2a498e4c25912ddaa6c3c5b621e" "9b01a258b57067426cc3c8155330b0381ae0d8dd41d5345b5eddac69f40d409b" "229c5cf9c9bd4012be621d271320036c69a14758f70e60385e87880b46d60780" "f7b230ac0a42fc7e93cd0a5976979bd448a857cd82a097048de24e985ca7e4b2" "4a9f595fbffd36fe51d5dd3475860ae8c17447272cf35eb31a00f9595c706050" "428754d8f3ed6449c1078ed5b4335f4949dc2ad54ed9de43c56ea9b803375c23" default)))
 '(fci-rule-color "#62686E")
 '(jdee-db-active-breakpoint-face-colors (cons "#1c1f24" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1c1f24" "#7bc275"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1c1f24" "#484854"))
 '(objed-cursor-color "#ff665c")
 '(package-selected-packages
   (quote
    (ess tldr org-plus-contrib ob-async camcorder zetteldeft dired-recent fasd bbdb speed-type fortune-cookie ranger pass org-drill org-chef nnir-est mentor fish-completion circe anki-editor)))
 '(pdf-view-midnight-colors (cons "#bbc2cf" "#242730"))
 '(rustic-ansi-faces
   ["#242730" "#ff665c" "#7bc275" "#FCCE7B" "#51afef" "#C57BDB" "#5cEfFF" "#bbc2cf"])
 '(safe-local-variable-values (quote ((org-log-done . time))))
 '(vc-annotate-background "#242730")
 '(vc-annotate-color-map
   (list
    (cons 20 "#7bc275")
    (cons 40 "#a6c677")
    (cons 60 "#d1ca79")
    (cons 80 "#FCCE7B")
    (cons 100 "#f4b96e")
    (cons 120 "#eda461")
    (cons 140 "#e69055")
    (cons 160 "#db8981")
    (cons 180 "#d082ae")
    (cons 200 "#C57BDB")
    (cons 220 "#d874b0")
    (cons 240 "#eb6d86")
    (cons 260 "#ff665c")
    (cons 280 "#d15e59")
    (cons 300 "#a35758")
    (cons 320 "#754f56")
    (cons 340 "#62686E")
    (cons 360 "#62686E")))
 '(vc-annotate-very-old-color nil))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(org-headline-done ((t (:foreground "#5699AF")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
