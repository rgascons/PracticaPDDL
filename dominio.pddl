(define (domain libros)
	(:requirements :strips :adl :typing)
	
	(:types
		Libro Mes - Object
	)
	
	(:predicates
		(predecesor ?x - Libro ?y - Libro) ;?x es predecesor de ?y
		(anterior ?m - Mes ?n - Mes)
		(mes_libre ?m - Mes)
		(mes_ocupado ?m - Mes)
		(libro_asignado ?l - Libro)
		(libro_leido ?l - Libro)
		(libro_a_leer ?l - Libro)
		(asignado_en ?l - Libro ?m - Mes)
	)

	(:action asignar
		:parameters (?libro - Libro ?mes - Mes)
		:precondition (and
			(not (libro_asignado ?libro))
			(libro_a_leer ?libro)
			(not (exists (?pred - Libro) (and (predecesor ?pred ?libro) 
										(or (asignado_en ?pred ?mes) (not (libro_asignado ?pred)))
										(not (libro_leido ?pred)))))
		)
		:effect (and (asignado_en ?libro ?mes) (libro_asignado ?libro))
	)
)