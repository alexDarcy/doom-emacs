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
      (:prefix-map ("n" . "notmuch")
       :desc "Inbox" "i" #'=notmuch;; This doom function jump to inbox in a new workspace
       :desc "Counsel search" "c" #'counsel-notmuch
       :desc "Search " "s" #'notmuch-search
       :desc "Home " "h" #'notmuch))))
  :config
  (setq sendmail-program  "/usr/bin/msmtp"
        notmuch-archive-tags '("-inbox" "-unread" "-new" "+archived")
        notmuch-saved-searches '(
                                 (:name "inbox"   :query "tag:inbox "    :key "i" :search-type 'tree)
                                 (:name "sent"    :query "tag:sent"      :key "s" :search-type 'tree)
                                 (:name "archived":query "tag:archived"  :key "a" :search-type 'tree)
                                 (:name "drafts"  :query "tag:draft"     :key "d" :search-type 'tree))
        ;; Disable colors to use default (easier on the eyes)
        shr-use-colors nil)

;;  Some mapping are overriden by eval commands so we need to remap them
 (map! (:after notmuch
         (:map notmuch-common-keymap
           :nm "gr"     #'notmuch-refresh-this-buffer)))

  )
