(define (problem libros)
	
  (:domain libros)

  (:objects
    m1 m2 m3 m4 m5 m6 m6 m7 m8 m9 m10 m11 m12 - Mes
	harryPotter1 harryPotter2 harryPotter3 harryPotter4 seniorAnillos1 seniorAnillos2 seniorAnillos3 starWars1 starWars2 elHobbit pepe pepito - Libro
  )

  (:init
	(paralelo seniorAnillos1 elHobbit)
	(paralelo pepito harryPotter2)
    (predecesor harryPotter1 harryPotter2)
	(predecesor harryPotter2 harryPotter3)
	(predecesor harryPotter3 harryPotter4)
	(predecesor seniorAnillos1 seniorAnillos2)
	(predecesor seniorAnillos2 seniorAnillos3)
	(predecesor starWars1 starWars2)
	(libro_leido starWars1)
	(libro_leido seniorAnillos1)
	(libro_leido harryPotter1)
	(libro_a_leer harryPotter4)
	(libro_a_leer seniorAnillos2)
	(libro_a_leer seniorAnillos3)
	(libro_a_leer starWars2)
	(libro_a_leer elHobbit)
	(libro_a_leer pepe)
	(libro_a_leer pepito)
	(anterior m1 m2) 
	(anterior m2 m3) 
	(anterior m3 m4) 
	(anterior m4 m5) 
	(anterior m5 m6) 
	(anterior m6 m7) 
	(anterior m7 m8) 
	(anterior m8 m9) 
	(anterior m9 m10) 
	(anterior m10 m11) 
	(anterior m11 m12)
  ) 

  (:goal 
	(forall (?l - Libro) 
		(imply (libro_a_leer ?l) 
			(and
				(libro_asignado ?l)
				(forall (?pred - Libro)
					(or 
						(libro_leido ?pred)
						(and 
							(imply (predecesor ?pred ?l) (libro_asignado ?pred))
							(imply (paralelo ?pred ?l) (libro_asignado ?pred))
						)
					)
				)
			)
		)
	)
  )
)