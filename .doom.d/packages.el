;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! openwith) ;; open PDF automatically
(package! emms) ;; Manage music
(package! ess) ;; R in emacs
(package! evil-numbers) ; Increment numbers as in vim
(package! fish-mode)
(package! fish-completion) ; For eshell
(package! gist) ; Github gist
;; (package! helm-org-rifle) ;; Search org files easily
;; (package! hyperbole) ;; Hard do describe
(package! keychain-environment) ;; Avoid typing SSH passphrase
;; (package! mentor) ; Manage torrents from emacs
(package! ob-async) ; Execute code block asynchronsly
(package! org-ml) ; Functionnal programming in org
(package! org-chef) ; Get recipes in org mode
(package! org-ref) ;; Manage a reading list. Error with void function....
(package! org-roam) ;; Note-taking workflow
(package! org-super-agenda) ;; Better agenda : group by tags and so on
(package! projectile-ripgrep) ; I like ripgrep
(package! simple-mpc) ; I like ripgrep
;; (package! zetteldeft) ; manage Note-taking
;; (package! ytdl) ; interface to youtupe-dl
(package! yasnippet-snippets) ; List of snippets

;; (package! docker-tramp) ; TRAMP request in docker (also used for org mode  code blocks)
;;; Examples:

;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)
