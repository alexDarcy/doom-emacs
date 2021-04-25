;;; ../dotfiles/doom-emacs/.doom.d/+exwm.el -*- lexical-binding: t; -*-

(require 'exwm)
(require 'exwm-config)
(exwm-config-example)

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
          (,(kbd "s-q") . exwm-reset) ;; Try to reset EXWM to a sane mode. Panic key
          ;; Interactively select, and switch to, a workspace. Only works in non EXWM windows.
          (,(kbd "s-w") . exwm-workspace-switch)
          ;; Switch to a certain workspace using bepo layout
          ,@(cl-mapcar (lambda (c n)
                         `(,(kbd (format "s-%c" c)) .
                           (lambda ()
                             (interactive)
                             (exwm-workspace-switch-create ,n))))
                       '(?\" ?« ?» ?\( ?\) ?@)
                       (number-sequence 0 9))
          ;; ,@(cl-mapcar (lambda (c n)
          ;;                `(,(kbd (format "s-%c" c)) .
          ;;                  (lambda ()
          ;;                    (interactive)
          ;;                    (exwm-workspace-move-window ,n)
          ;;                    (exwm-workspace-switch ,n))))
          ;;              '(?\) ?! ?@ ?# ?$ ?% ?^ ?& ?* ?\()
          ;;              ;; '(?\= ?! ?\" ?# ?¤ ?% ?& ?/ ?\( ?\))
          ;;              (number-sequence 0 9))
          (,(kbd "s-c") . windmove-left)  ;; Move to window to the left of current one. Uses universal arg
          (,(kbd "s-t") . windmove-down)  ;; Move to window below current one. Uses universal arg
          (,(kbd "s-s") . windmove-up)    ;; Move to window above current one. Uses universal arg
          (,(kbd "s-r") . windmove-right) ;; Move to window to the right of current one. Uses universal arg
          (,(kbd "s-f") . counsel-find-files)
          (,(kbd "s-F") . exwm-floating-toggle-floating) ;; Toggle the current window between floating and non-floating states
          (,(kbd "s-Q") . exwm-layout-toggle-fullscreen) ;; Toggle fullscreen mode, when in an EXWM window.
          )))
