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

;; Variables
(setq zot_bib (concat (getenv "HOME") "/Documents/org/zotLib.bib")
      org_directory (concat (getenv "HOME") "/Documents/org/")
      org_projects (concat (getenv "HOME") "/Documents/org/projects/")
      org_notes (list org_projects)
      org_gtd (concat (getenv "HOME") "/Documents/org/gtd/")
      org_journal (concat (getenv "HOME") "/Documents/org/journal/")
      org_roam (concat (getenv "HOME") "/Documents/org/roam/")
      org-directory org_directory
      org-agenda-files (list org_directory org_gtd org_roam org_projects))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t
      display-fill-column-indicator-column 79 ; 80 column indicator - Emacs columns are 0-based...
      global-display-fill-column-indicator-mode 1)

;; autosave
(setq auto-save-default t
      make-backup-files t)

;; start files in overview view
(setq org-startup-folded t)

;; enable org-modern-mode
(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

;; enable lsp display hierarchy
(setq lsp-headerline-breadcrumb-enable t)

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

;; Keybindings from Org Manual
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)


;; org-capture templates
;; with the specifier %i you will copy and paste all the highlited text in the tempalte
;; syntaxis https://orgmode.org/manual/Template-expansion.html
(after! org
(setq org-capture-templates
      ;; GTD
      '(("t" "Todo [inbox]" entry
        (file+headline "~/Documents/org/gtd/inbox.org" "Tasks")
        "* TODO %i%?\n/Entered on: %U/")
      ("T" "Tickler" entry
        (file+headline "~/Documents/org/gtd/tickler.org" "Tickler")
        "* %i%?\n/Entered on: %U/")
      ("n" "Note" entry
        (file+headline "~/Documents/org/gtd/notes.org" "Notes")
        "* NOTE (%a)\n%i%?\n/Entered on/ %U")
      ("e" "Event" entry
        (file+headline "~/Documents/org/gtd/calendar.org" "Future")
        "* %i%? :meeting:\n%^T"))
))
;; Key-bind reminder
;; C-c c < capture
;; C-c C-w < refile
;; C-c C-c (headline) < creates tag
;; C-c C-t (headline) < binds todo keyword
;; C-c C-s < schedules
;; C-c C-d < deadline

;; refile for GTD
(setq org-refile-targets '((org-agenda-files :maxlevel . 4)))
;; allows creating parent path
(setq org-refile-allow-creating-parent-nodes 'confirm)

;; more todo keywords for GTD
(after! org
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "WIP(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
      ))

;; create activated keyword
(defun log-todo-next-creation-date (&rest ignore)
  "Log NEXT creation time in the property drawer under the key 'ACTIVATED'"
  (when (and (string= (org-get-todo-state) "NEXT")
             (not (org-entry-get nil "ACTIVATED")))
    (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))
(add-hook 'org-after-todo-state-change-hook #'log-todo-next-creation-date)

;;(setq org-agenda-custom-commands
(setq org-agenda-custom-commands
      '(("g" "Get Things Done (GTD)"
         ((agenda "*"
                  ((org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'deadline))
                   (org-deadline-warning-days 0)))
          (todo "NEXT|WIP"
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'deadline))
                 (org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-overriding-header "Tasks\n")))
          (agenda ""
                  ((org-agenda-entry-types '(:deadline))
                   (org-agenda-span 10)
                   (org-agenda-show-all-dates nil)
                 (org-agenda-prefix-format " %-12:c%?-12t% s [%e] ")
                   (org-deadline-warning-days 0)
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "Deadlines\n")))
          (agenda ""
                  ((org-agenda-entry-types '(:scheduled))
                   (org-agenda-span 30)
                   (org-agenda-show-all-dates nil)
                 (org-agenda-prefix-format " %-12:c%?-12t% s [%e] ")
                   (org-deadline-warning-days 0)
                   (org-agenda-overriding-header "Scheduled\n")))
          (todo "WAITING"
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'deadline))
                 (org-agenda-prefix-format "  %i %-12:c [%e] ")
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Waiting tasks\n")))
          (tags-todo "Inbox"
                     ((org-agenda-prefix-format "  %?-12t% s")
                      (org-agenda-overriding-header "Inbox\n")))
          (tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "Completed today\n")))))
      ("A" "Daily agenda and top priority tasks"
         ((tags-todo "*"
                     ((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamp)))
                      (org-agenda-skip-function
                       `(org-agenda-skip-entry-if
                         'notregexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
                      (org-agenda-block-separator nil)
                      (org-agenda-overriding-header "Important tasks without a date\n")))
          (agenda "" ((org-agenda-span 1)
                      (org-deadline-warning-days 0)
                      (org-scheduled-past-days 0)
                      ;; We don't need the `org-agenda-date-today'
                      ;; highlight because that only has a practical
                      ;; utility in multi-day views.
                      (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                      (org-agenda-format-date "%A %-e %B %Y")
                      (org-agenda-overriding-header "\nToday's agenda\n")))
          (agenda "" ((org-agenda-start-on-weekday nil)
                      (org-agenda-start-day "+1d")
                      (org-agenda-span 3)
                      (org-deadline-warning-days 0)
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "\nNext three days\n")))
          (agenda "" ((org-agenda-time-grid nil)
                      (org-agenda-start-on-weekday nil)
                      ;; We don't want to replicate the previous section's
                      ;; three days, so we start counting from the day after.
                      (org-agenda-start-day "+4d")
                      (org-agenda-span 14)
                      (org-agenda-show-all-dates nil)
                      (org-deadline-warning-days 0)
                      (org-agenda-entry-types '(:deadline))
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "\nUpcoming deadlines (+14d)\n")))))))

;; log time for each task C-c C-x C-i (clock in)
;; C-c C-x C-o (clock out)
(setq org-log-done 'time)


;; citar
(setq! citar-bibliography zot_bib) ;;'("~/braindump/zotLib.bib"))
(setq! citar-notes-paths (list org_roam)) ;;'("~/braindump/notes/"))
;;(setq! citar-symbols
;;      `((file ,(all-the-icons-faicon "file-o" :face 'all-the-icons-green :v-adjust -0.1) . " ")
;;        (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) . " ")
;;        (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) . " ")))
(setq! citar-symbol-separator "  ")
(add-hook 'LaTeX-mode #'citar-capf-setup)
(add-hook 'org-mode #'citar-capf-setup)

(global-set-key (kbd "C-c s") 'citar-open)

;; journal and roam
(setq org-roam-directory org_roam
      org-roam-dailies-directory org_journal
      org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))
;; journal keybinding
(global-set-key (kbd "C-c j i") 'org-journal-new-entry)
;; roam notes keybinding
(global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
(global-set-key (kbd "C-c n f") 'org-roam-node-find)
(global-set-key (kbd "C-c n i") 'org-roam-node-insert)

;; Bibtex
;;(use-package org-roam-bibtex
;;  :after org-roam
;;  :hook (org-roam-mode . org-roam-bibtex-mode)
;;  :config
;;  (setq orb-preformat-keywords
;;        '("citekey" "title" "url" "author-or-editor" "keywords" "file")
;;        orb-process-file-keyword t
;;        orb-attached-file-extensions '("pdf")))

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

;; package templates
;; FIX
;; /project_[a-zA-Z0-9_]+\.org$
(set-file-template! "/project_.+\\.org$" :trigger "__project_custom.org" :mode 'org-mode)
(set-file-template! "/in_\\.org$" :trigger "__invoice.org" :mode 'org-mode)
;;(set-file-template! "/project_*+\\.org$" :trigger "__project_custom.org" :mode 'org-mode)

;; wakatime
(use-package wakatime-mode
  :ensure t)
;; enable for all buffers
(global-wakatime-mode)

;; pdf-tools
(use-package pdf-tools
  :ensure t
  :init
  (pdf-tools-install))
