;;; .loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "auto-complete/auto-complete" "auto-complete/auto-complete.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from auto-complete/auto-complete.el

(autoload 'auto-complete "auto-complete/auto-complete" "\
Start auto-completion at current point.

\(fn &optional SOURCES)" t nil)

(autoload 'auto-complete-mode "auto-complete/auto-complete" "\
AutoComplete mode

\(fn &optional ARG)" t nil)

(defvar global-auto-complete-mode nil "\
Non-nil if Global Auto-Complete mode is enabled.
See the `global-auto-complete-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-auto-complete-mode'.")

(custom-autoload 'global-auto-complete-mode "auto-complete/auto-complete" nil)

(autoload 'global-auto-complete-mode "auto-complete/auto-complete" "\
Toggle Auto-Complete mode in all buffers.
With prefix ARG, enable Global Auto-Complete mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Auto-Complete mode is enabled in all buffers where
`auto-complete-mode-maybe' would do it.
See `auto-complete-mode' for more information on Auto-Complete mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "auto-complete/auto-complete" '("auto-complete-mode" "ac-")))

;;;***

;;;### (autoloads nil "auto-complete/auto-complete-config" "auto-complete/auto-complete-config.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from auto-complete/auto-complete-config.el

(autoload 'ac-config-default "auto-complete/auto-complete-config" "\


\(fn)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "auto-complete/auto-complete-config" '("ac-")))

;;;***

;;;### (autoloads nil "epc/epc" "epc/epc.el" (0 0 0 0))
;;; Generated autoloads from epc/epc.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "epc/epc" '("epc:")))

;;;***

;;;### (autoloads nil "epc/epcs" "epc/epcs.el" (0 0 0 0))
;;; Generated autoloads from epc/epcs.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "epc/epcs" '("epcs:")))

;;;***

;;;### (autoloads nil "epc/test-epc" "epc/test-epc.el" (0 0 0 0))
;;; Generated autoloads from epc/test-epc.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "epc/test-epc" '("epc:")))

;;;***

;;;### (autoloads nil "fuzzy/fuzzy" "fuzzy/fuzzy.el" (0 0 0 0))
;;; Generated autoloads from fuzzy/fuzzy.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "fuzzy/fuzzy" '("fuzzy-" "turn-o")))

;;;***

;;;### (autoloads nil "popup/popup" "popup/popup.el" (0 0 0 0))
;;; Generated autoloads from popup/popup.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "popup/popup" '("popup-")))

;;;***

;;;### (autoloads nil nil ("auto-complete/auto-complete-pkg.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; .loaddefs.el ends here
