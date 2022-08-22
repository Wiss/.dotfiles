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

;; autosave
(setq auto-save-default t
make-backup-files t)

;; start files in overview view
(setq org-startup-folded t)


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
(setq org-agenda-files '("~/Documents/org/gtd/inbox.org"
                         "~/Documents/org/gtd/projects.org"
                         "~/Documents/org/gtd/tickler.org"
                         "~/Documents/org/gtd/calendar.org"))

;; Keybindings from Org Manual
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)


;; org-capture templates
;; with the specifier %i you will copy and paste all the highlited text in the tempalte
;; syntaxis https://orgmode.org/manual/Template-expansion.html
(after! org
(setq org-capture-templates
     ;'(("d" "Demo template" entry
     ;    (file+headline "demo.org" "Our first heading")
     ;    "* DEMO TEXT %?")
     ; ("p" "Prompt us for input" entry
     ;   (file+headline "demo.org" "Our First heading")
     ;   "* %^{Please write here} %?")
     ; ("o" "Options in prompt" entry
     ;   (file+headline "demo.org" "Our Second heading")
     ;   "* %^{Selet yout option|ONE|TWO|THREE} %?")
     ; ("r" "Task with date" entry
     ;   (file+headline "demo.org" "Scheduled tasks")
     ;   "* %^{Selet yout option|ONE|TWO|THREE}\n SCHEDULE: %^t\n Some extra text %?")
     ; ("a" "A random template")
     ;  ("at" "Submenu option T" entry
     ;   (file+headline "demo.org" "Scheduled tasks")
     ;   "* %^{Selet yout option|ONE|TWO|THREE}\n SCHEDULE: %^t\n Some extra text %?")
     ;   ("aa" "Submenu option A" entry
     ;   (file+headline "demo.org" "Scheduled tasks")
     ;   "* %^{Selet yout option|ONE|TWO|THREE}\n SCHEDULE: %^t\n Some extra text %?")

     ;   ("t" "Task to do")
     ;   ("td" "With deadline" entry
     ;    (file+headline "~/Documents/org/gtd/inbox.org" "To-Do with deadline")
     ;    "* TODO %?\n DEADLINE %^t")
     ;   ("ts" "With schedule" entry
     ;    (file+headline "general_todos.org" "To-Do with schedule")
     ;    "* TODO %?\n SCHEDULE %^t")
     ;   ("to" "Without deadline" entry
     ;    (file+headline "general_todos.org" "To-Do")
     ;    "* TODO %?")
     ; ("i" "Idea" entry
     ;  (file+headline "idea.org" "Idea")
     ;   "* IDEA %?")
      ;; GTD
      '(("t" "Todo [inbox]" entry
        (file+headline "~/Documents/org/gtd/inbox.org" "Tasks")
        "* TODO %i%? \n /Entered on: %U/")
      ("T" "Tickler" entry
        (file+headline "~/Documents/org/gtd/tickler.org" "Tickler")
        "* %i%? \n /Entered on: %U/ ")
      ("n" "Note" entry
        (file+headline "~/Documents/org/gtd/notes.org" "Notes")
        "* NOTE (%a)\n %i%? /Entered on/ %U\n" "\n" "%?")
      ("e" "Event" entry
        (file+headline "~/Documents/org/gtd/calendar.org" "Future")
        "* %? :meeting:\n %^T"))
))
;; Key-bind reminder
;; C-c c < capture
;; C-c C-w < refile
;; C-c C-c (headline) < creates tag
;; C-c C-t (headline) < binds todo keyword
;; C-c C-s < schedules
;; C-c C-d < deadline

;; refile for GTD
(setq org-refile-targets '(("~/Documents/org/gtd/projects.org" :maxlevel . 3)
                           ("~/Documents/org/gtd/someday.org" :level . 1)
                           ("~/Documents/org/gtd/tickler.org" :maxlevel . 2)
                           ("~/Documents/org/gtd/calendar.org" :maxlevel . 2)))
;; more todo keywords for GTD
(after! org
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
      ))

;; create activated keyword
(defun log-todo-next-creation-date (&rest ignore)
  "Log NEXT creation time in the property drawer under the key 'ACTIVATED'"
  (when (and (string= (org-get-todo-state) "NEXT")
             (not (org-entry-get nil "ACTIVATED")))
    (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))
(add-hook 'org-after-todo-state-change-hook #'log-todo-next-creation-date)

(setq org-agenda-custom-commands
      '(("g" "Get Things Done (GTD)"
         ((agenda ""
                  ((org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'deadline))
                   (org-deadline-warning-days 0)))
          (todo "NEXT"
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'deadline))
                 (org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-overriding-header "\nTasks\n")))
          (agenda nil
                  ((org-agenda-entry-types '(:deadline))
                   (org-agenda-format-date "")
                   (org-deadline-warning-days 7)
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'notregexp "\\* NEXT"))
                   (org-agenda-overriding-header "\nDeadlines")))
          (tags-todo "inbox"
                     ((org-agenda-prefix-format "  %?-12t% s")
                      (org-agenda-overriding-header "\nInbox\n")))
          (tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "\nCompleted today\n")))))))

;; log time for each task C-c C-x C-i (clocl in)
;; C-c C-x C-o (clock out)
(setq org-log-done 'time)

;; custom company config
(setq company-minimum-prefix-length 1
    company-tooltip-limit 4
    company-tooltip-minimum 4
    company-tooltip-align-annotations t
    company-tooltip-flip-when-above t
    company-require-match 'never
    company-global-modes
    '(not erc-mode
          message-mode
          help-mode
          gud-mode
          vterm-mode)
    company-frontends
    '(company-pseudo-tooltip-frontend  ; always show candidates in overlay tooltip
      company-echo-metadata-frontend)  ; show selected candidate docs in echo area

    ;; Buffer-local backends will be computed when loading a major mode, so
    ;; only specify a global default here.
    company-backends '(company-capf)

    ;; These auto-complete the current selection when
    ;; `company-auto-commit-chars' is typed. This is too magical. We
    ;; already have the much more explicit RET and TAB.
    company-auto-commit nil

    ;; Only search the current buffer for `company-dabbrev' (a backend that
    ;; suggests text your open buffers). This prevents Company from causing
    ;; lag once you have a lot of buffers open.
    company-dabbrev-other-buffers nil
    ;; Make `company-dabbrev' fully case-sensitive, to improve UX with
    ;; domain-specific words with particular casing.
    company-dabbrev-ignore-case nil
    company-dabbrev-downcase nil
    company-idle-delay 0)  ; No delay in showing suggestions


;; wakatime
(use-package wakatime-mode
  :ensure t)
;; enable for all buffers
(global-wakatime-mode)
