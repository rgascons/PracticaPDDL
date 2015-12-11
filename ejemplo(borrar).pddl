(define (domain vector)
(:requirements :strips)
(:predicates (val ?x ?vx)
				(next ?x ?y))

(:action swap
	:parameters (?x ?y ?vx ?vy)
	:precondition (and (val ?x ?vx) (val ?y ?vy) (next ?x ?y))
	:effect (and (val ?y ?vx) (val ?x ?vy) (not (val ?x ?vy)) (not (val ?y ?vy)))
))

(define (problem vector)
	
  (:domain vector)

  (:objects
    p1 p2 p3 a b c
  )

  (:init
    (next p1 p2)
    (next p2 p3)
    (val p1 a)
    (val p2 b)
    (val p3 c)
  ) 

  (:goal
  	(val p1 c)
  	(val p2 b)
  	(val p3 a)
  ))