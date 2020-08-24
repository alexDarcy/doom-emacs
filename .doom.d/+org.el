;;; ~/dotfiles/doom-emacs/.doom.d/+org.el -*- lexical-binding: t; -*-

;;-------------------------------------------------------------------------------
;; Org
;;-------------------------------------------------------------------------------
(after! org
  ;; My agenda files
  (setq org-agenda-files (list "~/projects/blog/notes/revisions.org"
                               "~/projects/blog/notes/todo.org"
                               "~/projects/sir/sir.org")
        ;; Important : agenda view does not show notes with imcomplete parents in Doom
        org-agenda-dim-blocked-notes nil)

  (require 'org-habit)

  ;; Manage link to mail in gnus
  (add-to-list 'org-modules 'ol-gnus)
  ;; disable smar parens in org mode due to lag
  (add-hook 'org-mode-hook #'turn-off-smartparens-mode)

  (map! :leader
        ;; Remap org capture (bepo)
        "X" nil
        "y" #'org-capture
        )

  ;; For org-rifle:
  ;; helm-org-rifle-org-directory to search notes
  (setq org-directory "~/projects/blog/notes")

  ;; ;; Calfw : we need the possibility to have parents nodes for an event.
  ;; ;; Could not figure it out
  ;; (require 'calfw)
  ;; (require 'calfw-org)
  ;; ;; Hack :  Use calfw to show only studying
  ;; (defun study-calendar()
  ;;   (interactive)
  ;;   (cfw:open-calendar-buffer
  ;;    :contents-sources
  ;;    (list
  ;;     (cfw:org-create-file-source "revisions" "~/projects/blog/notes/revisions.org" "Orange")
  ;;     )))

  ;; Focus on studying
  ;; Warning : org-agenda-tag-filter-preset is set for all the view !! Cannot be used in blocks
  (setq org-agenda-custom-commands
        '(("r" "Revisions"
           ((agenda "" ((org-agenda-span 14)
                        (org-agenda-start-day "today")
                        (org-deadline-warning-days 0)
                        (org-agenda-skip-deadline-if-done t)))
            )
           ((org-agenda-filter-preset '("+revisions")))
           )
          ("s" "SIR"
           ((agenda "" ((org-agenda-span 14)
                        (org-agenda-start-day "today")
                        (org-deadline-warning-days 0)
                        (org-agenda-skip-deadline-if-done t)))
            )
           ((org-agenda-filter-preset '("+sir")))
           )
          ("o" "Others view"
           ((agenda "" ((org-agenda-start-day "today")
                        (org-deadline-warning-days 0)
                        (org-agenda-skip-deadline-if-done t)))
            )
           ((org-agenda-filter-preset '("-revisions")))
           )))

  ;; Remove religious holidays
  (setq holiday-bahai-holidays nil
        holiday-hebrew-holidays nil
        holiday-islamic-holidays nil)

  ;; Play a sound when using a timer (org-timer-set-timer)
  (setq org-clock-sound "~/.doom.d/bell.wav")

  ;; Workout template
  (setq org-capture-templates
        '(
          ;; Workout
          ("h" "Handstand" entry (file+olp+datetree "~/projects/blog/notes/workout.org")
           "* Handstand
 StW %^{StW}
 BtW %^{BtW}" )
          ("l" "L-sit" entry (file+olp+datetree "~/projects/blog/notes/workout.org")
           "* L-sit
 %^{GtG}" )
          ("p" "Parkour")
          ("pm" "Parkour (passe-muraille)" entry (file+olp+datetree "~/projects/blog/notes/workout.org")
           "* Parkour
Passe-muraille :
- cat hang shimmy (each side) : %^{Cat hang shimmy}
- top out (each side) : %^{Top out}
- negative : %^{négatifs}
- cat hang leg press (each side) : %^{Cat hang leg press}
- cat hang pull-up (each side) : %^{Cat hang pull-up}
- knee raises (each side) : %^{Knee raises}")
          ("po" "Parkour (autre)" entry (file+olp+datetree "~/projects/blog/notes/workout.org")
           "* Parkour
%^{Parkour}")
          ("s" "Splits" entry (file+olp+datetree "~/projects/blog/notes/workout.org")
           "* Splits
Standing splits (2-5s + rest) : %^{Standing splits}
Wall calf : %^{Wall calf}
Low lunge : %^{Low lunge}
Frog pose (dynamic) : %^{Frog pose}
Horse stance : %^{Horse stance}
Standing pancake : %^{Standing pancake}
Front split : %^{Front split}")
          ("r" "Running")
          ("rs" "Sprint" entry (file+olp+datetree "~/projects/blog/notes/workout.org")
           "* Running
:PROPERTIES:
:type: sprint
:END:
%^{reps}p
%^{sprint}p
%^{rest}p
")
          ("ro" "Other" entry (file+olp+datetree "~/projects/blog/notes/workout.org")
           "* Running
%^{type}p
%^{distance}p
%^{duration}p
%^{speed}p
")
          ("t" "Tricks" entry (file+olp+datetree "~/projects/blog/notes/workout.org")
"* Tricks
Kip up : %^{kip-up}
Back flip : %^{backflip}
Front flip : %^{frontflip}
Front handspring : : %^{front handspring}")
          ("w" "Workout" entry (file+olp+datetree "~/projects/blog/notes/workout.org")
           "* Workout
RTO : %^{RTO}
Skin-the-cat : %^{Skin the cat}
L-sit : %^{L-sit}
Muscle-up : %^{Muscle-up}
Pistols (assisted) : %^{Pistols}
Extension (lower-back) : %^{Extension}
Front-lever row (advanced tuck) : %^{Rows}
Planche push-up (advanced tuck): %^{Planche tucked}
Norwegian curls: %^{Curls}
Compression : %^{Compression}"
           )

          ;; ("c" "Cookbook" entry (file "~/projects/blog/notes/cooking.org") ;; Needs org-chef
          ;;  "%(org-chef-get-recipe-from-url)")
          ;; ("m" "Manual Cookbook" entry (file "~/org/cookbook.org")
          ;;  "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")
          ))
  (add-load-path! "lisp")
  (require 'org-movie)

  (setq org-movie-omdb-apikey "16dcceba")
  )

;; -------------------------------------------------------------------------------
;; Org-ref should be loaded in an org file (NB: doom is lazy and will not load it by default)
;;------------------------------------------------------------------------------
(use-package! org-ref
  :after org
  :config
  (setq org-ref-completion-library 'org-ref-ivy-cite
        reftex-default-bibliography '("~/projects/blog/notes/references.bib"
                                       "~/projects/sir/references.bib")
        org-ref-bibliography-notes '("~/projects/blog/notes/books.org"
                                     "~/projects/blog/notes/papers.org")
        org-ref-default-bibliography '("~/projects/blog/notes/references.bib"
                                       "~/projects/sir/references.bib")
        org-ref-pdf-directory "~/projects/blog/notes/pdfs/")
  ;; Customization : we want to insert the title of an entry in a reading list
  (push '("justtitle" . ((nil . "${title}"))) org-ref-formatted-citation-formats)

  ;; Helm bibtex configuration must be set
  (setq bibtex-completion-library-path '("~/projects/blog/notes/pdfs")
        bibtex-completion-bibliography '("~/projects/blog/notes/references.bib"
                                       "~/projects/sir/references.bib")
        bibtex-completion-library-path "~/projects/blog/notes/pdfs"
        bibtex-completion-notes-path "~/projects/blog/notes/books.org"
        ;; Do not open on default
        ivy-bibtex-default-action 'ivy-bibtex-edit-notes))


;;------------------------------------------------------------------------------
;; ----- Deft to manage notes
;;------------------------------------------------------------------------------
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
 :commands (zetteldeft-new-file zetteldeft-tag-buffer zetteldeft-search-at-point
 zetteldeft-find-file zetteldeft-search-current-id zetteldeft-follow-link
 zetteldeft-avy-tag-search zetteldeft-new-file-and-link zetteldeft-file-rename
 zetteldeft-find-file-id-insert zetteldeft-find-file-full-title-insert
 zetteldeft-search-at-point zetteldeft-avy-link-search
 zetteldeft-avy-file-search-ace-window zetteldeft-find-file)
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
        :desc "zetteldeft-count-words" "x" #'zetteldeft-count-words))

(require 'deft)
(require 'zetteldeft)

;; Async execution of org source blocks (useful for long excutions)
(require 'ob-async)

;; -----------------------------------------
;; Functions to manipulate org files with om.el
;;------------------------------------------------------------------------------
(require 'org-ml)
(after! org-ml
  ;; INcrement 2 node properties
  ;; TODO: check the properties exists (otherwise it fails)
  ;;
  ;; * TODO Root node
  ;;    :PROPERTIES:
  ;;    :COLLEGE: 1
  ;;    :ECNI: 1
  ;;    :END:
  ;;
  ;; It returns
  ;;
  ;; * TODO Root node
  ;;    :PROPERTIES:
  ;;    :COLLEGE: 2
  ;;    :ECNI: 2
  ;;    :END:
  ;;
  ;; Increment a number by 1
  (defun increment-number(n)
    (number-to-string (1+ (string-to-number n)))
  )
  (defun increment-reviews()
    (interactive)
    (om-update-this-headline*
      (->> (om-headline-map-node-property "COLLEGE" (function increment-number) it)
           (om-headline-map-node-property "ECNI" (function increment-number)))
      )
    )
  (defun increment-college()
    (interactive)
    (om-update-this-headline*
      (->> (om-headline-map-node-property "COLLEGE" (function increment-number) it))))
  (defun increment-ecni()
    (interactive)
    (om-update-this-headline*
      (->> (om-headline-map-node-property "ECNI" (function increment-number) it))))
  )
