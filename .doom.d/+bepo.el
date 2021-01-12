;;;  -*- lexical-binding: t; -*-
;; Description: We must rebindng quite some binding to adapt to the bepo layout


;;-------------------------------------------------------------------------------
 ;; Global movement j, k <-> t,s
;;-------------------------------------------------------------------------------
;;

(map!
 :nm "s" 'evil-previous-line
 :vm "s" 'evil-previous-visual-line ;; visual mode too
 :nm "S" nil
 :nm "t" 'evil-next-line
 :vm "t" 'evil-next-visual-line ;; visual mode too
 :nm "T" 'evil-join
 :nm "j" 'evil-find-char-to
 :nm "J" 'evil-find-char-to-backward
 :nm "k" 'evil-substitute
 :nm "K" 'evil-change-whole-line
 ;; h, l <-> c, r
 :nm "h" 'evil-replace
 :nm "H" 'evil-replace-state
 :nm "l" 'evil-change
 :nm "L" 'evil-change-line
 :nm "c" 'evil-backward-char
 :nm "r" 'evil-forward-char
 ;; Jump to section
 :nm "««"  'evil-backward-section-begin
 :nm "«»"  'evil-backward-section-end
 :nm "»«"  'evil-forward-section-begin
 :nm "»»"  'evil-forward-section-begin

 ;; Multi edit : "c" is already used
 (:map evil-multiedit-map
  "c" nil
  "C" nil
  "h" 'evil-multiedit--change
  "H" 'evil-multiedit--substitute
  )

;;; :ui
 (:when (featurep! :ui popup)
       "C-à"   #'+popup/raise)


 ;; ;; Gnus : remap most used functions with 2 characters, g being the prefix
 ;; (:after gnus
 ;;  :map gnus-group-mode-map
 ;;  :nm "gr" 'gnus-group-get-new-news
 ;;  :nm "gf" 'nnmairix-search
 ;;  :map gnus-summary-mode-map
 ;;  :nm "gm" 'gnus-summary-move-article
 ;;  )

 ;; Evil navigation in notmuch
 (:after notmuch
  :map notmuch-common-keymap
  :nm "gr" #'notmuch-refresh-this-buffer
  :nm "k" #'notmuch-search
  :nm "K" #'notmuch-tree

  :map notmuch-search-mode-map
  ;; "s"/"t" conflict with evil prev/next line
  ;; easiest way is to swap with "j"/"k"
  :nm "t" 'evil-next-line
  :nm "k" #'notmuch-search
  :nm "s" 'evil-previous-line
  :nm "j" #'notmuch-search-filter-by-tag
  )


 ;; Calendar motion
  (:map calendar-mode-map
   :nm "r" 'calendar-forward-day
   :nm "c" 'calendar-backward-day
   :nm "s" 'calendar-forward-week
   :nm "t" 'calendar-backward-week
  )

  ;; Surprisingly overridden
  (:map magit-mode-map
   :nm "C-n" 'magit-next-line
   :nm "C-p" 'magit-previous-line
   )
 ;;-------------------------------------------------------------------------------
 ;; Evil-snipe : must be done before other t-s remapping below
 ;;-------------------------------------------------------------------------------
 (:after evil-snipe
   ;; s and t are used by evil snip => remap it to é and É (è is less accessible...)
   :map evil-snipe-local-mode-map
   :nm "é" 'evil-snipe-s
   :nm "É" 'evil-snipe-S
   :nm "è" 'evil-snipe-t
   :nm "È" 'evil-snipe-T
   :nm "s" 'evil-previous-line ;; "s" is overriden... Remap it again
   :vm "s" 'evil-previous-visual-line
  )

 ;;-------------------------------------------------------------------------------
 ;; Change window switching too
 ;;-------------------------------------------------------------------------------
 (:map evil-window-map
   ;; Navigation
   "c"     #'evil-window-left
   "t"     #'evil-window-down
   "s"     #'evil-window-up
   "r"     #'evil-window-right
   ;; Remap old c t s r.
   "k"     #'+workspace/close-window-or-workspace ;; c -> k like "Kill"
   "l"     #'evil-window-top-left ;; t -> l as "left"
   "i"     #'evil-window-split ;; s-> i as "split"
   "h"     #'evil-window-rotate-downwards ;; r-> h. Not easy to remember but not used often
   ;; Swapping windows
   "C"     #'+evil/window-move-left
   "T"     #'+evil/window-move-down
   "S"     #'+evil/window-move-up
   "R"     #'+evil/window-move-right
    ;; Old mappings
   "H" nil
   "J" nil
   "K" nil
   "L" nil)


 ;;-------------------------------------------------------------------------------
 ;; Easymotion : more consistent configuration for bepo
 ;; It seems easymotion is based on avy, but we use easymotion by default (more sane)
 ;;-------------------------------------------------------------------------------
 ;; gs -> à because we need to replace s
 (:after evil-easymotion
   :m "gs" nil
   :m "à" evilem-map
   ;; Motions i use : jump to char, char2, word and line
   (:map evilem-map
     "t" #'evilem-motion-next-line ; jumps directly above the cursor if possible
     "s" #'evilem-motion-previous-line
     "l" #'evil-avy-goto-line ; jump to the beginning of line
     "c" #'evil-avy-goto-char-2 ; Jump two characters <3. I should use it more
     "m" #'evil-avy-goto-word-1 ; evil forward word is limited to the current
                                        ;line. This is quite powerful. "m" as in "match"
     "d" #'avy-move-line ; "d" as in "displace"
     "h" #'avy-org-goto-heading-timer ; Jump to org headline
     ;; Jump spections
     "««"  'evilem-motion-backward-section-begin
     "«»"  'evilem-motion-backward-section-end
     "»«"  'evilem-motion-forward-section-begin
     "»»"  'evilem-motion-forward-section-begin
     ))

 (:after org
   ;; Jump to section
   :nm "««"  'org-previous-visible-heading
   :nm "»»"  'org-next-visible-heading)
 ;;-------------------------------------------------------------------------------
 ;; Workspace (like eyebrowse)
 ;;-------------------------------------------------------------------------------
 ;; Use bepo-friendly shortcuts : 1-4 keys without shift
 (:when (featurep! :ui workspaces)
   "M-\""   #'+workspace/switch-to-0
   "M-«"   #'+workspace/switch-to-1
   "M-»"   #'+workspace/switch-to-2
   "M-("   #'+workspace/switch-to-3
   "M-)"   #'+workspace/switch-to-4
   )

 (:after dired
   (:map dired-mode-map
    :n "t" 'evil-next-line ; Swap t <-> j
    :n "j" 'dired-toggle-mark ; Swap t <-> j
    :n "h" 'dired-up-directory ;; Better than ^ twice on bepo
    :n "&" 'nil
    :n "ê" 'dired-do-async-shell-command ; & is clumsy on bepo
   ))


 (:after ledger
  :map ledger-mode-map
  :nm "»»"  'ledger-navigate-next-xact-or-directive
  :nm "««"  'ledger-navigate-prev-xact-or-directive
  )

;; Treemacs
 (:after treemacs-evil
  :map evil-treemacs-state-map
  "s" #'treemacs-previous-line
  "t" #'treemacs-next-line
  (:prefix-map ("j" . "prefix")
   ;; T is a prefix so we have to remap all this (with j)....
   "jh"  #'treemacs-toggle-show-dotfiles
   "jw"  #'treemacs-toggle-fixed-width
   "jv"  #'treemacs-fringe-indicator-mode
   "jf"  #'treemacs-follow-mode
   "ja"  #'treemacs-filewatch-mode
   "jg"  #'treemacs-git-mode)
  )

 (:after pdf-tools
   :map pdf-view-mode-map
   :gn "n" #'pdf-view-next-page-command
   :gn "p" #'pdf-view-previous-page-command
   :gn "b" #'pdf-view-scroll-down-or-previous-page
   :gn "f" #'pdf-view-scroll-up-or-next-page
   :gn "r" (cmd! (image-forward-hscroll 10)) ;; left and right movement
   :gn "c" (cmd! (image-backward-hscroll 10)))

;;-------------------------------------------------------------------------------
;; Pop-up menu
;;-------------------------------------------------------------------------------

(:leader
  ;; Switch buffer with space + "«" instead of space + "<"
  "<" nil
  "~" nil
  (:when (featurep! :ui workspaces)
    :desc "Switch buffer"           "«" #'switch-to-buffer
    )
  (:when (featurep! :ui popup)
   :desc "Toggle last popup"     "ê"    #'+popup/toggle)
  (:prefix-map ("s" . "search")
   :desc "Org-rifle (opened files)"                "é" #'helm-org-rifle ; é in reference to evil snipe
   :desc "Org-rifle (org directory)"               "è" #'helm-org-rifle-org-directory) ; slower
  )
)
