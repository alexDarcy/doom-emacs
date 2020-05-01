;;; ~/dotfiles/doom-emacs/.doom.d/+mail.el -*- lexical-binding: t; -*-


;; ;;-------------------------------------------------------------------------------
;; Notmuch -- our new client
;; Review : very fast searches. The tag approach is a bit surprising the first time but you can used to it
;; I've found it come back to the basics. You don't need to think about your accounts, folders and so on.
;; Only drawback : it does not move mail, you need a script for that
;; ;;-------------------------------------------------------------------------------
;; Using notmuch for email now. Notmuch does not move email though, see ~/.notmuch/hooks/ for scripts to do that.
;; Shortcut
(use-package! notmuch
  :init
  (map!
   (:leader
     (:prefix "o"
       (:desc "Notmuch" "n" #'notmuch-hello))))
  :config
  (setq sendmail-program  "/usr/bin/msmtp"
        notmuch-archive-tags '("-inbox" "-unread" "+archived")
        notmuch-saved-searches '(
                                 (:name "inbox"   :query "tag:inbox "    :key "i")
                                 (:name "sent"    :query "tag:sent"      :key "s")
                                 (:name "archived":query "tag:archived"  :key "a")
                                 (:name "drafts"  :query "tag:draft"     :key "d"))
        ;; Disable colors to use default (easier on the eyes)
        shr-use-colors nil)

;;  Some mapping are overriden by eval commands so we need to remap them
 (map! (:after notmuch
         (:map notmuch-common-keymap
           :nm "gr"     #'notmuch-refresh-this-buffer)))

  )
