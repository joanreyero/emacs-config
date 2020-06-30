;;;  Huge mess of an org-mode configuration file, the derelict of many
;;;  years of piling up tweaks.

;;; Encrypt when :crypt is a tag
(require 'org-crypt)


(org-crypt-use-before-save-magic)
(setq org-crypt-key "Juan Reyero")
(global-set-key "\C-ce" 'org-decrypt-entry)
(global-set-key "\C-ca" 'org-agenda)

(defun esf/execute-startup-block ()
  (interactive)
  (org-babel-goto-named-src-block "startup")
  (org-babel-execute-src-block))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (dot . t)
   (ditaa . t)
   (emacs-lisp . t)
   (gnuplot . t)
   (python . t)
   (screen . nil)
   (shell . t)
   (sql . nil)))
(setq org-confirm-babel-evaluate nil)
;;(setq org-babel-python-command "/usr/bin/python")

(require 'ox-md)
;; (require 'ox-leanpub)
;;(require 'org-drill)

;(require 'mmm-mode)



(add-hook 'org-mode-hook (lambda ()
  (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)))

(require 'ox-latex)

;;; Syntax highlighting (requires pygmentize)
;;;
;;; We need to add a nil after minted so that it doesn't get added
;;; when doing preview; it makes it fail, because no -shell-escape is
;;; used in preview.
;;; http://orgmode.org/worg/org-tutorials/org-latex-preview.html#sec-6-2
;;;
(add-to-list 'org-latex-packages-alist '("" "minted" nil))
(setq org-latex-listings 'minted
      org-latex-pdf-process
      '("/Library/TeX/texbin/pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "/Library/TeX/texbin/pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "/Library/TeX/texbin/pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")
      org-format-latex-options '(:foreground default
                                 :background default
                                 :scale 1.2
                                 :html-foreground "Black"
                                 :html-background "parent"
                                 :html-scale 1.0
                                 :matchers
                                 ("begin" "$1" "$" "$$" "\\(" "\\[")))

(defcustom org-latex-tables-centered t
  "When non-nil, tables are exported in a center environment."
  :group 'org-export-latex
  :type 'boolean)

;;; here to remove latex pngs
(setq org-latex-preview-ltxpng-directory ".ltxpng/"
      ;;org-latex-image-default-option "width=13cm"
      ;; org-export-with-LaTeX-fragments 'dvipng
      org-export-with-latex t
      org-html-head "<style>.tag {background-color: #fff; font-weight:normal;}</style>"
      org-html-postamble nil)


;(setq org-latex-create-formula-image-program 'dvipng)



(setq org-html-htmlize-output-type 'css)

;;; Required to make link export in latex work (???)
(add-to-list 'org-modules 'org-id)

(add-to-list 'org-modules 'org-eww)

(setq org-id-link-to-org-use-id t
      org-hide-emphasis-markers t)

(require 'org-mac-link)
(global-set-key (read-kbd-macro "C-x m")
                'org-mac-message-insert-selected)
(define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)

;;;(defun yas/org-very-safe-expand ()
;;;  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

;;(add-hook 'org-mode-hook
;;          (lambda ()
;;            (define-key org-mode-map "\C-co"
;;              'org-ctags-find-tag-interactive)
;;            (local-set-key "\M-I" 'org-toggle-inline-images)))

;;(setq org-ctags-path-to-ctags "/usr/local/bin/ctags")
;;(setq org-ctags-open-link-functions
;;      '(org-ctags-find-tag))
;;(require 'org-ctags)
;;(global-set-key (kbd "<M-kp-multiply>") 'pop-tag-mark)

(setq org-directory "~/"
      ;org-default-notes-file (concat org-directory "joanreyero.org")
      org-attach-directory "Attach/"
      org-attach-method 'mv)

(setq org-tags-column -80)


(setq org-ellipsis "⤵"
      org-src-fontify-natively t
      ;org-special-ctrl-a/e rever
      org-hide-leading-stars nil
      ;;org-odd-levels-only t
      org-fontify-done-headline t
      org-fontify-emphasized-text t
      org-enforce-todo-dependencies t
      org-agenda-span 7
      org-agenda-start-on-weekday nil
      org-deadline-warning-days 5
      org-agenda-show-all-dates t
      org-agenda-show-inherited-tags nil
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-scheduled-if-done t
      org-agenda-todo-list-sublevels t
      org-agenda-diary-file "~/Dropbox/joanreyero/diary.org"
      org-hierarchical-todo-statistics nil
      org-agenda-restore-windows-after-quit nil
      org-agenda-include-diary nil)

(setq org-startup-folded t
      org-startup-indented t
      org-indent-indentation-per-level 2
      ;;org-hide-block-startup 'hideblocks
)

(defun org-mac-chrome-get-frontmost-description ()
  (interactive)
  (message "Applescript: Getting Safari url...")
  (let* ((url-and-title (org-mac-chrome-get-frontmost-url))
         (split-link (split-strin g url-and-title "::split::"))
         (URL (car split-link)))
    (cadr split-link)))



(defun make-orgcapture-frame ()
  "Create a new frame and run org-capture."
  (interactive)
  (make-frame '((name . "remember") (width . 80) (height . 16)
                (top . 400) (left . 300)
                (font . "-apple-Monaco-medium-normal-normal-*-13-*-*-*-m-0-iso10646-1")
                ))
  (select-frame-by-name "remember")
 (org-capture))

(setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline "~/Dropbox/inbox.org" "Todos")
        "* TODO %^{Brief Description}\n"
        :prepend t)
        ("d" "Diary entry" entry (file "~/Dropbox/diary.org")
        "* %^{Day}t\n** Food\n** Exercise\n** Notes about the day\n** The day after\n"
        :prepend t)
;;         ("e" "One-time event" entry (file+headline "~/Dropbox/joanreyero/joanreyero.org" "One-time events")
;;          "* %^{Brief Description} %^g\n%^t \n :PROPERTIES:\n:CATEGORY: me\n:CREATED: %U\n:END:%?"
;;          :prepend t :empty-lines 0)
;;         ;("m" "Mail" entry (file+headline "~/gsk/create/bitacora.org" "Inbox")
;;         ;     "* TODO %?\n:PROPERTIES:\n:on: %U\n:END:\n\n [[%:link][%:description]]\n%i"
;;         ;     :empty-lines 1)
;;         ("n" "Note" entry (file+headline "~/Dropbox/joanreyero/inbox.org" "Note Inbox")
;;              "* %? :note:\n%i\n%a\n\n"
;;              :prepend t :empty-lines 1)
;;         ("d" "Diary entry" entry (file "~/Dropbox/joanreyero/diary.org")
;;              "* %u \n:PROPERTIES:\n:LOCATION: %^{Location}\n:CATEGORY: diary\n:END:\n%i\n\n"
;;              :prepend t :empty-lines 1)
;;         ;("p" "project" entry
;;         ; (file+headline "~/cjr/cjr.org" "Open")
;;         ; "* %? :prj:\n:PROPERTIES:\n:on: %U\n:category: %^{Category}\n:END:\n\n"
;;         ; :prepend t :empty-lines 1)
         ("b" "auto-bookmark" entry (file+headline "~/Dropbox/inbox.org" "Bookmarks")
         "* %(org-mac-chrome-get-frontmost-url)\n"
         :prepend t)
        ("B" "bookmark" entry (file+headline "~/Dropbox/inbox.org" "Bookmarks")
         "* %^{Description}\n %(org-mac-chrome-get-frontmost-url)"
         :prepend t)
;;         ("h" "Habit" entry (file+headline "~/Dropbox/joanreyero/joanreyero.org" "Habits")
;;          "* TODO %^{Brief Description} %^g\n SCHEDULED: %^t \n:PROPERTIES:\n:CATEGORY: %^{Category}\n:CREATED: %U\n:END:\n%?"
        ;;          :prepend t :empty-lines 1)))

        ))

(define-key global-map "\C-cc" 'org-capture)

;;; Enable capture from mutt

(add-hook 'org-capture-mode-hook (lambda () (select-frame-set-input-focus (selected-frame))))

;;; (add-hook 'org-capture-mode-hook #'raise-frame)

;; ensure that emacsclient will show just the note to be edited when invoked
;; from Mutt, and that it will shut down emacsclient once finished;
;; fallback to legacy behavior when not invoked via org-protocol.

;;;(add-hook 'org-capture-mode-hook 'delete-other-windows)
;;;(setq my-org-protocol-flag nil)
;;;(defadvice org-capture-finalize (after delete-frame-at-end activate)
;;;  "Delete frame at remember finalization"
;;;  (progn (if my-org-protocol-flag (delete-frame))
2;;;         (setq my-org-protocol-flag nil)))
;;;(defadvice org-capture-kill (after delete-frame-at-end activate)
;;;  "Delete frame at remember abort"
;;;  (progn (if my-org-protocol-flag (delete-frame))
;;;         (setq my-org-protocol-flag nil)))
;;;(defadvice org-protocol-capture (before set-org-protocol-flag activate)
;;;  (setq my-org-protocol-flag t))

;;; https://unix.stackexchange.com/questions/22074/open-message-with-given-message-id-from-command-line-in-mutt

(defun open-mail-in-mutt (message)
  "Open a mail message in Mutt, using an external terminal."
  ;;(interactive "MPath or Message-ID: ")
  (shell-command
   (format "/Users/juanre/bin/mutt-notmuch-py --query=\"id:%s\"; /Users/juanre/bin/term.sh \"/usr/local/bin/mutt -f /Users/juanre/.cache/mutt_results -e 'push l~i%s\\n' -e 'toggle sidebar_visible' && /Users/juanre/bin/close.sh\"" message message)))
  ;; (shell-command
  ;;  (format "/Users/juanre/bin/term.sh \"/usr/local/bin/mutt -e 'push l~i%s\\n'\"" message)))

;; add support for "mutt:ID" links
(org-add-link-type "mutt" 'open-mail-in-mutt)

;; https://emacs.stackexchange.com/questions/38171/org-external-link-can-i-indicate-which-browser-tab-to-be-used

;; not working
;;(org-link-set-parameters "chrome" :follow (lambda (path)
;;                                            (browse-url-chrome (concat "https:" path))))


;;(setq org-tag-alist '(("@learn" . ?l) ("@home" . ?h) ("@program" . ?p)
;;                      ("@write" . ?w) ("@organize" . ?o) ("@mwa" . ?m)
;;                      ("prj" . ?P)))

;; ("b" "Bookmark" entry (file+headline "~/cjr/cjr.org" "Bookmarks") "* [[%^{URL}][%^{Description}]]
;;"))))

(setq org-archive-location "~/Dropbox/joanreyero/Archive/2020.org::* %s")

;;; org-mtags allows you to use <quote></quote>, <src
;;; lang="python"></src>, and other convenient tags.
;;; (require 'org-mtags) ;; looks like it has been droppped 2010-07-27

;;; htmlize is used to fontify the exports of source code as in an
;;; emacs buffer
(add-to-list 'load-path "~/.emacs.d/htmlize.el")
(require 'htmlize)


(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
;(global-set-key "\C-ca" 'org-agenda)

(add-hook 'org-mode-hook 'turn-on-font-lock)
(setq org-log-done 'time
      org-use-fast-todo-selection t)
(setq org-use-tag-inheritance t
      org-use-property-inheritance t)

;;; Clocking
(setq org-log-into-drawer t
      org-clock-modeline-total 'today
      org-clock-persist 'history)
(org-clock-persistence-insinuate)

;;(setq org-todo-keywords
;;      '((sequence "TODO(t)" "CODE(c/!)" "DECIDE(D/!)" "WAITING(w/!)" "|"
;;                  "DONE(d/!)" "IMPLEMENTED(i/!)" "DECIDED(e/!)"
;;                  "POSTPONED(p/!)" "CANCELED(n/!)")))

(setq org-todo-keywords
      '((sequence "TODO(t)" "PROJECT(P)" "WORKING(w)" "|" "DONE(d)" "CANCELED(n)")
        (sequence "READ(r)" "CODE(c)" "|" "WAITING(W)")
        (sequence "DECIDE(D)" "|" "DECIDED(e)" "POSTPONED(p)")))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "Orange3" :weight bold))
        ("DONE" . (:foreground "#09ab82"))
        ("PROJECT" . (:foreground "#a15420" :weight bold))
        ("WORKING" . (:foreground "#c7780a" :weight bold))
        ("CANCELLED" . (:foreground "forest green"))
        ("CODE" . (:foreground "#630b14" :weight bold))
        ("READ" . (:foreground "#a16223" :weight bold))
        ("REJECTED" . (:foreground "forest green"))
        ("DECIDE" . (:foreground "orange"))
        ("DECIDED" . (:foreground "light sea green"))
        ("WAITING" . (:foreground "forest green"))
        ("POSTPONED" . (:foreground "forest green"))))
        ;;("TASK" . (:foreground "orange"))))


;;; Make an entry change state when its children change.  Only works
;;; when the entry has a statistics cookie ([/] or [%]).  Does not
;;; understand it as started until one of the sub-tasks has started.
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)


;; (require 'org-secretary)

(defun org-save-location ()
  "Adds a :with: property with the value of org-sec-with if
   defined, an :at: property with the value of org-sec-where
   if defined, and an :on: property with the current time."
  (interactive)
  (save-excursion
    (org-entry-put nil "on" (format-time-string
                             (org-time-stamp-format 'long t)
                             (current-time)))
    (org-entry-put nil "at" (shell-command-to-string "PATH=/usr/local/bin whereami"))
    ;;(unless (string= org-sec-where "")
    ;;  (org-entry-put nil "at" org-sec-where))
    ;;(if org-sec-with
    ;;    (org-entry-put nil "with" org-sec-with))
    ))
;;; Overwrite org-sec-tag-entry defined in org-secretary
(global-set-key "\C-cj" 'org-save-location)


;; (defun org-sec-stuck-cjr (par)
;;   "Select stuck projects with label cjr."
;;   (let ((org-stuck-projects
;;          `(,(concat "+prj+cjr"
;;                     "/-MAYBE-DONE")
;;            ("TODO" "TASK") ())))
;;     (org-agenda-list-stuck-projects)))

;; (defun org-sec-stuck-gsk (par)
;;   "Select stuck projects without label cjr."
;;   (let ((org-stuck-projects
;;          `(,(concat "+prj-cjr"
;;                     "/-MAYBE-DONE")
;;            ("TODO" "TASK") ())))
;;     (org-agenda-list-stuck-projects)))

;; (defun org-cjr-agenda-skip-unless-tag (tag)
;;   "Skip all entries that do not have TAG."
;;   (let ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
;;         (current-headline (or (and (org-at-heading-p)
;;                                    (point))
;;                               (save-excursion (org-back-to-heading)))))
;;     (if (not (member tag (org-get-tags-at current-headline)))
;;         next-headline
;;       nil)))

(defun org-agenda-skip-if-tag (tag)
   "Skip all entries that have TAG."
   (let ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
         (current-headline (or (and (org-at-heading-p)
                                    (point))
                               (save-excursion (org-back-to-heading)))))
     (if (member tag (org-get-tags-at current-headline))
         next-headline
       nil)))

;; (defvar org-sec-at nil
;;   "Value of the current context. Change it with org-sec-set-at,
;;    set to C-c w.  Defaults to org-sec-me")

;; (defvar org-sec-at-history '()
;;   "History list of at status")

;; (defun org-sec-set-at ()
;;   "Changes the value of the org-sec-at variable that defines the context."
;;   (interactive)
;;   (setq org-sec-at (let ((w (read-string "Context: " nil
;;                                            'org-sec-at-history "")))
;;                        (if (string= w "")
;;                            nil
;;                          w))))
;; (global-set-key "\C-cC" 'org-sec-set-at)

;; (defun org-sec-at-view (par &optional at)
;;   "Select tasks marked as dowith=who, where who defaults to the
;;    value of org-sec-with."
;;   (org-tags-view '(4) (concat par "+" org-sec-at)))


(setq org-agenda-custom-commands
      '(;;("w" "Waiting" todo "WAITING|POSTPONED" nil)
        ;;("A" "Agenda 30 days" agenda "" ((org-agenda-ndays 30)))
        ("a" "Agenda and Todos"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:\n")))
          (todo "WORKING"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Tasks in progress")))
          (todo "WAITING"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo))
                 (org-agenda-overriding-header "Tasks on hold")))
          (agenda "" ((org-agenda-ndays 1)))
          ;; (alltodo ""
          ;;          ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
          ;;                                          (air-org-skip-subtree-if-priority ?A)
          ;;                                          (org-agenda-skip-if nil '(scheduled))))
          ;;                                          ;;(org-agenda-skip-if-tag "reading")))
          ;;           (org-agenda-overriding-header "ALL normal priority tasks:"))))
          
         (alltodo ""
                   ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                   (air-org-skip-subtree-if-priority ?A)
                                                   (org-agenda-skip-if nil '(scheduled))))
                                                   ;;(org-agenda-skip-if-tag "reading")))
                    (org-agenda-overriding-header "ALL normal priority tasks:"))))
         ((org-agenda-compact-blocks nil)))
        ("t" "Todos"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:\n")))
                                        ; (agenda "" ((org-agenda-ndays 1)))
          (todo "WORKING"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Tasks in progress")))
          (todo "WAITING"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo))
                 (org-agenda-overriding-header "Tasks on hold")))
          (alltodo ""
                   ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
                                                   (air-org-skip-subtree-if-priority ?A)
                                                   (org-agenda-skip-if nil '(scheduled))))
                                                   ;;(org-agenda-skip-if-tag "reading")))
                    (org-agenda-overriding-header "ALL normal priority tasks:"))))

         ((org-agenda-compact-blocks nil)))

        ("h" "Habits"
         ((agenda "habit"
                   ()
                    (org-agenda-overriding-header "Habits:")))

         ((org-agenda-compact-blocks nil)))
        
        ;; ("p" "Personal todos"
        ;;  ((tags "PRIORITY=\"A\"+me"
        ;;         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
        ;;          (org-agenda-overriding-header "High-priority unfinished tasks:")))
        ;;   (todo "WORKING"
        ;;         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
        ;;          (org-agenda-overriding-header "Tasks in progress")))
        ;;   (todo "WAITING"
        ;;         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo))
        ;;          (org-agenda-overriding-header "Tasks on hold")))
        ;;   (tags-todo "me"
        ;;            ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
        ;;                                            (air-org-skip-subtree-if-priority ?A)
        ;;                                 ;(org-agenda-skip-if-tag "reading")
        ;;                                            (org-agenda-skip-if nil '(scheduled deadline))
        ;;                                            ))
        ;;             (org-agenda-overriding-header "ALL normal priority tasks:"))))
        ;;  ((org-agenda-compact-blocks nil)))
        ;; ("P" "Agenda and personal todos"
        ;;  ((tags "PRIORITY=\"A\"+me"
        ;;         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
        ;;          (org-agenda-overriding-header "High-priority unfinished tasks:")))
        ;;   (todo "WORKING"
        ;;         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
        ;;          (org-agenda-overriding-header "Tasks in progress")))
        ;;   (todo "WAITING"
        ;;         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo))
        ;;          (org-agenda-overriding-header "Tasks on hold")))
        ;;   (agenda "" ((org-agenda-ndays 1)))
        ;;   (tags-todo "me"
        ;;            ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
        ;;                                            (air-org-skip-subtree-if-priority ?A)
        ;;                                 ;(org-agenda-skip-if nil '(scheduled deadline))
        ;;                                            (org-agenda-skip-if nil '(scheduled))
        ;;                                            ))
        ;;             (org-agenda-overriding-header "ALL normal priority tasks:"))))
        ;;  ((org-agenda-compact-blocks nil)))
        ;; ("u" "Uni todos"
        ;;  ((tags "PRIORITY=\"A\"+uni"
        ;;         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
        ;;          (org-agenda-overriding-header "High-priority unfinished tasks:")))
        ;;   (todo "WORKING"
        ;;         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
        ;;          (org-agenda-overriding-header "Tasks in progress")))
        ;;   (todo "WAITING"
        ;;         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo))
        ;;          (org-agenda-overriding-header "Tasks on hold")))
        ;;   (tags-todo "uni"
        ;;            ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
        ;;                                            (air-org-skip-subtree-if-priority ?A)
        ;;                                            ;(org-agenda-skip-if-tag "reading")
        ;;                                            ))
        ;;             (org-agenda-overriding-header "ALL normal priority tasks:"))))
        ;;  ((org-agenda-compact-blocks nil)))
        ;; ("U" "Agenda and uni todos"
        ;;  ((tags "PRIORITY=\"A\"+uni"
        ;;         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
        ;;          (org-agenda-overriding-header "High-priority unfinished tasks:")))
        ;;   (todo "WORKING"
        ;;         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
        ;;          (org-agenda-overriding-header "Tasks in progress")))
        ;;   (todo "WAITING"
        ;;         ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo))
        ;;          (org-agenda-overriding-header "Tasks on hold")))
        ;;   (agenda "" ((org-agenda-ndays 1)))
        ;;   (tags-todo "uni"
        ;;            ((org-agenda-skip-function '(or (air-org-skip-subtree-if-habit)
        ;;                                            (air-org-skip-subtree-if-priority ?A)
        ;;                                 ;(org-agenda-skip-if nil '(scheduled deadline))
        ;;                                            (org-agenda-skip-if nil '(scheduled))
        ;;                                            ))
        ;;             (org-agenda-overriding-header "ALL normal priority tasks:"))))
        ;;  ((org-agenda-compact-blocks nil)))
        ;;("I" "Import diary from iCal" agenda ""
        ;; ((org-agenda-mode-hook
        ;;   (lambda ()
        ;;     (org-mac-iCal)))))
        ))


 (setq org-agenda-prefix-format
       (quote
        ((agenda . "  %-6:c%?-12t %s")
;;         (timeline . "  %s")
         (todo . "  %-6:c%-12T %s %l%l")
         (tags . "  %-6:c%-12T %s %l%l"))))
;;         (search . " %i %e "))))



(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))

(defun air-org-skip-subtree-if-habit ()
  "Skip an agenda entry if it has a STYLE property equal to \"habit\"."
  (let ((subtree-end (save-excursion (org-end-of-subtree t))))
    (if (string= (org-entry-get nil "STYLE") "habit")
        subtree-end
      nil)))

;; http://orgmode.org/worg/org-contrib/org-mac-iCal.html

;;   A common problem with all-day and multi-day events in org agenda
;;   view is that they become separated from timed events and are
;;   placed below all TODO items. Likewise, additional fields such as
;;   Location: are orphaned from their parent events. The following
;;   hook will ensure that all events are correctly placed in the
;;   agenda:

;; (add-hook 'org-agenda-cleanup-fancy-diary-hook
;;           (lambda ()
;;             (goto-char (point-min))
;;             (save-excursion
;;               (while (re-search-forward "^[a-z]" nil t)
;;                 (goto-char (match-beginning 0))
;;                 (insert "0:00-24:00 ")))
;;             (while (re-search-forward "^ [a-z]" nil t)
;;               (goto-char (match-beginning 0))
;;               (save-excursion
;;                 (re-search-backward "^[0-9]+:[0-9]+-[0-9]+:[0-9]+ " nil t))
;;               (insert (match-string 0)))))
;; (setq org-export-backends '(beamer))

;;;;;;;;;;;;;; Publishing
;;(require 'org-publish)

(defun slurp-file-to-string (file-name)
  "Read contents of file FILE-NAME and return as a string."
  (if (file-exists-p file-name)
      (with-temp-buffer
        (insert-file-contents file-name)
        (buffer-substring (point-min) (point-max)))
    ""))

(defun load-if-there (conf-file)
  (if (file-exists-p conf-file)
      (load-file conf-file)))

;;(load-if-there "~/cjr/jr/jr.el")
;;(load-if-there "~/web/tk/tk.el")
;;(load-if-there "~/cjr/jac/jac.el")
;;(load-if-there "~/xaar/org/style/xaar.el")
;;(load-if-there "~/prj/org-jekyll/test/org.el")

(require 'ox-html)
;;(load-file "~/prj/org-jekyll/org-jekyll.elc")
;;(setq org-jekyll-category "lang"
;;      org-jekyll-localize-dir "loc/")

(require 'ox-beamer)
(setq org-export-default-language "en")

;;;;;;;;;;;;;; Save and backup
;;; From http://doc.norang.ca/org-mode.html
(run-at-time "00:59" 3600 'org-save-all-org-buffers)
;;; Also run a cron job to commit the changes, crontab -e:
;;; 0 * * * * ~/bin/org-git.sh >/dev/null
;;; and the script looks like:
;;;
;;;#!/bin/sh
;;;
;;;# From http://doc.norang.ca/org-mode.html
;;;
;;;# Add org file changes to the repository
;;;REPOS="xaar/org cjr/note cjr/personal cjr/write"
;;;
;;;for REPO in $REPOS
;;;do
;;;    echo "Repository: $REPO"
;;;    cd ~/$REPO
;;;    # Remove deleted files
;;;    git ls-files --deleted -z | xargs -0 git rm >/dev/null 2>&1
;;;    # Add new files
;;;    git add . >/dev/null 2>&1
;;;    git commit -m "$(date)"
;;;done

(defun tasks-with-tag-old (person &optional scope)
  (let ((tasklist ()))
    (org-map-entries
     (lambda ()
       (let ((priority (nth 3 (org-heading-components))))
         (add-to-list 'tasklist
                      (list (if priority (char-to-string priority) "C")
                            (concat "[[" (nth 4 (org-heading-components)) "]]"))
                      t)))
     (concat person "/!TASK") scope)
    (sort tasklist (lambda (f s)
                     (string-lessp (car f) (car s))))))

(defun in-n-days-p (tm n)
  (< (- (time-to-days tm) (time-to-days (current-time))) n))

(defun tasks-with-tag (match-tag &optional scope)
  (let ((tasklist ()))
    (org-map-entries
     (lambda ()
       (let* ((priority (nth 3 (org-heading-components)))
              (date-scheduled (org-get-scheduled-time nil))
              (date-deadline (org-get-deadline-time nil))
              (tags (org-get-tags-at))
              (the-id (org-id-get-create))
              (deadline-close (if (and date-deadline
                                       (in-n-days-p date-deadline 7))
                                  "*"
                                ""))
              (scheduled-close (if (and date-scheduled
                                        (in-n-days-p date-scheduled 7))
                                   "/"
                                 ""))
              (fname (if (boundp 'ftname) ;; during export
                         (file-relative-name (buffer-file-name)
                                             (file-name-directory ftname))
                       (buffer-file-name)))
              (art-name (nth 4 (org-heading-components))))
         (add-to-list 'tasklist
                      (list (if priority (char-to-string priority) "C")
                            (concat scheduled-close deadline-close "[["
                                    "id:" the-id "][" art-name
                                    "]]" deadline-close scheduled-close))
                      t)))
     (concat match-tag "/!TODO")
     scope)
    (sort tasklist (lambda (f s)
                     (string-lessp (car f) (car s))))))

(defun entries-with-tag (match-tag &optional scope)
  (let ((tasklist ()))
    (org-map-entries
     (lambda ()
       (let* ((priority (nth 3 (org-heading-components)))
              (date-scheduled (org-get-scheduled-time nil))
              (date-deadline (org-get-deadline-time nil))
              (tags (org-get-tags-at))
              (the-id (org-id-get-create))
              (deadline-close (if (and date-deadline
                                       (in-n-days-p date-deadline 7))
                                  "*"
                                ""))
              (scheduled-close (if (and date-scheduled
                                        (in-n-days-p date-scheduled 7))
                                   "/"
                                 ""))
              (fname (if (boundp 'ftname) ;; during export
                         (file-relative-name (buffer-file-name)
                                             (file-name-directory ftname))
                       (buffer-file-name)))
              (art-name (nth 4 (org-heading-components))))
         (add-to-list 'tasklist
                      (list (if priority (char-to-string priority) "C")
                            (concat scheduled-close deadline-close "[["
                                    "id:" the-id "][" art-name
                                    "]]" deadline-close scheduled-close))
                      t)))
     match-tag
     scope)
    (sort tasklist (lambda (f s)
                     (string-lessp (car f) (car s))))))

(defun format-decoded-time (date)
  (format "%d-%02d-%02d" (nth 5 date) (nth 4 date) (nth 3 date)))

(defun checkpoint-table (&optional scope checkpoint-tag)
  (unless checkpoint-tag
    (setq checkpoint-tag "checkpoint"))
  (let ((tasklist ()))
    (org-map-entries
     (lambda ()
       (let* ((date-scheduled (org-get-scheduled-time nil))
              (date-deadline (org-get-deadline-time nil))
              (date (if (or date-scheduled date-deadline)
                        (if date-scheduled
                            date-scheduled
                            date-deadline)))
              (tags (org-get-tags-at)))
         (if date
             (let ((highlight (if (member checkpoint-tag tags) "*" "")))
               (add-to-list 'tasklist
                            (list date
                                  (concat highlight "[["
                                          (nth 4 (org-heading-components))
                                          "]]" highlight))
                            t)))))
     nil scope)
    (mapcar (lambda (l) (list (format-decoded-time (decode-time (first l)))
                              (second l)))
            (sort tasklist (lambda (f s)
                             (time-less-p (car f) (car s)))))))

(defun related-entries (&optional with-langs with-tags)
  "Use en\\|es to match several languages in langs"
  (let* ((entries ())
o         (heading (nth 4 (org-heading-components)))
         (match-tags (if with-tags
                         with-tags
                       (org-get-tags-at (point) t)))
         (origin-props (org-entry-properties nil 'standard))
         (match-lang (if with-langs
                         with-langs
                       (cdr (or (assoc "lang" origin-props)
                                (assoc "LANG" origin-props))))))
    (org-map-entries
     (lambda ()
       (let* ((tags (org-get-tags-at (point) t))
              (current-heading (nth 4 (org-heading-components)))
              (props (org-entry-properties nil 'standard))
              (lang (cdr (or (assoc "lang" props)
                             (assoc "LANG" props))))
              (blurb (cdr (or (assoc "blurb" props)
                              (assoc "BLURB" props))))
              (fname (if (boundp 'ftname) ;; during export
                         (file-relative-name (buffer-file-name)
                                             (file-name-directory ftname))
                       (buffer-file-name))))
         (if (and (not (string= current-heading heading))
                  (or (not match-lang)
                      (not lang)
                      (string-match match-lang lang))
                  (intersection tags match-tags :test 'equal))
             (let ((art-name (nth 4 (org-heading-components))))
               (add-to-list 'entries
                            (list (concat "[[file:" fname "::" art-name
                                          "][" art-name "]]"
                                          (if blurb
                                              (concat " --- " blurb)
                                            "")))
                            t)))))
     nil
     (org-publish-get-base-files (if (boundp 'project) ;; during export
                                     project
                                   (org-publish-get-project-from-filename
                                    (buffer-file-name)))))
    entries))

;;; reftex

;;; Put together with
;;; https://tincman.wordpress.com/2011/01/04/research-paper-management-with-emacs-org-mode-and-reftex/
;;;
;;; and
;;;
;;; http://www-public.it-sudparis.eu/~berger_o/weblog/2012/03/23/how-to-manage-and-export-bibliographic-notesrefs-in-org-mode/

(setq reftex-default-bibliography '("~/cjr/ref/ref.bib"))

(setq org-link-abbrev-alist
      '(("bib" . "rtcite:~/cjr/ref/ref.bib::%s")
        ("ref" . "rtcite:~/cjr/ref/ref.org::#%s")
        ("paper" . "file:~/Documents/Dropbox/master/papers/%s.pdf")
        ("google" . "http://www.google.com/search?q=")))

(defun org-mode-reftex-search ()
  ;;jump to the notes for the paper pointed to at from reftex search
  (interactive)
  (org-open-link-from-string
   (format "[[ref:%s]]" (first (reftex-citation t)))))

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name) (file-exists-p (buffer-file-name))
       (progn
         ;;enable auto-revert-mode to update reftex when bibtex file changes on disk
         (global-auto-revert-mode t)
         (reftex-parse-all)
         ;;add a custom reftex cite format to insert links
         (reftex-set-cite-format
          '((?b . "[[bib:%l][%t (bib)]]")
            (?r . "[[ref:%l][%t]]")
            (?p . "[[paper:%l][%t (paper)]]")
            (?t . "%t")
            (?h . "*** %t (%a)\n:PROPERTIES:\n:Custom_ID: %l\n:END:\n[[paper:%l][Open paper]].\n\n")))))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))

(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(defun my-rtcite-export-handler (path desc format)
  (message "my-rtcite-export-handler is called : path = %s, desc = %s, format = %s"
           path desc format)
  (let* ((search (when (string-match "::#?\\(.+\\)\\'" path)
                   (match-string 1 path)))
         (path (substring path 0 (match-beginning 0))))
    (cond ((eq format 'latex)
           (if (or (not desc)
                   (equal 0 (search "rtcite:" desc)))
               (format "\\cite{%s}" search)
             ;;(format "\\cite[%s]{%s}" desc search)
             (format "\\cite{%s}" search))))))

(org-add-link-type "rtcite"
                   'org-bibtex-open
                   'my-rtcite-export-handler)

(setq org-export-default-language "en"
      ;; We don't want to evaluate when we export, make evaluation explicit
      org-export-babel-evaluate t)

;; Lowercase easy templates
;; http://orgmode.org/manual/Literal-examples.html
(setq org-structure-template-alist
      '(("s" "#+begin_src ?\n\n#+end_src" "<src lang=\"?\">\n\n</src>")
        ("p" "#+begin_src python\n  ?\n#+end_src" "<src lang=\"?\">\n\n</src>")
        ("P" "#+begin_src python :exports both :results output -r -n\n  ?\n#+end_src" "<src lang=\"?\">\n\n</src>")
        ("e" "#+begin_example\n?\n#+end_example" "<example>\n?\n</example>")
        ("q" "#+begin_quote\n?\n#+end_quote" "<quote>\n?\n</quote>")
        ("v" "#+begin_verse\n?\n#+end_verse" "<verse>\n?\n</verse>")
        ("V" "#+begin_verbatim\n?\n#+end_verbatim" "<verbatim>\n?\n</verbatim>")
        ("c" "#+begin_center\n?\n#+end_center" "<center>\n?\n</center>")
        ("l" "#+begin_LaTeX\n?\n#+end_LaTeX" "<literal style=\"latex\">\n?\n</literal>")
        ("L" "#+LaTeX: " "<literal style=\"latex\">?</literal>")
        ("h" "#+begin_html\n?\n#+end_html" "<literal style=\"html\">\n?\n</literal>")
        ("H" "#+html: " "<literal style=\"html\">?</literal>")
        ("a" "#+begin_ascii\n?\n#+end_ascii")
        ("A" "#+ascii: ")
        ("i" "#+index: ?" "#+index: ?")
        ("I" "#+include: %file ?" "<include file=%file markup=\"?\">")))

(setq org-latex-minted-options
      '(("frame" "single")
        ("linenos" "true")
        ("numberblanklines" "true")
        ("framesep" "10pt")))

; Setting up org-agenda-files
(setq org-agenda-files '("~/Dropbox/inbox.org"
                         "~/Dropbox/projects/projects.org"
                         "~/Dropbox/habits.org"
                         "~/Dropbox/resources/resources.org"))

;;; Refile targets are org-agenda-files, adding the outline path
;;; to refile to top-level

(setq org-refile-targets '(("~/Dropbox/diary.org" :maxlevel . 2)
                           ("~/Dropbox/projects/projects.org" :maxlevel . 3)
                           ("~/Dropbox/resources/someday.org" :maxlevel . 3)))
      
(setq org-refile-use-outline-path 'file)
(setq org-reverse-note-order t)


(require 'cl)

(defvar org-blank-lines-after-heading 2
  "Number of blank lines to separate a heading from the content.")

(defvar org-blank-lines-after-content (cons 2 4)
  "Cons cell for the number of blank lines after content in a heading.
The car is for when the next heading is at the same level, and
the cdr is for when the next heading is at a different level.
This is for the body specific to the headline, not counting
subheadings.")

(defun org-format-heading-blank-lines ()
  "Make sure each headline has exactly
`org-blank-lines-after-heading' after the heading, and
`org-blank-lines-after-content' blank lines at the end of its
content. Only works when point is in a headline."
  (interactive)
  (when (org-at-heading-p)
    (let ((current-level (nth 0 (org-heading-components)))
      next-level)
      (save-excursion
    (org-end-of-meta-data)
    ;; chomp blank lines then add what you want back.
    (while (and (not (eobp)) (looking-at "^[[:space:]]*$"))
      (kill-line))
    (insert (cl-loop for i from 0 below org-blank-lines-after-heading concat "\n")))

      ;; Now go to the end of content and insert lines if needed.
      (save-excursion
    (when (outline-next-heading)
      (setq next-level (nth 0 (org-heading-components)))
      ;; chomp lines back then reinsert them.
      (previous-line)
      (while (looking-at "^[[:space:]]*$")
        (kill-line)
        (previous-line))
      (unless (eobp) (end-of-line))
      (insert (cl-loop for i from 0 below (if (= current-level next-level)
                          (car org-blank-lines-after-content)
                        (cdr org-blank-lines-after-content))
               concat "\n")))))))

(defun org-format-headings (arg)
  (interactive "P")
  (save-excursion
    (org-save-outline-visibility t
      (org-cycle '(64))
      (message nil)
      (goto-char (point-min))
      (while (re-search-forward org-heading-regexp nil t)
    (org-format-heading-blank-lines)))))



(set-face-attribute 'org-agenda-structure nil :foreground "DodgerBlue" :height 1.1)


(setq org-agenda-window-setup 'reorganize-frame)


(defface org-agenda-dimmed-todo-face
  '((((background light)) (:foreground "red"))
    (((background dark)) (:foreground "red")))
  "Face used to dim blocked tasks in the agenda."
  :group 'org-faces)
