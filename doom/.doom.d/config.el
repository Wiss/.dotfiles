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
(setq
      org_directory (file-name-concat (getenv "HOME") "Documents/braindump")
      org-directory org_directory
      org_projects (directory-files-recursively
                         (file-name-concat org-directory "projects") "\\.org$")
      ;;org_notes (list org_projects)
      org_gtd (file-name-concat org-directory "gtd")
      org_journal (file-name-concat org-directory "journal")
      org_roam (file-name-concat org-directory "roam")
      org-roam-directory org_roam ;; org-directory
      ;;org_roam_ids (file-name-concat org_roam ".orgids")
      ;;org-id-locations-file org_roam_ids
      zot_bib (file-name-concat org-directory "zotLib.bib")
      ;org-agenda-files (list org_notes org_gtd org_journal org_roam ))
      org-agenda-files (directory-files-recursively org-directory "\\.org$"))

;; define the base path for custom python scripts
(setq p-script-dir "~/.dotfiles/doom/.doom.d/scripts/python/")
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq-default display-line-numbers-type 'visual ;t
              display-fill-column-indicator-column 80) ; Emacs columns are 0-based
(global-display-fill-column-indicator-mode)

;; set mouse usage in terminal
(xterm-mouse-mode 1)

;; autosave
(setq auto-save-default t
      make-backup-files t)

;; start files in overview view
(setq org-startup-folded t)

;; enable org-modern-mode
(add-hook 'org-mode-hook #'org-modern-mode)
(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

;; lsp
;; enable lsp display hierarchy
(setq lsp-headerline-breadcrumb-enable t)
(setq lsp-file-watch-threshold 5000)
(with-eval-after-load 'lsp-mode
  ;;(add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.my-folder\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]__pycache__\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]venv\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\].ipynb_checkpoints\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\].git\\'")
  ;; or
  ;;(add-to-list 'lsp-file-watch-ignored-files "[/\\\\]\\.my-files\\'")
  )

(setq python-check-command (executable-find "flake8"))

(use-package! lsp-diagnostics)
(after! (flycheck python)
  (lsp-diagnostics-flycheck-enable)
  (flycheck-add-next-checker 'lsp '(t . python-flake8)))

;; enable org-id-link-to-org-use-id for linking id properties
 (setq org-id-link-to-org-use-id 'use-existing)

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
(setq
      org_gtd_inbox (file-name-concat org_gtd "inbox.org")
      org_gtd_tickler (file-name-concat org_gtd "tickler.org")
      org_gtd_notes (file-name-concat org_gtd "notes.org")
      org_gtd_calendar (file-name-concat org_gtd "calendar.org")
 )

(after! org
(setq org-capture-templates
      ;; GTD
      '(("t" "Todo [inbox]" entry
        (file+headline org_gtd_inbox "Tasks")
        "* TODO %i%?\n:CREATED: %U")
      ("T" "Tickler" entry
        (file+headline org_gtd_tickler "Tickler")
        "* %i%?\n:CREATED: %U")
      ("n" "Note" entry
        (file+headline org_gtd_notes "Notes")
        "* NOTE (%a)\n%i%?\n:CREATED: %U")
      ("e" "Event" entry
        (file+headline org_gtd_calendar "Future")
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
(add-hook 'org-agenda-mode-hook
          (lambda ()
            (setq display-line-numbers 'relative))) ; Options: t, 'relative, or nil

(setq org-agenda-custom-commands
      '(("g" "Get Things Done (GTD)"
         ((agenda "*"
                  ((org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'deadline))
                   (org-agenda-start-day nil)
                   (org-agenda-span 5)
                   (org-deadline-warning-days 0)))
          (todo "NEXT|WIP"
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'deadline))
                 (org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-overriding-header "Tasks (NEXT and WIP)\n")))
          (agenda ""
                  ((org-agenda-entry-types '(:deadline))
                   (org-agenda-span 10)
                   (org-agenda-show-all-dates nil)
                   (org-agenda-prefix-format " %-12:c%?-12t% s [%e] ")
                   (org-deadline-warning-days 10)
                   (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "Deadlines\n")))
          (agenda ""
                  ((org-agenda-entry-types '(:scheduled))
                   (org-agenda-span 30)
                   (org-agenda-show-all-dates nil)
                   (org-agenda-prefix-format " %-12:c%?-12t% s [%e] ")
                   (org-deadline-warning-days 10)
                   (org-agenda-overriding-header "Scheduled\n")))
          (todo "WAITING"
                ((org-agenda-skip-function
                  '(org-agenda-skip-entry-if 'deadline))
                 (org-agenda-prefix-format "  %i %-12:c [%e] ")
                 (org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Waiting tasks\n")))
          (tags-todo "+PRIORITY=\"A\"+DEADLINE>\"<+10d>\"|+PRIORITY=\"A\"-DEADLINE={.}"
                     ((org-agenda-overriding-header "Important but not urgent")))
          (tags-todo "Inbox"
                     ((org-agenda-prefix-format "  %?-12t% s")
                      (org-agenda-overriding-header "Inbox\n")))
          (tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "Completed today\n")))))
      ("p" "Daily agenda and top priority tasks"
         ((tags-todo "*"
                     ((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamp)))
                      (org-agenda-skip-function
                       `(org-agenda-skip-entry-if
                         'notregexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
                      (org-agenda-block-separator nil)
                      (org-agenda-overriding-header "Important tasks without a date\n")))
          (agenda "" (;(org-agenda-start-day "+0d")
                      (org-agenda-start-day nil)
                      (org-agenda-span 1)
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
                      (org-agenda-overriding-header "\nUpcoming deadlines (+14d)\n")))))
      ("e" "Eisenhower matrix"
       ((tags-todo "+PRIORITY=\"A\"+DEADLINE<=\"<+10d>\""
                   ((org-agenda-overriding-header "Urgent (within 10 days) and important")))
        (tags-todo "+PRIORITY=\"A\"+DEADLINE>\"<+10d>\"|+PRIORITY=\"A\"-DEADLINE={.}"
                   ((org-agenda-overriding-header "Important but not urgent")))
        (tags-todo "-PRIORITY=\"A\"+DEADLINE<=\"<+10d>\""
                   ((org-agenda-overriding-header "Urgent (within 10 days) but not important")))
        (tags-todo "-PRIORITY=\"A\"+DEADLINE>\"<+10d>\"|-PRIORITY=\"A\"-DEADLINE={.}"
                   ((org-agenda-overriding-header "Neither important nor urgent"))))
       nil)
      ))

;; log time for each task C-c C-x C-i (clock in)
;; C-c C-x C-o (clock out)
(setq org-log-done 'time)

;; citar
(setq!
        citar-bibliography zot_bib ;;'("~/braindump/zotLib.bib"))
        citar-notes-paths (list org_roam) ;;'("~/braindump/notes/"))
)
;;(setq! citar-symbols
;;      `((file ,(all-the-icons-faicon "file-o" :face 'all-the-icons-green :v-adjust -0.1) . " ")
;;        (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) . " ")
;;        (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) . " ")))
(setq! citar-symbol-separator "  ")
(add-hook 'LaTeX-mode #'citar-capf-setup)
(add-hook 'org-mode #'citar-capf-setup)

(after! ox-latex
(add-to-list 'org-latex-classes
             '("org-plain-latex"
               "\\documentclass{article}
                [NO-DEFAULT-PACKAGES]
                [PACKAGES]
                [EXTRA]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(global-set-key (kbd "C-c s") 'citar-open)

;; journal and roam
(setq org-roam-dailies-directory org_journal
      org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %<%H:%M> - %?"
         :target (file+head "%<%Y%m%d>.org"
                            "#+title: %<%A, %x | week %W | day %j>\n #+setupfile: ~/Documents/braindump/org-html-themes/org/theme-readtheorg.setup\n\n"))))
;; org journal
 (setq org-journal-file-format "%Y%m%d.org")

(setq org-roam-capture-templates
      '(("d" "default" plain "%?"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+setupfile: ~/Documents/braindump/org-html-themes/org/theme-readtheorg.setup\n\n")
         :unnarrowed t)

        ("n" "note" plain
         "* resources\n* what is it?\n* why is it important?\n* how to use it?\n* notes\n%?"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+setupfile: ~/Documents/braindump/org-html-themes/org/theme-readtheorg.setup\n\n")
         :unnarrowed t)))

;;
;; journal keybinding
(global-set-key (kbd "C-c j i") 'org-journal-new-entry)
(global-set-key (kbd "C-c j n") 'org-roam-dailies-capture-today)
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

(setq +latex-viewers '(pdf-tools))

; If we are workig on a machine with macOS
(if IS-MAC
(when (fboundp 'mac-auto-operator-composition-mode)
(setq   (mac-auto-operator-composition-mode t)
        doom-font (font-spec :family "Fira Code" :size 13)
        doom-unicode-font (font-spec :family "Fira Mono" :size 13)
        doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13)
        global-prettify-symbols-mode nil)
;; pretty-symbols are not working. This should be fixed!
)
)

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))


;; remap
(global-set-key (kbd "C-c z") 'org-cycle-list-bullet)
;;(global-set-key (kbd ".") 'repeat)
(global-set-key (kbd "C-c C-x") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)
(global-set-key (kbd "C-c C-t") 'comment-or-uncomment-region)
;; remap find
(map! :leader
      "f a" #'consult-find
      )

;; zsh
(defun zsh ()
  (interactive)
  (term "/bin/zsh"))
(global-set-key (kbd "C-c t") 'zsh)

;; ellama
(use-package ellama
  :init
  ;; setup key bindings
  (setopt ellama-keymap-prefix "C-c e")
  ;; language you want ellama to translate to
  (setopt ellama-language "English")
  (require 'llm-ollama)
  ;; this model should be pulled to use it
  ;; value should be the same as you print in terminal during pull
  (setopt ellama-provider
		  (make-llm-ollama
		   :chat-model "llama3.2" :embedding-model "lamma3.2"
                   )))

;; gptel
(load (expand-file-name "secrets.el" doom-user-dir) t t)
(use-package gptel
 :config
 (setq! gptel-api-key nil))
;; OPTIONAL configuration
(setq
 gptel-model 'gemma3:latest
 gptel-backend (gptel-make-ollama "Ollama"
                 :host "localhost:11434"
                 :stream t
                 :models '(
                           gemma3:latest
                           lamma3.2:latest
                           deepseek-r1:latest
                           )))

(gptel-make-gemini "Gemini" :key my-gemini-api-key :stream t)

(defun org-export-to-html-and-commit ()
  "Export the current Org file to HTML and update the Git project."
  (interactive)
  (when (and buffer-file-name
             (string-equal (file-name-extension buffer-file-name) "org"))
    (let* ((html-file (concat (file-name-sans-extension buffer-file-name) ".html"))
           (git-project-dir "~/Documents/rcapinet_demo/docs/") ;; Replace with your Git project path
           (git-html-file (expand-file-name (file-name-nondirectory html-file) git-project-dir)))
      ;; Export the Org file to HTML
      (org-export-to-file 'html html-file)
      (message "Exported to HTML: %s" html-file)

      ;; Copy the HTML file to the Git project
      (copy-file html-file git-html-file t)
      (message "Copied %s to %s" html-file git-project-dir)

      ;; Commit the changes to Git
      (let ((default-directory git-project-dir))
        (shell-command (format "git add %s" (shell-quote-argument git-html-file)))
        (shell-command "git commit -m 'update notes'")
        (message "updated git project at %s" git-project-dir)))))

(defun org-generate-piechart ()
  " generate a pie chart from the current Org table
   and insert the result the below the table "
  (interactive)
  (when (org-at-table-p)
    (let* ((table (cl-remove-if (lambda (row) (equal row 'hline)) (org-table-to-lisp))) ;; Filter out hline
           (org-file (buffer-file-name)) ;; current org file
           (python-script (expand-file-name "work_time.py" p-script-dir))
           (temp-file (make-temp-file "table-data-" nil ".txt")) ;; Temporary file for table data
           (output-file (concat (file-name-directory org-file) "piechart.png")) ;; Output file path in same directory
           (table-str (mapconcat (lambda (row) (string-join row "\t")) table "\n"))) ;; Convert table to tab-delimited string
      ;; Write the table to a temporary file
      (with-temp-file temp-file
        (insert table-str))
      ;;(message "Temp file content: %s" table-str)
      ;; Call the Python script
      (call-process "python3" nil "*PieChart Output*" t python-script temp-file output-file)
      ;; insert the results below the table
      (if (file-exists-p output-file)
        (save-excursion
                (goto-char (org-table-end))
                (insert "\n#+RESULTS:\n")
                (insert (concat "[[file:" output-file "]]\n"))
        ;; Clean up the temporary file
        (delete-file temp-file)
        ;; Optionally refresh Org inline images
        (org-display-inline-images))
     (message "Error: Pie chart was not generated.")))))

;; pyenv
(use-package! pyvenv
  :config
  (setq pyvenv-default-virtual-env-name "venv")  ;; Default venv directory name
  ;;(setq pyvenv-workon "~/.pyenv/versions/")      ;; Ensure compatibility with Pyenv
  (pyvenv-tracking-mode 1)
  )                      ;; Auto-detect venv when opening a Python file


;; spell
(setq ispell-extra-args '("--lang=es" "--lang=default"))
