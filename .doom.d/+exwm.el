;;; ../dotfiles/doom-emacs/.doom.d/+exwm.el -*- lexical-binding: t; -*-

(defun exwm-config-custom ()
  "My configuration of EXWM: bepo mode and no id"
  ;; Set the initial workspace number.
  (unless (get 'exwm-workspace-number 'saved-value)
    (setq exwm-workspace-number 4))
  ;; Make class name the buffer name
  (add-hook 'exwm-update-class-hook
            (lambda ()
              (exwm-workspace-rename-buffer exwm-class-name)))
  ;; Global keybindings.
  ;; Global keybindings. 0-9 bcDfFgGhHijJkKlLmoOQrRwW !@#$%^&*() tab f2 backspace
  (unless (get 'exwm-input-global-keys 'saved-value)
    (setq exwm-input-global-keys
          `(
            (,(kbd "s-p") . counsel-linux-app) ;; Start an application, such as google-chrome
            (,(kbd "s-m") . (lambda () ;; Toggle display of mode-line and minibuffer, in an EXWM window
                              (interactive)
                              (exwm-layout-toggle-mode-line)
                              (exwm-workspace-toggle-minibuffer)))
            (,(kbd "s-i") . exwm-input-toggle-keyboard) ;; Toggle between "line-mode" and "char-mode" in an EXWM window
            (,(kbd "s-Q") . exwm-reset) ;; Try to reset EXWM to a sane mode. Panic key
            ;; Interactively select, and switch to, a workspace. Only works in non EXWM windows.
            (,(kbd "s-b") . ivy-switch-buffer)
            (,(kbd "s-w") . exwm-workspace-switch)
            ;; Switch to a certain workspace using bepo layout
            ,@(cl-mapcar (lambda (c n)
                           `(,(kbd (format "s-%c" c)) .
                             (lambda ()
                               (interactive)
                               (exwm-workspace-switch-create ,n))))
                         '(?\" ?« ?» ?\( ?\) ?@)
                         (number-sequence 0 9))
            ;; Move window to a certain workspace using bepo layout
            ,@(mapcar (lambda (i)
                        `(,(kbd (format "s-%d" i)) .
                          (lambda ()
                            (interactive)
                            (exwm-workspace-move-window ,i)
                            (exwm-workspace-switch ,i))))
                      (number-sequence 1 6))
            ;; Windows management
            (,(kbd "s-c") . windmove-left)  ;; Move to window to the left of current one. Uses universal arg
            (,(kbd "s-t") . windmove-down)  ;; Move to window below current one. Uses universal arg
            (,(kbd "s-s") . windmove-up)    ;; Move to window above current one. Uses universal arg
            (,(kbd "s-r") . windmove-right) ;; Move to window to the right of current one. Uses universal arg
            (,(kbd "s-h") . evil-window-split) ;; Split horizontally
            (,(kbd "s-v") . evil-window-vsplit) ;; Split vertzontally
            (,(kbd "s-w") . ace-window) ;; select a windows (does not work well with graphical programs)
            (,(kbd "s-f") . counsel-find-files)
            (,(kbd "s-F") . exwm-floating-toggle-floating) ;; Toggle the current window between floating and non-floating states
            (,(kbd "s-Q") . exwm-layout-toggle-fullscreen) ;; Toggle fullscreen mode, when in an EXWM window.
            ;; Program
            )))
  ;; Line-editing shortcuts
  (unless (get 'exwm-input-simulation-keys 'saved-value)
    (setq exwm-input-simulation-keys
          '(([?\C-b] . [left])
            ([?\C-f] . [right])
            ([?\C-p] . [up])
            ([?\C-n] . [down])
            ([?\C-a] . [home])
            ([?\C-e] . [end])
            ([?\M-v] . [prior])
            ([?\C-v] . [next])
            ([?\C-d] . [delete])
            ([?\C-k] . [S-end delete]))))
  ;; Enable EXWM
  (exwm-enable)
  ;; Other configurations
  (exwm-config-misc))


(require 'exwm)
(require 'exwm-config)
(exwm-config-custom) ;; oerride exwm-config-example

                                        ; Does not work ??
(require 'exwm-systemtray)
(exwm-systemtray-enable)
(setq exwm-systemtray-height 30)
