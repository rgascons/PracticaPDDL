(define (problem libros)
	
  (:domain libros)

  (:objects
    m1 m2 m3 m4 m5 m6 m6 m7 m8 m9 m10 m11 m12 - Mes
	harryPotter1 harryPotter2 harryPotter3 harryPotter4 seniorAnillos1 seniorAnillos2 seniorAnillos3 starWars1 starWars2 elHobbit pepe pepito fulano - Libro
  )

  (:init
	(paralelo HarryPotter4 pepito)
	(paralelo seniorAnillos3 elHobbit)
	(paralelo elHobbit fulano)
	(paralelo fulano harryPotter1)
    (predecesor harryPotter1 harryPotter2)
	(predecesor harryPotter2 harryPotter3)
	(predecesor harryPotter3 harryPotter4)
	(predecesor seniorAnillos1 seniorAnillos2)
	(predecesor seniorAnillos2 seniorAnillos3)
	(paralelo pepito pepe)
	(paralelo pepe starWars1)
	(predecesor starWars1 starWars2)
	;(libro_leido starWars1)
	;(libro_leido seniorAnillos1)
	;(libro_leido harryPotter1)
	;(libro_a_leer harryPotter4)
	;(libro_a_leer seniorAnillos2)
	;(libro_a_leer seniorAnillos3)
	(libro_a_leer starWars2)
	;(libro_a_leer elHobbit)
	;(libro_a_leer pepe)
	;(libro_a_leer pepito)
	(anterior m1 m2) (anterior m1 m3) (anterior m1 m4) (anterior m1 m5) (anterior m1 m6) (anterior m1 m7)
	(anterior m1 m8) (anterior m1 m9) (anterior m1 m10) (anterior m1 m11) (anterior m1 m12)
	(anterior m2 m3) (anterior m2 m4) (anterior m2 m5) (anterior m2 m6) (anterior m2 m7) (anterior m2 m8) 
	(anterior m2 m9) (anterior m2 m10) (anterior m2 m11) (anterior m2 m12) 
	(anterior m3 m4) (anterior m3 m5) (anterior m3 m6) (anterior m3 m7) (anterior m3 m8) (anterior m3 m9)
	(anterior m3 m10) (anterior m3 m11) (anterior m3 m12)
	(anterior m4 m5) (anterior m4 m6) (anterior m4 m7) (anterior m4 m8) (anterior m4 m9) (anterior m4 m10)
	(anterior m4 m11) (anterior m4 m12)
	(anterior m5 m6) (anterior m5 m7) (anterior m5 m8) (anterior m5 m9) (anterior m5 m10) (anterior m5 m11)
	(anterior m5 m12)
	(anterior m6 m7) (anterior m6 m8) (anterior m6 m9) (anterior m6 m10) (anterior m6 m11) (anterior m6 m12)
	(anterior m7 m8) (anterior m7 m9) (anterior m7 m10) (anterior m7 m11) (anterior m7 m12)
	(anterior m8 m9) (anterior m8 m10) (anterior m8 m11) (anterior m8 m12) 
	(anterior m9 m10) (anterior m9 m11) (anterior m9 m12)
	(anterior m10 m11) (anterior m10 m12)
	(anterior m11 m12)
  ) 

  (:goal 
	(forall (?l - Libro) 
		(imply (libro_a_leer ?l) 
			;(and
				(libro_asignado ?l)
				;(forall (?pred - Libro)
					;(or 
						;(libro_leido ?pred)
						;(and 
							;(imply (predecesor ?pred ?l) (libro_asignado ?pred))
							;(imply (paralelo ?pred ?l) (libro_asignado ?pred))
						;)
					;)
				;)
			;)
		)
	)
  )
)