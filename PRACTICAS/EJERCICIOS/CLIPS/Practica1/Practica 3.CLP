;PRACTICA 3

; Enrique Martin Calvo
; Alberto Martin De Vega

;   PETICION DE ESCENARIO
(defrule escenario "sintomas observados" 
	(declare(salience 1000))
	=>
	(printout T crlf "BIENVENIDO" crlf )
	(printout T "ESCENARIO 1: Motor no arranca y el indicador de batería marca 0" crlf)
	(printout T "ESCENARIO 2: Motor se para y el indicador de combustible marca 0" crlf)
	(printout T "Eliga un escenario (1 o 2)" crlf)
	(assert (escenario (read T)))
)

;CAUSA FALLO
(defrule causa "la causa"
	(declare(salience -1000))
	(causa ?x)
	=>
	(printout T crlf "La causa del fallo es: " ?x crlf)
)
	 
; ESCENARIO 1
(defrule escenario-1 "escenario 1"
	(escenario 1)
	=>
	(assert (nivel bateria 0))
	(assert (comportamiento motor no-arranca))
)

;ESCENARIO 2
(defrule escenario-2 "escenario 2"
	(escenario 2)
	=>
	(assert (nivel deposito 0))
	(assert (comportamiento motor se-para))
)

;INTERMEDIAS
(defrule potencia-baja "potencia baja"
	(comportamiento motor no-arranca)
	=>
	(assert(potencia motor 0))
)

;MOTOR NO ARRANCA
(defrule combustible-no-arranca "Sin combustible en el motor"
	(comportamiento motor no-arranca)
	=>
	(assert(combustible motor  0))
)

;MOTOR SE PARA
(defrule combustible-se-para "Sin combustible en el motor 2"
	(comportamiento motor se-para)
	=>
	(assert(combustible motor 0))
)

;CAUSAS FALLOS

;BATERIA 
(defrule bateria-cero "Sin bateria"
	(nivel bateria 0)
	(potencia motor 0)
	=>
	(assert(causa "bateria baja"))
)

;FUSIBLE
(defrule fusible-fundido "Fusible roto"
	(estado fusible fundido)
	(potencia motor 0)
	=>
	(assert(causa "fusible fundido"))
)

;COMBUSTIBLE
(defrule combustible-vacio "Sin Combustible"
	(combustible motor 0)
	(nivel deposito 0)
	=>
	(assert(causa "deposito vacio"))
)
	