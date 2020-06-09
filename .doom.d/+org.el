;;; ~/dotfiles/doom-emacs/.doom.d/+org.el -*- lexical-binding: t; -*-

;;-------------------------------------------------------------------------------
;; Org
;;-------------------------------------------------------------------------------
(after! org
  ;; My agenda files
  (setq org-agenda-files (list "~/projects/blog/notes/revisions.org"
                               "~/projects/blog/notes/todo.org")
        ;; Important : agenda view does not show notes with imcomplete parents in Doom
        org-agenda-dim-blocked-notes nil)

  ;; Manage link to mail in gnus
  (add-to-list 'org-modules 'ol-gnus)

  ;; Shortcut to
  (defun toggle-checkbox-?()
    (interactive)
    (org-toggle-checkbox '(16)))

  (map! :leader
        ;; Easier access to agenda
        (:prefix "o"
         :desc "Org Agenda" "a" #'org-agenda-list)

        ;; Remap org capture (bepo)
        "X" nil
        "y" #'org-capture

        :map org-mode-map
        :localleader
        "x" #'org-toggle-checkbox
        )

  (require 'calfw)
  (require 'calfw-org)
  ;; Hack :  Use calfw to show only studying
  (defun study-calendar()
    (interactive)
    (cfw:open-calendar-buffer
     :contents-sources
     (list
      (cfw:org-create-file-source "revisions" "~/projects/blog/notes/revisions.org" "Orange")
      )))

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
          ("o" "Others view"
           ((agenda "" ((org-agenda-start-day "today")
                        (org-deadline-warning-days 0)
                        (org-agenda-skip-deadline-if-done t)))
            )
           ((org-agenda-filter-preset '("-revisions")))
           )))

                                        ; Remove religious holidays
  (setq holiday-bahai-holidays nil
        holiday-hebrew-holidays nil
        holiday-islamic-holidays nil)

  ;; Play a sound when using a timer (org-timer-set-timer)
  (setq org-clock-sound "~/.doom.d/bell.wav")

  ;; Workout template
  (setq org-capture-templates
        '(
          ;; Workout
          ("h" "Handstand" entry (file+datetree "~/projects/blog/notes/workout.org")
           "* Handstand
 StW %^{StW}
 BtW %^{BtW}" )
          ("l" "L-sit" entry (file+datetree "~/projects/blog/notes/workout.org")
           "* L-sit
 %^{GtG}" )
          ("p" "Parkour")
          ("pm" "Parkour (passe-muraille)" entry (file+datetree "~/projects/blog/notes/workout.org")
           "* Parkour
Passe-muraille :
- cat hang shimmy (each side) : %^{Cat hang shimmy}
- top out (each side) : %^{Top out}
- negative : %^{négatifs}
- cat hang leg press (each side) : %^{Cat hang leg press}
- cat hang pull-up (each side) : %^{Cat hang pull-up}
- knee raises (each side) : %^{Knee raises}")
          ("po" "Parkour (autre)" entry (file+datetree "~/projects/blog/notes/workout.org")
           "* Parkour
%^{Parkour}")
          ("s" "Splits" entry (file+datetree "~/projects/blog/notes/workout.org")
           "* Splits
Standing splits (2-5s + rest) : %^{Standing splits}
Wall calf : %^{Wall calf}
Low lunge : %^{Low lunge}
Frog pose (dynamic) : %^{Frog pose}
Horse stance : %^{Horse stance}
Standing pancake : %^{Standing pancake}
Front split : %^{Front split}")
          ("r" "Running")
          ("rs" "Sprint" entry (file+datetree "~/projects/blog/notes/workout.org")
           "* Running
:PROPERTIES:
:type: sprint
:END:
%^{reps}p
%^{sprint}p
%^{rest}p
")
          ("ro" "Other" entry (file+datetree "~/projects/blog/notes/workout.org")
           "* Running
%^{type}p
%^{distance}p
%^{duration}p
%^{speed}p
")
          ("w" "Workout" entry (file+datetree "~/projects/blog/notes/workout.org")
           "* Workout
Warm-up : %^{Warm-up}
Muscle-up (négatifs lents) : %^{Muscle-up}
Pistols (assisted) : %^{Pistols}
Front-lever row (advanced tuck) : %^{Rows}
Planche push-up (advanced tuck): %^{Planche tucked}
Extension (lower-back) : %^{Extension}
Compression : %^{Compression}
L-sit : %^{L-sit}")
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
(use-package! org-ref
  :after org
  :config
  (setq org-ref-completion-library 'org-ref-ivy-cite
        reftex-default-bibliography "~/projects/blog/notes/references.bib"
        org-ref-bibliography-notes '("~/projects/blog/notes/books.org"
                                     "~/projects/blog/notes/papers.org")
        org-ref-default-bibliography '("~/projects/blog/notes/references.bib")
        org-ref-pdf-directory "~/projects/blog/notes/pdfs/")
  ;; Customization : we want to insert the title of an entry in a reading list
  (push '("justtitle" . ((nil . "${title}"))) org-ref-formatted-citation-formats)

  ;; Helm bibtex configuration must be set
  (setq bibtex-completion-library-path '("~/projects/blog/notes/pdfs")
        helm-bibtex-bibliography "~/projects/blog/notes/references.bib"
        helm-bibtex-library-path "~/projects/blog/notes/pdfs"
        helm-bibtex-notes-path "~/projects/blog/notes/books.org"
        ;; Do not open on default
        ivy-bibtex-default-action 'ivy-bibtex-edit-notes))

(require 'om)
;; -----------------------------------------
;; Functions to manipulate org files with om.el
(after! om.el
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
  (defun increment-reviews()
    (interactive)
    (om-update-this-headline*
      (->> (om-headline-map-node-property "COLLEGE" (function increment-number) it)
           (om-headline-map-node-property "ECNI" (function increment-number)))
      )
    )

  ;; track habits
  (add-to-list 'org-modules 'habits)


  )
