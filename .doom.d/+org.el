;;; ~/dotfiles/doom-emacs/.doom.d/+org.el -*- lexical-binding: t; -*-

;;-------------------------------------------------------------------------------
;; Org
;;-------------------------------------------------------------------------------

;; Cannot have composite views in normal agenda with tags. Super-aegnda does that
(use-package! org-super-agenda
  :commands (org-super-agenda-mode))

(after! org-agenda
  (org-super-agenda-mode))

(after! org
  (require 'org-habit)

  ;; My agenda files
  (setq org-agenda-files (list "~/projects/blog/notes/revisions.org"
                               "~/projects/blog/notes/todo.org"
                               "~/projects/sir/sir.org"))
  ;; Common variables for org-agenda
  ;; Important : agenda view does not show notes with imcomplete parents in Doom
  (setq org-agenda-dim-blocked-notes nil
        org-agenda-start-day "today"
        org-agenda-skip-deadline-if-done t
        org-deadline-warning-days 0)

  ;; Defaut org-agenda cannot have tags per block. A hack would be
  ;;       ("d" "Daily"
  ;;         ((tags-todo "revisions&SCHEDULED<=\"<today>\"|revisions&DEADLINE<=\"<today>\""
  ;;               ((org-agenda-overriding-header "Révisions")))
  ;;          (tags-todo "-revisions-daily-japanese&SCHEDULED<=\"<today>\"&TODO=\"TODO\" \
  ;;                     |-revisions-daily-japanese&DEADLINE<=\"<today>\"&TODO=\"TODO\""
  ;;               ((org-agenda-overriding-header "Autres")))
  ;;          (tags-todo "daily"
  ;;               ((org-agenda-overriding-header "Routine")))
  ;;          )
  ;; But it's easier to use org-super-agenda !
  ;;Warning : org-agenda-tag-filter-preset is set for all the view !! Cannot be used in blocks
  (setq org-agenda-custom-commands
        '(("r" "Revisions (today)"
           ((agenda "" ((org-agenda-span 1))))
           ((org-agenda-filter-preset '("+revisions")))
           )
          ("R" "Revisions (14 days)"
           ((agenda "" ((org-agenda-span 14))))
           ((org-agenda-filter-preset '("+revisions")))
           )
          ("d" "daily"
           ((agenda "" ((org-agenda-span 1)
                        (org-super-agenda-groups
                         '((:name "Studying"
                            ;; :deadline today
                            :tag "revisions")
                           (:name "Daily"
                            :tag "daily")
                           (:name "Others"
                            :todo "WAIT"
                            :not (:tag ("revisions" "daily"))
                            )
                           )))))
           )))

  ;; Manage link to mail in gnus
  ;; (add-to-list 'org-modules 'ol-gnus)
  ;; disable smar parens in org mode due to lag
  (add-hook 'org-mode-hook #'turn-off-smartparens-mode)

  (map! :leader
        ;; Remap org capture (bepo)
        "X" nil
        "y" #'org-capture
        ;;; <leader> n --- notes
        (:prefix-map ("n" . "notes")
         :desc "Insert org headline (counsel"  "h" #'counsel-org-link))

  ;; Fast export
  (map! "<f2>" #'(lambda() (interactive) (org-latex-export-to-pdf t)))
 
  ;; For org-rifle:
  ;; helm-org-rifle-org-directory to search notes
  (setq org-directory "~/projects/blog/notes")

  ;; Generate papers from org mode with biblatex
  (setq org-latex-pdf-process '("latexmk -pdflatex='pdflatex --shell-escape -interaction nonstopmode' -pdf -bibtex -f %f"))

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
- cat hang leg press (each side) : %^{Cat hang leg press}
- cat hang pull-up (each side) : %^{Cat hang pull-up}
- knee raises (each side) : %^{Knee raises}
- passe-muraille: %^{passe-muraille}")
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
Front-lever row (tuck) : %^{Rows}
Planche on rings (tuck): %^{Planche tucked}
Norwegian curls: %^{Curls}
Compression : %^{Compression}"
           )

          ;; ("c" "Cookbook" entry (file "~/projects/blog/notes/cooking.org") ;; Needs org-chef
          ;;  "%(org-chef-get-recipe-from-url)")
          ;; ("m" "Manual Cookbook" entry (file "~/org/cookbook.org")
          ;;  "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")
          ))
  (add-load-path! "lisp")

 ;; Search movie ames from omdb
  (require 'org-movie)
  (setq org-movie-omdb-apikey "16dcceba")

  ;; Cant set custom TODO locally appparently, so we add it head
  (setq org-todo-keywords
        ;; DOOm emacs
        '((sequence
           "TODO(t)"  ; A task that needs doing & is ready to do
           "PROJ(p)"  ; A project, which usually contains other tasks
           "STRT(s)"  ; A task that is in progress
           "WAIT(w)"  ; Something external is holding up this task
           "HOLD(h)"  ; This task is paused/on hold because of me
           "|"
           "DONE(d)"  ; Task successfully completed
           "KILL(k)") ; Task was cancelled, aborted or is no longer applicable
          (sequence
           "[ ](T)"   ; A task that needs doing
           "[-](S)"   ; Task is in progress
           "[?](W)"   ; Task is being held up or paused
           "|"
           "[X](D)") ; Task was completed
          (sequence
           "TOUR1(1)"
           "TOUR2(2)"
           "|"
           "TOUR3(3)")
          )
        org-todo-keyword-faces
        '(("[-]"  . +org-todo-active)
          ("STRT" . +org-todo-active)
          ("[?]"  . +org-todo-onhold)
          ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)
          ("TOUR1" . +org-todo-onhold)
          ("TOUR2" . +org-todo-project)
          ))


  )

;; -------------------------------------------------------------------------------
;; Org-ref should be loaded in an org file (NB: doom is lazy and will not load it by default)
;;------------------------------------------------------------------------------
(use-package! org-ref
  :after org
  :config
  (setq org-ref-completion-library 'org-ref-ivy-cite
        reftex-default-bibliography '("~/projects/blog/notes/references.bib"
                                       "~/projects/sir/manuscript/references.bib")
        org-ref-bibliography-notes '("~/projects/blog/notes/books.org"
                                     "~/projects/blog/notes/papers.org")
        org-ref-default-bibliography '("~/projects/blog/notes/references.bib"
                                       "~/projects/sir/manuscript/references.bib")
        org-ref-pdf-directory "~/projects/blog/notes/pdfs/")
  ;; Customization : we want to insert the title of an entry in a reading list
  (push '("justtitle" . ((nil . "${title}"))) org-ref-formatted-citation-formats)

  ;; Helm bibtex configuration must be set
  (setq bibtex-completion-library-path '("~/projects/blog/notes/pdfs")
        bibtex-completion-bibliography '("~/projects/blog/notes/references.bib"
                                       "~/projects/sir/manuscript/references.bib")
        bibtex-completion-library-path "~/projects/blog/notes/pdfs"
        bibtex-completion-notes-path "~/projects/blog/notes/books.org"
        ;; Do not open on default
        ivy-bibtex-default-action 'ivy-bibtex-insert-citation))


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

(after! org-roam
  :init
  (map! :leader
        :prefix ("r" . "org-roam")
        :desc "insert" "i" #'org-roam-insert
        :desc "find file" "f" #'org-roam-find-file)
  :config
  (setq org-roam-directory "~/projects/blog/notes"))

(add-hook 'after-init-hook 'org-roam-mode)


;; ;; Zetteldeft on top of deft
;; (use-package zetteldeft
;;  :commands (zetteldeft-new-file zetteldeft-tag-buffer zetteldeft-search-at-point
;;  zetteldeft-find-file zetteldeft-search-current-id zetteldeft-follow-link
;;  zetteldeft-avy-tag-search zetteldeft-new-file-and-link zetteldeft-file-rename
;;  zetteldeft-find-file-id-insert zetteldeft-find-file-full-title-insert
;;  zetteldeft-search-at-point zetteldeft-avy-link-search
;;  zetteldeft-avy-file-search-ace-window zetteldeft-find-file)
;;   :after deft
;;   :init
;;   (map! :leader
;;         :prefix ("d" . "zetteldeft")
;;         :desc "deft" "d" #'deft
;;         :desc "zetteldeft-deft-new-search" "D" #'zetteldeft-new-file
;;         :desc "deft-refresh" "R" #'deft-refresh
;;         :desc "zetteldeft-search-at-point" "s" #'zetteldeft-search-at-point
;;         :desc "zetteldeft-search-current-id" "c" #'zetteldeft-search-current-id
;;         :desc "zetteldeft-follow-link" "f" #'zetteldeft-follow-link
;;         :desc "zetteldeft-avy-file-search-ace-window" "F" #'zetteldeft-avy-file-search-ace-window
;;         :desc "zetteldeft-avy-link-search" "l" #'zetteldeft-avy-link-search
;;         :desc "zetteldeft-avy-tag-search" "t" #'zetteldeft-avy-tag-search
;;         :desc "zetteldeft-tag-buffer" "T" #'zetteldeft-tag-buffer
;;         :desc "zetteldeft-find-file-id-insert" "i" #'zetteldeft-find-file-id-insert
;;         :desc "zetteldeft-find-file-full-title-insert" "I" #'zetteldeft-find-file-full-title-insert
;;         :desc "zetteldeft-find-file" "o" #'zetteldeft-find-file
;;         :desc "zetteldeft-new-file" "n" #'zetteldeft-new-file
;;         :desc "zetteldeft-new-file-and-link" "N" #'zetteldeft-new-file-and-link
;;         :desc "zetteldeft-file-rename" "r" #'zetteldeft-file-rename
;;         :desc "zetteldeft-count-words" "x" #'zetteldeft-count-words))
;; (require 'zetteldeft)


;; --- Org block-----
;; Async execution of org source blocks (useful for long excutions)
(require 'ob-async)
;; Add R to org blocks
(org-babel-do-load-languages 'org-babel-load-languages
    '((shell . t) (python . t) (emacs-lisp . t) (R . t)))
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
;; Mimosis class for thesis
 (add-to-list 'org-latex-classes
                  '("mimosis"
                    "\\documentclass{mimosis}
  [NO-DEFAULT-PACKAGES]
  [PACKAGES]
  [EXTRA]"
                    ("\\chapter{%s}" . "\\addchap{%s}")
                    ("\\section{%s}" . "\\section*{%s}")
                    ("\\subsection{%s}" . "\\subsection*{%s}")
                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                    ("\\paragraph{%s}" . "\\paragraph*{%s}")
                    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; https://github.com/hlissner/doom-emacs/issues/3172
(add-hook 'org-mode-hook (lambda () (electric-indent-local-mode -1)))
