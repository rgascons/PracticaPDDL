(define (domain libros)
	(:requirements :strips :adl :typing :equality)
	
	(:types
		Libro Mes - Object
	)
	
	(:predicates
		(predecesor ?x - Libro ?y - Libro) ;?x es predecesor de ?y
		(anterior ?m - Mes ?n - Mes); ?m es anterior a ?n
		(libro_asignado ?l - Libro)
		(libro_leido ?l - Libro)
		(libro_a_leer ?l - Libro)
		(asignado_en ?l - Libro ?m - Mes)
		(paralelo ?par - Libro ?libro - Libro)
	)
	
	;(:action asignar_pred
	;	:parameters (?libro - Libro ?pred - Libro ?mes - Mes ?ant - Mes)
	;	:precondition 
	;	(and 
	;		(not (libro_asignado ?pred))
	;		(not (libro_leido ?pred))
	;		(predecesor ?pred ?libro)
	;		(or (anterior ?ant ?mes) (and (= ?mes m1) (= ?ant m1)))
	;	)
	;	:effect
	;	(and (asignado_en ?pred ?ant) (libro_asignado ?pred))
	;)
	
	;(:action asignar_par
	;	:parameters (?libro - Libro ?par - Libro ?mes - Mes ?antOig - Mes)
	;	:precondition 
	;	(and 
	;		(not (libro_asignado ?par))
	;		(not (libro_leido ?par))
	;		(paralelo ?par ?libro)
	;		(or (anterior ?antOig ?mes) (= ?mes ?antOig))
	;	)
	;	:effect
	;	(and (asignado_en ?par ?antOig) (libro_asignado ?par))
	;)


	(:action asignar
		:parameters (?libro - Libro ?mes - Mes)
		:precondition (and
				(not (libro_asignado ?libro))
				(not (libro_leido ?libro))
				;(or (anterior ?ant ?mes) (and (= ?mes m1) (= ?ant m1)))
				(forall (?pred - Libro)
					(or 
						(libro_leido ?pred)
						(and 
							(imply (predecesor ?pred ?libro) 
								(exists (?ant - Mes) (and (anterior ?ant ?mes) (asignado_en ?pred ?ant)))
							)
							(imply (paralelo ?pred ?libro)
								(or (libro_leido ?pred) (asignado_en ?pred ?mes))
							)
						)
					)
				)
			 )
		:effect (and (asignado_en ?libro ?mes) (libro_asignado ?libro))
	)
)