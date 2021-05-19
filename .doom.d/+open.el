;;; ../../../usr/home/alex/dotfiles/doom-emacs/.doom.d/+pdf.el -*- lexical-binding: t; -*-

;; Open PDF with openwith
(require 'openwith)
(add-hook 'dired-mode-hook 'openwith-mode 1)

(use-package! openwith
  :config
  (openwith-mode 1)
  (setq openwith-associations
        (list
         (list (openwith-make-extension-regexp '("epub"))
               "zathura" '(file))
         (list (openwith-make-extension-regexp '("mkv"))
               "mpv" '(file))
         )))
