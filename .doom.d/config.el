;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Warning: using emacs daemon + emacsclient -nc lose the highlight. So we need
;; to reload the theme each time we start a new emacs.
;; SPC h r t (or M-x doom/reload-theme)
(load-theme 'doom-one t)
;; (setq doom-one-brighter-comments t) ;; We want the comments visible

(setq doom-font (font-spec :family "Source Code Pro" :size 12))

;; Modules
(load! "+bepo") ; Adapt to bepo keyboard layout
(load! "+dired") ; Dired/ranger configuration
(load! "+exwm") ; Emas as windows manager
(load! "+irc")
(load! "+mail") ; Mail configuration
(load! "+open") ; Opening pdf, movies etc
(load! "+org") ; Org configuration
;; (load! "+torrents") ; mentor configuration
(load! "+music") ; mentor configuration

; Stop asking
(setq large-file-warning-threshold nil)

;; French
(setq calendar-week-start-day 1)
;; Francais does not exist with aspell !
(setq ispell-dictionary "fr")

;; shell-comands fails to run commands with fish shell (commands should be escaped)
;; This impact fd and find in dired for example
(setq shell-file-name "/bin/sh")

 ;; Fast buffer jump
(use-package! frog-jump-buffer)

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
  :config
  (require 'em-tramp) ; to load eshell’s sudo
  ;; Switch to eshell’s sudo to avoid typing the password each time
  (setq eshell-prefer-lisp-functions t)
  ;; Aliases do not seem to be written on file...
  (set-eshell-alias! "sudo"  "eshell/sudo $*")
  (setq password-cache t) ; enable password caching
  (setq password-cache-expiry 3600) ; for one hour (time in secs)
)

;; (after! elfeed
;;   :config
;;   (setq elfeed-feeds
;;         '("https://www.youtube.com/feeds/videos.xml?channel_id=UCJHA_jMfCvEnv-3kRjTCQXw")))
;; ; No flyspell by default
;; (remove-hook! '(org-mode-hook
;;                 markdown-mode-hook
;;                 TeX-mode-hook
;;                 rst-mode-hook
;;                 mu4e-compose-mode-hook
;;                 message-mode-hook
;;                 git-commit-mode-hook)
;;   #'flyspell-mode)

;; (after! ytdl
;;   :config
;;   (setq ytdl-always-query-default-filename "yes"
;;         ytdl-video-folder (expand-file-name "~/videos"))
;;   )

;; (setq pdf-misc-print-program "/usr/bin/lpr")
;; (setq pdf-misc-print-program-args "-PBrother_HL-1110_series")

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
