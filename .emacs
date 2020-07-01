(tool-bar-mode -1)
(column-number-mode 1)

;;; Navigate windows with M-` and M-~
(defun select-next-window ()
  "Switch to the next window"
  (interactive)
  (select-window (next-window)))
(defun select-previous-window ()
  "Switch to the previous window"
  (interactive)
  (select-window (previous-window)))
(global-set-key (kbd "M-`") 'select-next-window)
(global-set-key (kbd "M-~")  'select-previous-window)

;;; Use clipboard
(setq x-select-enable-clipboard t)

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)

;;; Hidden backup files
(defun make-backup-file-name (filename)
  (defvar backups-dir "./.emacs-bu/")
  (make-directory backups-dir t)
  (expand-file-name (concat backups-dir (file-name-nondirectory filename) "~")
            (file-name-directory filename)))

(global-set-key (kbd "C-x C-b") 'ibuffer)

;;; Helper functions
(defun wc (&optional start end)
  "Prints number of lines, words and characters in region or whole buffer."
  (interactive)
  (let ((n 0)
        (start (if mark-active (region-beginning) (point-min)))
        (end (if mark-active (region-end) (point-max))))
    (save-excursion
      (goto-char start)
      (while (< (point) end) (if (forward-word 1) (setq n (1+ n)))))
    (message "%3d %3d %3d" (count-lines start end) n (- end start))))

(defun load-if-there (conf-file)
  (if (file-exists-p conf-file)
      (load-file conf-file)))

;;; Programming modes

(defconst my-c-style
  '((c-tab-always-indent        . t)
    (c-comment-only-line-offset . 4)
    (c-hanging-braces-alist     . ((substatement-open after)
                                   (brace-list-open)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
                                   empty-defun-braces
                                   defun-close-semi))
    (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                   (substatement-open . 0)
                                   (inline-open . 0)
                                   (comment-intro . 0)
                                   (case-label        . 4)
                                   (block-open        . 0)
                                   (knr-argdecl-intro . -)))
    (c-echo-syntactic-information-p . t))
  "Reasonable C style")

(add-hook 'c-mode-common-hook
      (lambda ()
        (c-add-style "PERSONAL" my-c-style t)
        ;; offset customizations not in my-c-style
        (c-set-offset 'member-init-intro '++)
        ;; we like auto-newline and hungry-delete
        (c-toggle-auto-hungry-state 1)
        ;; keybindings for all supported languages.  We can put
        ;; these in c-mode-base-map because c-mode-map,
        ;; c++-mode-map, objc-mode-map, java-mode-map, and
        ;; idl-mode-map inherit from it.
        (define-key c-mode-base-map "\C-m" 'newline-and-indent)))

(defun no-tabs-hook ()
  (setq tab-width 4)
  (setq indent-tabs-mode nil))

(add-hook 'c-mode-common-hook 'no-tabs-hook)
(add-hook 'emacs-lisp-mode-hook 'no-tabs-hook)
(add-hook 'apache-mode-hook 'no-tabs-hook)
(add-hook 'javascript-mode-hook 'no-tabs-hook)
(add-hook 'tex-mode-hook 'no-tabs-hook)
(add-hook 'text-mode-hook
	  (lambda ()
	    ;;(flyspell-mode 1)
	    (setq fill-column 65)))
(add-hook 'text-mode-hook 'no-tabs-hook)
(add-hook 'makefile-mode-hook
	  (setq tab-width 4))
(add-hook 'perl-mode-hook 'no-tabs-hook)
(add-hook 'python-mode-hook 'no-tabs-hook)
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))
(add-hook 'python-mode-hook
      (lambda ()
        (define-key python-mode-map "\C-m" 'newline-and-indent)
        (define-key python-mode-map "\"" 'electric-pair)
        (define-key python-mode-map "\'" 'electric-pair)
        (define-key python-mode-map "(" 'electric-pair)
        (define-key python-mode-map "[" 'electric-pair)
        (define-key python-mode-map "{" 'electric-pair)
        (setq py-split-windows-on-execute-p nil
              py-switch-buffers-on-execute-p t)
        (when (load "flymake" t)
          (defun flymake-pylint-init ()
            (let* ((temp-file (flymake-init-create-temp-buffer-copy
                               'flymake-create-temp-inplace))
                   (local-file (file-relative-name
                                temp-file
                                (file-name-directory buffer-file-name))))
              (list "pep8" (list "--repeat" "--ignore=E225" local-file))))
          (add-to-list 'flymake-allowed-file-name-masks
                       '("\\.py\\'" flymake-pylint-init)))))

;;; System
(setq exec-path (append (list "~/bin" "/usr/local/git/bin"
                              "/usr/local/bin"
                              "/usr/texbin"
                              "/usr/local/share/python"
                              "/Library/TeX/texbin/"
                              "/Library/Frameworks/Python.framework/Versions/2.7/bin")
                         exec-path))

;;; solarized doesn't work with el-get
(add-to-list 'load-path "/Users/joanreyero/.emacs.d/lisp")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(add-to-list 'load-path "~/.emacs.d/vendor/arduino")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

(setq-default indent-tabs-mode nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (whiteboard)))
 '(custom-safe-themes
   (quote
    ("843a82ff3b91bec5430f9acdd11de03fc0f7874b15c1b6fbb965116b4c7bf830" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(initial-buffer-choice "~/Dropbox/joanreyero/joanreyero.org")
 '(menu-bar-mode nil)
 '(org-agenda-window-setup (quote reorganize-frame))
 '(org-blank-before-new-entry (quote ((heading . auto) (plain-list-item . auto))))
 '(org-default-notes-file "~/joanreyero/inbox.org")
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-eww org-gnus org-id org-info org-irc org-mhe org-rmail org-w3m org-secretary)))
 '(org-special-ctrl-a/e (quote reversed))
 '(org-structure-template-alist
   (quote
    (("s" "#+begin_src ?

#+end_src" "<src lang=\"?\">

</src>")
     ("p" "#+begin_src python
  ?
#+end_src" "<src lang=\"?\">

</src>")
     ("P" "#+begin_src python :exports both :results output -r -n
  ?
#+end_src" "<src lang=\"?\">

</src>")
     ("e" "#+begin_example
?
#+end_example" "<example>
?
</example>")
     ("q" "#+begin_quote
?
#+end_quote" "<quote>
?
</quote>")
     ("v" "#+begin_verse
?
#+end_verse" "<verse>
?
</verse>")
     ("V" "#+begin_verbatim
?
#+end_verbatim" "<verbatim>
?
</verbatim>")
     ("c" "#+begin_center
?
#+end_center" "<center>
?
</center>")
     ("l" "#+begin_LaTeX
?
#+end_LaTeX" "<literal style=\"latex\">
?
</literal>")
     ("L" "#+LaTeX: " "<literal style=\"latex\">?</literal>")
     ("h" "#+begin_html
?
#+end_html" "<literal style=\"html\">
?
</literal>")
     ("H" "#+html: " "<literal style=\"html\">?</literal>")
     ("a" "#+begin_ascii
?
#+end_ascii")
     ("A" "#+ascii: ")
     ("i" "#+index: ?" "#+index: ?")
     ("I" "#+include: %file ?" "<include file=%file markup=\"?\">"))))
 '(org-tags-column -80)
 '(package-selected-packages
   (quote
    (org-protocol-jekyll ein workgroups2 org-super-agenda ## web-mode haskell-mode)))
 '(show-paren-mode t)
 '(split-height-threshold 200)
 '(truncate-lines t)
 '(wg-buffer-auto-association (quote weak))
 '(wg-load-last-workgroup t)
 '(wg-open-this-wg t)
 '(wg-session-load-on-start t))


(load "~/.emacs.d/.org.el")




(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(load-theme 'joanreyero t)


(require 'workgroups2)
;; Change some settings
(wg-find-session-file "~/.emacs_files/workgroups")
;(setq wg-session-load-on-start t)    ; default: (not (daemonp)
(setq wg-prefix-key (kbd "C-z"))
(workgroups-mode 1)        ; put this one at the bottom of .emacs



(setq-default line-spacing 5)

(setq todoist-token "aa30572bf2b58a48ceb83aa6345c09ed564de9a9")

(add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))

;; packages
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )

(require 'org-protocol)
(server-start)


(global-visual-line-mode t)
