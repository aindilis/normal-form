(pair
 (gdl
  (init (cell 1 1 b))

  (init (cell 3 3 b))
  (init (control xplayer))
  (<= terminal (line x))
  (<= terminal (line o))
  (<= terminal (not open))
  (<= (goal xplayer 100)
   (line x))

  (<= (goal xplayer 50)
   (not (line x))
   (not (line o))
   (not open))

  (<= (goal xplayer 0)
   (line o))
  )

 (gddl
  (:init
   (cell r1 c1 b)

   (cell r3 c3 b)
   (control xplayer))
  (:goal
   (or
    (line x) (line o)
    (not (open))))
  (:gain ?player - role 100
   (and
    (= ?player xplayer)
    (line x)))
  (:gain ?player - role 50
   (and
    (= ?player xplayer)
    (not (line x))
    (not (line o))
    (not (open))))
  (:gain ?player - role 0
   (and
    (= ?player xplayer)
    (line o)))
  )
 )

(pair
 (gdl
  (<= (row ?m ?x)
   (true (cell ?m 1 ?x))
   (true (cell ?m 2 ?x))
   (true (cell ?m 3 ?x)))

  (<= (diagonal ?x)
   (true (cell 1 1 ?x))
   (true (cell 2 2 ?x))
   (true (cell 3 3 ?x)))

  (<= (line ?x)
   (row ?m ?x))

  (<= (line ?x)
   (diagonal ?x))
  (<= open
   (true (cell ?m ?n b)))
  )

 (gddl
  (:derived (row ?m - row ?x - tok)
   (and (cell ?m c1 ?x)
    (cell ?m c2 ?x)
    (cell ?m c3 ?x)))

  (:derived (diagonal ?x - tok)
   (and (cell r1 c1 ?x)
    (cell r2 c2 ?x)
    (cell r3 c3 ?x)))

  (:derived (line ?x - tok)
   (exists (?m - row)
    (row ?m ?x)))

  (:derived (line ?x - tok)
   (diagonal ?x))

  (:derived (open)
   (exists (?m - row ?n - col)
    (cell ?m ?n b)))
  )
 )

;; Figure 2: Encoding game domain axioms of TicTacToe in
;; GDL (left) and GDDL (right).
(pair
 
 (gdl
  (<= (next (cell ?m ?n x))
   (does xplayer (mark ?m ?n))
   (true (cell ?m ?n b)))
  (<= (next (cell ?m ?n ?w))
   (true (cell ?m ?n ?w))
   (distinct ?w b))
  (<= (next (cell ?m ?n b))
   (does ?w (mark ?j ?k))
   (true (cell ?m ?n b))
   (or (distinct ?m ?j)
    (distinct ?n ?k)))
  (<= (next (control oplayer))
   (true (control xplayer)))
  (<= (legal ?w (mark ?x ?y))
   (true (cell ?x ?y b))
   (true (control ?w)))
  )

 (gddl
  (:action mark
   :parameters
   (?player - role
    ?x - row ?y - col
    ?t - tok ?nplayer - role)
   :precondition
   (and
    (cell ?x ?y b)
    (control ?player)
    (= ?player xplayer)
    (= ?t x)
    (= ?nplayer oplayer)
    :effect
    (and
     (not (cell ?x ?y b))
     (cell ?x ?y ?t)
     (not (control ?player))
     (control ?nplayer)))))
 )
