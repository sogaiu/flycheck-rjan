;;; flycheck-rjan.el --- Add rjan linter to flycheck

;; Author: sogaiu
;; Created: 18 May 2023
;; Version: 2023.05.18
;; Package-Requires: ((flycheck "0.18"))

;;; Commentary:

;; This package integrates rjan with Emacs via flycheck.  To use it:
;;
;; 1. Ensure rjan is installed (https://github.com/sogaiu/review-janet)
;;    and on your PATH.
;;
;; 2. Clone the repository for flycheck-rjan
;;
;; 3. Ensure `load-path' points at the cloned directory.
;;
;; 4. Add the following to your .emacs-equivalent (e.g. init.el):
;;
;;      (require 'flycheck-rjan)
;;
;; 5. You might also want the setting:
;;
;;      (global-flycheck-mode)
;;
;;    if you don't already have it.
;;
;; To use this checker along with flycheck-janet, consider placing the
;; following sort of setting in your init.el:
;;
;;   (flycheck-add-next-checker 'janet-rjan 'janet-janet)
;;
;; Assuming everything else is set up correctly, this will arrange for
;; things such that the janet-rjan checker (that's the one defined in
;; this file) runs after the janet-janet checker (that's the one in
;; flycheck-janet).

;;; Code:
(require 'flycheck)

(flycheck-define-checker janet-rjan
  "A checker for Janet code using rjan.

See URL `https://github.com/sogaiu/review-janet'."
  :command ("rjan" "-s")
  :standard-input t
  :error-patterns
  ((info line-start
         "info:"
         (one-or-more (not ":")) ":"
         line
         ":"
         column ": "
         (message)
         line-end)
   (warning line-start
            "warning:"
            (one-or-more (not ":")) ":"
            line
            ":"
            column ": "
            (message)
            line-end)
   (error line-start
          "error:"
          (one-or-more (not ":")) ":"
          line
          ":"
          column ": "
          (message)
          line-end))
  :modes (janet-mode janet-ts-mode)
  :predicate (lambda ()
               (memq major-mode '(janet-mode
                                  janet-ts-mode))))

(add-to-list 'flycheck-checkers 'janet-rjan)

(provide 'flycheck-rjan)
;;; flycheck-rjan.el ends here
