;;; normal-form-fontify.el --- a part of the simple Normal-Form mode

(defgroup normal-form-faces nil "faces used for Normal Form mode"  :group 'faces)

(defvar in-xemacs-p "" nil)

;;; GNU requires that the face vars be defined and point to themselves

(defvar normal-form-main-keyword-face 'normal-form-main-keyword-face
  "Face to use for Normal Form relations.")
(defface normal-form-main-keyword-face
  '((((class color)) (:foreground "red" :bold t)))
  "Font Lock mode face used to highlight class refs."
  :group 'normal-form-faces)

(defvar normal-form-function-nri-and-class-face 'normal-form-function-nri-and-class-face
  "Face to use for Normal Form keywords.")
(defface normal-form-function-nri-and-class-face
    (if in-xemacs-p 
	'((((class color)) (:foreground "red"))
	  (t (:foreground "gray" :bold t)))
      ;; in GNU, no bold, so just use color
      '((((class color))(:foreground "red"))))
  "Font Lock mode face used to highlight property names."
  :group 'normal-form-faces)

(defvar normal-form-normal-face 'normal-form-normal-face "regular face")
(defface normal-form-normal-face
 '((t (:foreground "grey")))
 "Font Lock mode face used to highlight property names."
 :group 'normal-form-faces)

(defvar normal-form-string-face 'normal-form-string-face "string face")
(defface normal-form-string-face
    '((t (:foreground "green4")))
  "Font Lock mode face used to highlight strings."
  :group 'normal-form-faces)

;; (defvar normal-form-logical-operator-face 'normal-form-logical-operator-face
;;   "Face to use for Normal Form logical operators (and, or, not, exists, forall, =>, <=>)")
;; ;; same as function name face
;; (defface normal-form-logical-operator-face
;;  '((((class color)) (:foreground "blue")))
;;   "Font Lock mode face used to highlight class names in class definitions."
;;   :group 'normal-form-faces)

(defvar normal-form-completed-face 'normal-form-completed-face
  "Face to use for completed items")
;; same as function name face
(defface normal-form-completed-face
 '((((class color)) (:foreground "blue")))
  "Font Lock mode face used to highlight class names in class definitions."
  :group 'normal-form-faces)

(defvar normal-form-deleted-face 'normal-form-deleted-face
  "Face to use for deleted items")
;; same as function name face
(defface normal-form-deleted-face
 '((((class color)) (:foreground "brown")))
  "Font Lock mode face used to highlight class names in class definitions."
  :group 'normal-form-faces)

(defvar normal-form-in-progress-face 'normal-form-in-progress-face
  "Face to use for in progress items")
;; same as function name face
(defface normal-form-in-progress-face
 '((((class color)) (:foreground "green")))
  "Font Lock mode face used to highlight class names in class definitions."
  :group 'normal-form-faces)

(defvar normal-form-when-face 'normal-form-when-face
  "Face to use for in progress items")
;; same as function name face
(defface normal-form-when-face
 '((((class color)) (:foreground "red")))
  "Font Lock mode face used to highlight class names in class definitions."
  :group 'normal-form-faces)

(defvar normal-form-priority-modal-face 'normal-form-priority-modal-face
  "Face to use for in progress items")
;; same as function name face
(defface normal-form-priority-modal-face
 '((((class color)) (:foreground "orange")))
  "Font Lock mode face used to highlight class names in class definitions."
  :group 'normal-form-faces)

(defvar normal-form-mistake-face 'normal-form-mistake-face
  "Face to use for in progress items")
;; same as function name face
(defface normal-form-mistake-face
 '((((class color)) (:foreground "red")))
  "Font Lock mode face used to highlight class names in class definitions."
  :group 'normal-form-faces)

(defvar normal-form-request-permission-face 'normal-form-request-permission-face
  "Face to use for Normal Form relations.")
(defface normal-form-request-permission-face
  '((((class color)) (:foreground "black" :bold t)))
  "Font Lock mode face used to highlight class refs."
  :group 'normal-form-faces)

(defvar normal-form-relation-face 'normal-form-relation-face
  "Face to use for Normal Form relations.")
(defface normal-form-relation-face
  '((((class color)) (:foreground "darkgrey")))
  "Font Lock mode face used to highlight class refs."
  :group 'normal-form-faces)

;; (defvar normal-form-property-face 'normal-form-property-face
;;   "Face to use for Normal Form property names in property definitions.")
;; (defface normal-form-property-face
;;   (if in-xemacs-p  
;;      '((((class color)) (:foreground "darkviolet" :bold t))
;;        (t (:italic t)))
;;     ;; in gnu, just magenta
;;     '((((class color)) (:foreground "darkviolet"))))
;;      "Font Lock mode face used to highlight property names."
;;      :group 'normal-form-faces)

(defvar normal-form-variable-face 'normal-form-variable-face
  "Face to use for Normal Form property name references.")
(defface normal-form-variable-face
  '((((class color)) (:foreground "darkviolet" ))
    (t (:italic t)))
  "Font Lock mode face used to highlight property refs."
  :group 'normal-form-faces)

(defvar normal-form-comment-face 'normal-form-comment-face
  "Face to use for Normal Form comments.")
(defface normal-form-comment-face
  '((((class color) ) (:foreground "red" :italic t))
    (t (:foreground "DimGray" :italic t)))
  "Font Lock mode face used to highlight comments."
  :group 'normal-form-faces)

(defvar normal-form-other-face 'normal-form-other-face
  "Face to use for other keywords.")
(defface normal-form-other-face
  '((((class color)) (:foreground "peru")))
  "Font Lock mode face used to highlight other Normal Form keyword."
  :group 'normal-form-faces)

;; (defvar normal-form-tag-face 'normal-form-tag-face
;;   "Face to use for tags.")
;; (defface normal-form-tag-face
;;     '((((class color)) (:foreground "violetred" ))
;;       (t (:foreground "black")))
;;   "Font Lock mode face used to highlight other untyped tags."
;;   :group 'normal-form-faces)

;; (defvar normal-form-substitution-face 'normal-form-substitution-face "face to use for substitution strings")
;; (defface normal-form-substitution-face
;;     '((((class color)) (:foreground "orangered"))
;;       (t (:foreground "lightgrey")))
;;   "Face to use for Normal Form substitutions"
;;   :group 'normal-form-faces)


;;;================================================================
;;; these are the regexp matches for highlighting Normal Form 

(defvar normal-form-font-lock-prefix "\\b")
(defvar normal-form-font-lock-keywords
  (let ()
    (list 

     ;; (list
     ;;  "^[^;]*\\(;.*\\)$" '(1 normal-form-comment-face nil))

     (list 
      (concat "(\\(completed\\|solution\\)\\b"
	      )
      '(1 normal-form-completed-face nil)
      )

     (list 
      (concat "(\\(deleted\\)\\b"
	      )
      '(1 normal-form-deleted-face nil)
      )
     
     (list 
      (concat "(\\(in progress\\|partially completed\\)\\b"
	      )
      '(1 normal-form-in-progress-face nil)
      )

     (list 
      (concat "(\\(when\\)\\b"
	      )
      '(1 normal-form-when-face nil)
      )

     (list 
      (concat "(\\(critical\\|very important\\|important\\|neutral\\|unimportant\\|wishlist\\)\\b"
	      )
      '(1 normal-form-priority-modal-face nil)
      )

     (list 
      (concat "(\\(mistake\\)\\b"
	      )
      '(1 normal-form-mistake-face nil)
      )

     ;; (list 
     ;;  (concat normal-form-font-lock-prefix "\\(" (join "\\|"
     ;; 	      normal-form-mode-main-relation ) "\\)\\b" ) '(1
     ;; 	      normal-form-main-relation-face nil) )

     ;; (list
     ;;  (concat normal-form-font-lock-prefix "\\(" 
     ;;   (join "\\|"
     ;; 	normal-form-mode-functions-non-relational-instances-and-classes) "\\)\\b")
     ;;  '(1 normal-form-function-nri-and-class-face nil))

     ;; (list 
     ;;  (concat
     ;;   normal-form-font-lock-prefix "\\([_a-zA-Z0-9-]+Fn\\)\\b" )
     ;;   '(1 normal-form-function-nri-and-class-face nil) )

     ;; (list 
     ;;  (concat "\\(\\?[_A-Z0-9-]+\\)\\b"
     ;; 	      )
     ;;  '(1 normal-form-variable-face nil)
     ;;  )

     ;; (list 
     ;;  (concat "\\(\\&\\%[_A-Za-z0-9-]+\\)\\b"
     ;; 	      )
     ;;  '(1 normal-form-other-face nil)
     ;;  )

     ;; (list 
     ;;  (concat normal-form-font-lock-prefix "\\(" (join "\\|"
     ;; 	      normal-form-mode-relations) "\\)\\b" ) '(1
     ;; 	      normal-form-relation-face nil) )

     ;; (list 
     ;;  ;; (concat "^\s*[^;][^\n\r]*[\s\n\r(]\\(=>\\|<=>\\)"
     ;;  (concat "\\(=>\\|<=>\\)")
     ;;  '(1 normal-form-logical-operator-face nil)
     ;;  )

     ;; (list 
     ;;  (concat normal-form-font-lock-prefix "\\(" (join "\\|"
     ;; 	      normal-form-mode-main-keyword ) "\\)\\b" ) '(1
     ;; 	      normal-form-main-keyword-face nil) )
     
     ;; black for the def parts of PROPERTY DEFINITION
     ;; and of TransitiveProperty UnambiguousProperty UniqueProperty
;;; END OF LIST ELTS
     ))

    "Additional expressions to highlight in Normal Form mode.")

(put 'normal-form-mode 'font-lock-defaults '(normal-form-font-lock-keywords nil nil))

(defun re-font-lock () (interactive) (font-lock-mode 0) (font-lock-mode 1))

(provide 'normal-form-fontify)
