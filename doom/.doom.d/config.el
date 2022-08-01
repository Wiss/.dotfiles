;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Ismael Jaras"
      user-mail-address "is.jaras@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
;; start display-fill-column
(setq-default display-fill-column-indicator-column 79) ; 80 column indicator - Emacs columns are 0-based...
(global-display-fill-column-indicator-mode 1)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;To scan the org directory for dates and tags
(after! org
  (setq org-directory "~/Documents/org/")
  (setq org-agenda-files (list org-directory))
  (setq org-agenda-dim-blocked-tasks t)
  )

;; Keybindings from Org Manual
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)


;; org-capture templates
;; with the specifier %i you will copy and paste all the highlited text in the tempalte
(after! org
(setq org-capture-templates
      '(("d" "Demo template" entry
         (file+headline "demo.org" "Our first heading")
         "* DEMO TEXT %?")
      ("p" "Prompt us for input" entry
        (file+headline "demo.org" "Our First heading")
        "* %^{Please write here} %?")
      ("o" "Options in prompt" entry
        (file+headline "demo.org" "Our Second heading")
        "* %^{Selet yout option|ONE|TWO|THREE} %?")
      ("r" "Task with date" entry
        (file+headline "demo.org" "Scheduled tasks")
        "* %^{Selet yout option|ONE|TWO|THREE}\n SCHEDULE: %^t\n Some extra text %?")
      ("a" "A random template")
       ("at" "Submenu option T" entry
        (file+headline "demo.org" "Scheduled tasks")
        "* %^{Selet yout option|ONE|TWO|THREE}\n SCHEDULE: %^t\n Some extra text %?")
        ("aa" "Submenu option A" entry
        (file+headline "demo.org" "Scheduled tasks")
        "* %^{Selet yout option|ONE|TWO|THREE}\n SCHEDULE: %^t\n Some extra text %?")

        ("t" "Task to do")
        ("td" "With deadline" entry
         (file+headline "general_todos.org" "To-Do with deadline")
         "* TODO %?\n DEADLINE %^t")
        ("ts" "With schedule" entry
         (file+headline "general_todos.org" "To-Do with schedule")
         "* TODO %?\n SCHEDULE %^t")
        ("to" "Without deadline" entry
         (file+headline "general_todos.org" "To-Do")
         "* TODO %?")
      ("i" "Idea" entry
       (file+headline "idea.org" "Idea")
        "* IDEA %?"))
))

;;
;; This is for org-ref
(setq reftex-default-bibliography '("~/Dropbox/bibliography/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
      org-ref-default-bibliography '("~/Dropbox/bibliography/references.bib")
      org-ref-pdf-directory "~/Dropbox/bibliography/bibtex-pdfs/")

(setq bibtex-completion-bibliography "~/Dropbox/bibliography/references.bib"
      bibtex-completion-library-path "~/Dropbox/bibliography/bibtex-pdfs"
      bibtex-completion-notes-path "~/Dropbox/bibliography/bibtex-notes")

;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (start-process "open" "*open*" "open" fpath)))

;; alternative
;; (setq bibtex-completion-pdf-open-function 'org-open-file)

;; Language tool: langtool
;; (setq langtool-bin "usr/bin/languagetool")
(require 'langtool)

;; wakatime
(use-package wakatime-mode
  :ensure t)

;; enable for all buffers
(global-wakatime-mode)
