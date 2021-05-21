;;; init.el -*- lexical-binding: t; -*-

;; Copy this file to ~/.doom.d/init.el or ~/.config/doom/init.el ('doom
;; quickstart' will do this for you). The `doom!' block below controls what
;; modules are enabled and in what order they will be loaded. Remember to run
;; 'doom refresh' after modifying it.
;;
;; More information about these modules (and what flags they support) can be
;; found in modules/README.org.

(doom!  :input
        ;;chinese
        japanese
        ;;

        :checkers
        syntax          ; tasing you for every semicolon you forget
        (spell          ; tasing you for misspelling mispelling
         +flyspell) ; cannot use ispell for french, so we default to flyspell :
         ;; +aspell) ; see https://github.com/hlissner/doom-emacs/issues/3838

        :completion
        company           ; the ultimate code completion backend
        ivy               ; a search engine for love and life

        :ui
        deft              ; notational velocity for Emacs
        doom              ; what makes DOOM look the way it does
        doom-dashboard    ; a nifty splash screen for Emacs
        doom-quit         ; DOOM quit-message prompts when you quit Emacs
        ;;fill-column       ; a `fill-column' indicator
        hl-todo           ; highlight TODO/FIXME/NOTE tags
        ;;indent-guides     ; highlighted indent columns
        modeline          ; snazzy, Atom-inspired modeline, plus API
        nav-flash         ; blink the current line after jumping
        ;;neotree           ; a project drawer, like NERDTree for vim
        ophints           ; highlight the region an operation acts on
        (popup            ; tame sudden yet inevitable temporary windows
         +all             ; catch all popups that start with an asterix
         +defaults)       ; default popup rules
        ;;pretty-code       ; replace bits of code with pretty symbols
        ;;tabbar            ; FIXME an (incomplete) tab bar for Emacs
        treemacs          ; a project drawer, like neotree but cooler
        ;;unicode           ; extended unicode support for various languages
        vc-gutter         ; vcs diff in the fringe
        vi-tilde-fringe   ; fringe tildes to mark beyond EOB
        window-select     ; visually switch windows
        workspaces        ; tab emulation, persistence & separate workspaces

        :editor
        (evil +everywhere); come to the dark side, we have cookies
        file-templates    ; auto-snippets for empty files
        fold              ; (nigh) universal code folding
        ;;(format +onsave)  ; automated prettiness
        ;;lispy             ; vim for lisp, for people who dont like vim
        multiple-cursors  ; editing in many places at once
        ;;objed             ; text object editing for the innocent
        ;;parinfer          ; turn lisp into python, sort of
        rotate-text       ; cycle region at point between text candidates
        snippets          ; my elves. They type so I don't have to

        :emacs
        (dired            ; making dired pretty [functional]
         ;; +ranger         ; bringing the goodness of ranger to dired
         +icons          ; colorful icons for dired-mode
         )
        electric          ; smarter, keyword-based electric-indent
        vc                ; version-control and Emacs, sitting in a tree
        undo              ; We need undo

        :term
        eshell            ; a consistent, cross-platform shell (WIP)
        ;;term              ; terminals in Emacs
        ;;vterm             ; another terminals in Emacs

        :tools
        ;;ansible
        biblio
        ;;debugger          ; FIXME stepping through code, to help you add bugs
        ;;direnv
        ;;docker
        ;;editorconfig      ; let someone else argue about tabs vs spaces
        ;;ein               ; tame Jupyter notebooks with emacs
        eval              ; run code, run (also, repls)
        gist              ; interacting with github gists
        (lookup           ; helps you navigate your code and documentation
         +docsets)        ; ...or in Dash docsets locally
        lsp
        magit             ; a git porcelain for Emacs
        make              ; run make tasks from Emacs
        pass              ; password manager for nerds
        pdf               ; pdf enhancements
        ;;prodigy           ; FIXME managing external services & code builders
        ;;rgb               ; creating color strings
        ;;terraform         ; infrastructure as code
        ;;tmux              ; an API for interacting with tmux
        ;;upload            ; map local to remote projects via ssh/ftp
        ;;wakatime

        :lang
        common-lisp         ; Sly instead of slime as an IDE
        data              ; config/data formats
        emacs-lisp        ; drown in parentheses
        ess               ; emacs speaks statistics
        ;;fsharp           ; ML stands for Microsoft's Language
        ;;go                ; the hipster dialect
        ;; (haskell +intero) ; a language that's lazier than I am
        (haskell +lsp) ;
        ;;hy                ; readability of scheme w/ speed of python
        ;;idris             ;
        ;;(java +meghanada) ; the poster child for carpal tunnel syndrome
        ;;javascript        ; all(hope(abandon(ye(who(enter(here))))))
        ;;julia             ; a better, faster MATLAB
        ;;kotlin            ; a better, slicker Java(Script)
        latex             ; writing papers in Emacs has never been so fun
        ledger            ; an accounting system in Emacs
        ;;lua               ; one-based indices? one-based indices
        markdown          ; writing docs for people to ignore
        ;;nim               ; python + lisp at the speed of c
        ;;nix               ; I hereby declare "nix geht mehr!"
        :lang
        (org              ; organize your plain life in plain text
         ;+flyspell
         +dragndrop       ; file drag & drop support
         +ipython         ; ipython support for babel
         +pandoc          ; pandoc integration into org's exporter
         +present)        ; using Emacs for presentations
        ;;python            ; beautiful is better than ugly
        (sh +fish)          ; she sells {ba,z,fi}sh shells on the C xor
        ;;terra             ; Earth and Moon in alignment for performance.
        ;;web               ; the tubes
        ;;vala              ; GObjective-C

        :email
        notmuch             ; WIP

        ;; Applications are complex and opinionated modules that transform Emacs
        ;; toward a specific purpose. They may have additional dependencies and
        ;; should be loaded late.
        :app
        calendar
        emms
        irc              ; how neckbeards socialize
        (rss +org)        ; emacs as an RSS reader
        ;;twitter           ; twitter client https://twitter.com/vnought
        ;;(write            ; emacs as a word processor (latex + org + markdown)
        ;; +wordnut         ; wordnet (wn) search
        ;; +langtool)       ; a proofreader (grammar/style check) for Emacs

        :collab
        ;;floobits          ; peer programming for a price
        ;;impatient-mode    ; show off code over HTTP

        :config
        ;; For literate config users. This will tangle+compile a config.org
        ;; literate config in your `doom-private-dir' whenever it changes.
        ;;literate

        ;; The default module sets reasonable defaults for Emacs. It also
        ;; provides a Spacemacs-inspired keybinding scheme and a smartparens
        ;; config. Use it as a reference for your own modules.
        (default +bindings +smartparens)
      )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("229c5cf9c9bd4012be621d271320036c69a14758f70e60385e87880b46d60780" "f7b230ac0a42fc7e93cd0a5976979bd448a857cd82a097048de24e985ca7e4b2" "4a9f595fbffd36fe51d5dd3475860ae8c17447272cf35eb31a00f9595c706050" "428754d8f3ed6449c1078ed5b4335f4949dc2ad54ed9de43c56ea9b803375c23" default)))
 '(pdf-misc-print-programm "/usr/bin/lpr"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
