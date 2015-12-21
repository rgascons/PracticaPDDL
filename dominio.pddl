(define (domain libros)
	(:requirements :strips :adl :typing)
	
	(:types
		Libro Mes - Object
	)
	
	(:predicates
		(predecesor ?x - Libro ?y - Libro) ;?x es predecesor de ?y
		(anterior ?m - Mes ?n - Mes); ?m es anterior a ?n
		;(mes_libre ?m - Mes)
		(libro_asignado ?l - Libro)
		(libro_leido ?l - Libro)
		(libro_a_leer ?l - Libro)
		(asignado_en ?l - Libro ?m - Mes)
		;(paralelo ?par - Libro ?libro - Libro)
	)

	(:action asignar
		:parameters (?libro - Libro ?mes - Mes)
		:precondition (and
				(not (libro_asignado ?libro))
				(not (libro_leido ?libro))
				(forall (?pred - Libro)
					;(and 
						(imply (predecesor ?pred ?libro) 
							(or (libro_leido ?pred) (exists (?ant - Mes) (and (anterior ?ant ?mes) (asignado_en ?pred ?ant))))
						)
						;(imply (paralelo ?pred ?libro) 
						;	(or (libro_leido ?pred) (asignado_en ?pred ?mes) (and (anterior ?ant ?mes) (asignado_en ?pred ?ant)))
						;)
					;)
				)
			 )
		:effect (and (asignado_en ?libro ?mes) (libro_asignado ?libro))
	)
)