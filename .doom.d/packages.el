;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

(package! emms) ;; Manage music
(package! evil-numbers) ; Increment numbers as in vim
(package! fish-completion) ; For eshell
(package! keychain-environment) ;; Avoid typing SSH passphrase
(package! mentor) ; Manage torrents from emacs
(package! om.el :recipe (:host github :repo "ndwarshuis/om.el"))
(package! org-chef) ; Input in japanese
(package! org-ref) ;; Manage a reading list. Error with void function....
(package! helm-org-rifle) ;; Search org files easily
(package! projectile-ripgrep) ; I like ripgrep
(package! zetteldeft) ; I like ripgrep

;;; Examples:

;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)
