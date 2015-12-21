(define (problem libros)
	
  (:domain libros)

  (:objects
    m1 m2 m3 m4 m5 m6 m6 m7 m8 m9 m10 m11 m12 - Mes
	harryPotter1 harryPotter2 harryPotter3 harryPotter4 seniorAnillos1 seniorAnillos2 seniorAnillos3 starWars1 starWars2 elHobbit - Libro
  )

  (:init
    (predecesor harryPotter1 harryPotter2)
	(predecesor harryPotter2 harryPotter3)
	(predecesor harryPotter3 harryPotter4)
	(predecesor seniorAnillos1 seniorAnillos2)
	;(predecesor seniorAnillos1 seniorAnillos3)
	(predecesor seniorAnillos2 seniorAnillos3)
	(predecesor starWars1 starWars2)
    ;(mes_libre m1) (mes_libre m2) (mes_libre m3) (mes_libre m4) (mes_libre m5) (mes_libre m6) (mes_libre m7) (mes_libre m8) (mes_libre m9)
	;(mes_libre m10) (mes_libre m11) (mes_libre m12)
	(libro_leido starWars1)
	;(libro_leido seniorAnillos1)
	(libro_leido harryPotter1)
	(libro_a_leer harryPotter4)
	;(libro_a_leer seniorAnillos2)
	(libro_a_leer seniorAnillos3)
	(libro_a_leer starWars2)
	(libro_a_leer elHobbit)
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
	(forall (?l - Libro) (imply (libro_a_leer ?l) (and
		(libro_asignado ?l)
		 (forall (?pred - Libro) (imply (predecesor ?pred ?l) (libro_asignado ?l)))
		)
	))
  )
)