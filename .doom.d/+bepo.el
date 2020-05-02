;;;  -*- lexical-binding: t; -*-
;; Description: We must rebindng quite some binding to adapt to the bepo layout

;;-------------------------------------------------------------------------------
 ;; Global movement j, k <-> t,s
;;-------------------------------------------------------------------------------
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
 ;;-------------------------------------------------------------------------------
 ;; gs -> à because we need to replace s
 (:after evil-easymotion
   :m "gs" nil
   :m "à" evilem-map
   (:map evilem-map
     "s" 'evilem-motion-previous-line ; Quite useful
     "t" 'evilem-motion-next-line
     "c" #'evil-avy-goto-char-2 ;; Jump two characters <3. I should use it more
     "m" #'evil-avy-goto-word-1 ;; evil forward word is limited to the current line. This is quite powerful
     "««"  'evilem-motion-backward-section-begin
     "«»"  'evilem-motion-backward-section-end
     "»«"  'evilem-motion-forward-section-begin
     "»»"  'evilem-motion-forward-section-begin
     ))


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

 ;; Default prefix is '&', not convenient
 ;; ',' is used for backward caracter search but it should not be used often in dired
 ;; :m "," ranger-dired-map
 (:after ranger
   :m "," ranger-dired-map
   :map ranger-mode-map
   :nm "t" 'evil-next-line
   :nm "s" 'evil-previous-line
   :nm "j" 'ranger-toggle-mark
   ; & is clumsy on bepo
   :map ranger-dired-map "è" 'dired-do-async-shell-command
   )

 (:after org
   :nm "««"  'evil-backward-section-begin
   :nm "«»"  'evil-backward-section-end
   :nm "»«"  'evil-forward-section-begin
   :nm "»»"  'evil-forward-section-begin
   )

;;-------------------------------------------------------------------------------
;; Pop-up menu
;;-------------------------------------------------------------------------------
(:leader
  ;; Switch buffer with space + "«" instead of space + "<"
  "<" nil
  (:when (featurep! :ui workspaces)
    :desc "Switch buffer"           "«" #'switch-to-buffer
    )
  )
)
 ;; ;; Does not work
;; (after! pdf-tools
;;   (map!
;;    :map pdf-view-mode-map
;;    :nm "t" #'pdf-view-next-line-or-next-page))
