;OBJETO UNIVALUADO

(deftemplate   oav-u
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)

;OBJETO MULTIVALUADO

(deftemplate   oav-m
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)

;GARANTIZA LA UNIVARIANTE DE LA REGLA DE BUSQUEDA

(defrule Garantizar-univariante
?x <- (oav-u  (objeto ?o1) (atributo ?a1) (valor ?v1))
?y <- (oav-u  (objeto ?o1) (atributo ?a1) (valor ?v2))
(test (> (fact-index ?x) (fact-index ?y)))
=>
(retract ?y)
)

(deffacts hechos-supuestamente-univaluados

(oav-u (objeto Juan)
		     (atributo edad)
		     (valor 35))
(oav-u (objeto Juan)
		     (atributo edad)
		     (valor 41))
)
