(define (domain libros)
(:requirements :strips)
(:predicates (val ?x ?vx)
				(next ?x ?y))

(:action swap
	:parameters (?x ?y ?vx ?vy)
	:precondition (and (val ?x ?vx) (val ?y ?vy) (next ?x ?y))
	:effect (and (val ?y ?vx) (val ?x ?vy) (not (val ?x ?vy)) (not (val ?y ?vy)))
))