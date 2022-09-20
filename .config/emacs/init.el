;;; package --- summary

;;; Commentary:
;;
;; Bootstrap the required libraries to enable a literate Emacs configuration
;;

;;; Code:

;; startup performance

;; The default is 800 kilobytes.  Measured in bytes.
; (setq gc-cons-threshold (* 100 1000 1000))

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))


;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(require 'use-package)
;; ensure packages by default
(setq use-package-always-ensure t)

;; load symlinked file without asking confirmation
(setq vc-follow-symlinks t)


(require 'org)
(org-babel-load-file "~/.config/emacs/Emacs.org")

(provide 'init)
;;; init.el ends here
