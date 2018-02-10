(define-derived-mode normal-form-mode
 emacs-lisp-mode "Normal-Form"
 "Major mode for interacting with .nf files.
\\{normal-form-mode-map}"
 (define-key normal-form-mode-map "\C-cdvvvv" 'normal-form-mode)

 (make-local-variable 'font-lock-defaults)
 (setq font-lock-defaults '(do-todo-list-font-lock-keywords nil nil))
 (re-font-lock))

;; (global-set-key "\C-cdtc" 'do-todo-list-sexp-completed)
;; (global-set-key "\C-cdte" 'do-todo-list-sexp-deleted)
;; (global-set-key "\C-cdte" 'do-todo-list-sexp-deleted)
;; (global-set-key "\C-cdts" 'do-todo-list-sexp-solution)
;; (global-set-key "\C-cdtp" 'do-todo-list-sexp-in-progress)
;; (global-set-key "\C-cdtP" 'do-todo-list-sexp-postponed)
;; (global-set-key "\C-cdtk" 'do-todo-list-sexp-skipped)

;; functions

;; request-permission-to
;; - have it run action checks etc, interface with planning

;; record-action

;; record-mistake

(global-set-key "\C-cdtt" 'normal-form-new-task)
(global-set-key "\C-cdtm" 'normal-form-new-mistake)

;; (global-set-key "\C-cdtc" 'do-todo-list-sexp-completed)
;; (global-set-key "\C-cdte" 'do-todo-list-sexp-deleted)
;; (global-set-key "\C-cdts" 'do-todo-list-sexp-solution)
;; (global-set-key "\C-cdtp" 'do-todo-list-sexp-in-progress)
;; (global-set-key "\C-cdtP" 'do-todo-list-sexp-postponed)
;; (global-set-key "\C-cdtk" 'do-todo-list-sexp-skipped)

(global-set-key "\C-cdp5" 'normal-form-sexp-priority-critical)
(global-set-key "\C-cdp4" 'normal-form-sexp-priority-very-important)
(global-set-key "\C-cdp3" 'normal-form-sexp-priority-important)
(global-set-key "\C-cdp2" 'normal-form-sexp-priority-neutral)
(global-set-key "\C-cdp1" 'normal-form-sexp-priority-unimportant)
(global-set-key "\C-cdpw" 'normal-form-sexp-priority-wishlist)

(global-set-key "\C-cdrg" 'normal-form-sexp-permission-granted)
(global-set-key "\C-cdrd" 'normal-form-sexp-permission-denied)

(defun normal-form-sexp-record-action ()
 ""
 (interactive)
 (do-todo-list-assert-about-sexp "mistake"))

(defun normal-form-sexp-request-permission ()
 ""
 (interactive)
 (do-todo-list-assert-about-sexp "request permission"))

(defun normal-form-sexp-permission-granted ()
 ""
 (interactive)
 (do-todo-list-assert-about-sexp "granted"))

(defun normal-form-sexp-permission-denied ()
 ""
 (interactive)
 (do-todo-list-assert-about-sexp "denied"))

(defun normal-form-sexp-priority-critical ()
 ""
 (interactive)
 (do-todo-list-assert-about-sexp "critical"))

(defun normal-form-sexp-priority-very-important ()
 ""
 (interactive)
 (do-todo-list-assert-about-sexp "very important"))

(defun normal-form-sexp-priority-important ()
 ""
 (interactive)
 (do-todo-list-assert-about-sexp "important"))

(defun normal-form-sexp-priority-neutral ()
 ""
 (interactive)
 (do-todo-list-assert-about-sexp "neutral"))

(defun normal-form-sexp-priority-unimportant ()
 ""
 (interactive)
 (do-todo-list-assert-about-sexp "unimportant"))

(defun normal-form-sexp-priority-wishlist ()
 ""
 (interactive)
 (do-todo-list-assert-about-sexp "wishlist"))

(defun normal-form-new-task ()
 ""
 (interactive)
 (indent-for-tab-command)
 (insert-parentheses)
 (insert "task")
 (insert-parentheses)
 (backward-up-list)
 (forward-sexp)
 (insert-parentheses)
 (insert "reward:")
 (backward-up-list)
 (forward-sexp)
 (insert-parentheses)
 (insert "penalty:")
 (backward-up-list)
 (backward-sexp)
 (backward-sexp)
 (down-list))

(defun normal-form-new-mistake ()
 ""
 (interactive)
 (indent-for-tab-command)
 (insert-parentheses)
 (insert "mistake")
 (insert-parentheses)
 (backward-up-list)
 (forward-sexp)
 (insert-parentheses)
 (insert "reason:")
 (backward-up-list)
 (backward-sexp)
 (backward-sexp)
 (down-list))
