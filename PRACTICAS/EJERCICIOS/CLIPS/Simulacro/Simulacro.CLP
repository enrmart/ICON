;SIMULACRO DE EXAMEN 


;DEFINICION DE OBJETOS UNIVALUADOS
(deftemplate oav-u "Plantilla Hechos univaluados"
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)
;DEFINICION OBJETOS MULTIVALUADOS
(deftemplate oav-m "Plantilla Hechos multivaluados"
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)
;GARANTIZA UNIVALUADOS
(defrule garantizar-univaluados
    (declare (salience 10000))
    ?x <- (oav-u (objeto ?o1) (atributo ?a1) (valor ?v1))
    ?y <- (oav-u (objeto ?o1) (atributo ?a1) (valor ?v2))
    (test (> (fact-index ?x) (fact-index ?y)))
	=>
	(retract ?y)
) 

;SOLICITA ESCENARIO
(defrule escenario
	(declare (salience 1000))
	=>
	(printout T crlf "BIENVENIDO" crlf)
	(printout T "ESCENARIO 1: MOVIL 14 MESES ACTUAL SE APAGA INESPERADAMENTE" crlf)
	(printout T "ESCENARIO 2: TABLET 20 MESES ACTUAL ERROR EN EL ARRANQUE FALLO BATERIA SE APAGA INESPERADAMENTE" crlf)
	(printout T "ESCENARIO 3: PORTATIL 30 MESES NO ACTUAL NO ENCIENDE" crlf)
	(printout T "Elija un escenario(1,2 o 3):" crlf)
	(assert (oav-u
			(objeto escenario)
			(atributo numero)
			(valor (read T))))
)
;COMPROBACION ESCENARIO VALIDO
(defrule comprueba-escenario
	(not(oav-u (objeto escenario) (atributo numero) (valor 1 | 2 | 3 )))
	=>
	(printout T crlf "NO HA SELECCIONADO UN ESCENARIO VALIDO" crlf)
	(printout T "ESCENARIO 1: MOVIL 14 MESES ACTUAL SE APAGA INESPERADAMENTE" crlf)
	(printout T "ESCENARIO 2: TABLET 20 MESES ACTUAL ERROR EN EL ARRANQUE FALLO BATERIA SE APAGA INESPERADAMENTE" crlf)
	(printout T "ESCENARIO 3: PORTATIL 30 MESES NO ACTUAL NO ENCIENDE" crlf)
	(printout T "Por favor,elija un escenario valido(1,2 o 3):" crlf)
	(reset)
	(run)
)

;DISPOSITIVO MOVIL
(defrule escenario-1
	(declare(salience 1))
	(oav-u (objeto escenario) (atributo numero) (valor 1 ))
	=>
	(assert (oav-u(objeto movil)(atributo tipo)(valor movil))
		(oav-u(objeto movil)(atributo antiguedad)(valor 14))
		(oav-u(objeto movil)(atributo SO)(valor actual))
		(oav-m(objeto movil)(atributo fallo)(valor apaga-repentinamente)))
)

;DISPOSITIVO TABLET
(defrule escenario-2
	(declare(salience 1))
	(oav-u (objeto escenario) (atributo numero) (valor 2 ))
	=>
	(assert (oav-u(objeto tablet)(atributo tipo)(valor tablet))
		(oav-u(objeto tablet)(atributo antiguedad)(valor 20))
		(oav-u(objeto tablet)(atributo SO)(valor actual))
		(oav-m(objeto tablet)(atributo fallo)(valor apaga-repentinamente))
		(oav-m(objeto tablet)(atributo fallo)(valor error-arranque))
		(oav-m(objeto tablet)(atributo fallo)(valor bateria)))	
)

;DISPOSITIVO PORTATIL
(defrule escenario-3
	(declare(salience 1))	
	(oav-u (objeto escenario) (atributo numero) (valor 3))
	=>
	(assert (oav-u(objeto portatil)(atributo antiguedad)(valor 30))
		(oav-u(objeto portatil)(atributo SO)(valor no-actual))
		(oav-m(objeto portatil)(atributo fallo)(valor no-enciende)))	
)

;REGLAS INTERMEDIAS

(defrule no-revisable
	(oav-u (objeto ?dispositivo) (atributo antiguedad) (valor ?meses))
	(test(> ?meses 24))
=>
	(assert (oav-u(objeto ?dispositivo) (atributo estado) (valor no-revisable)))
	(printout T crlf "El dispositivo" ?dispositivo " no es posible revisarlo"crlf)
)

(defrule revisable
	(oav-u (objeto ?dispositivo) (atributo antiguedad))
	(not (oav-u (objeto ?dispositivo) (atributo estado) (valor no-revisable)))
=>
	(assert(oav-u (objeto ?dispositivo) (atributo estado) (valor revisable)))
	
)
	
;FALLO SISTEMA OPERATIVO

(defrule fallo-SO
	(oav-u (objeto ?dispositivo) (atributo estado) (valor revisable))
	(oav-m (objeto ?dispositivo) (atributo fallo) (valor error-arranque | ficheros-corruptos))
=>
	(assert (oav-m(objeto causa) (atributo fallo) (valor sistema-operativo)))
	(printout T crlf "EL FALLO ES PROBLEMA DEL SISTEMA OPERATIVO" crlf)
)

;FALLO ALIMENTACIÓN
(defrule fallo-alimentacion
	(oav-u (objeto ?dispositivo) (atributo estado) (valor revisable))
	(oav-m (objeto ?dispositivo) (atributo fallo) (valor bateria))
	(oav-m (objeto ?dispositivo) (atributo fallo) (valor no-enciende | apaga-inesperadamente))
=>
	(assert (oav-m(objeto causa) (atributo fallo) (valor alimentacion)))
	(printout T crlf "EL FALLO ES PROBLEMA DE LA ALIMENTACION" crlf)
)

;FALLO MAL-USO
(defrule fallo-mal-uso
	(oav-u (objeto ?dispositivo) (atributo estado) (valor revisable))
	(oav-m (objeto ?dispositivo) (atributo fallo) (valor golpeado))
	(oav-m (objeto ?causa) (atributo fallo) (valor alimentacion))
=>
	(assert (oav-m(objeto causa) (atributo fallo) (valor mal-uso)))
	(printout T crlf "EL FALLO ES EL MAL USO DEL DISPOSITIVO" crlf)
)

;NO DIAGNOSTICABLE
(defrule fallo-no-encontrado
	(declare (salience -1 ))
	(oav-u (objeto ?dispositivo) (atributo estado) (valor revisable))
	(not(oav-m (objeto ?causa) (atributo fallo) (valor alimentacion | mal-uso | sistema-operativo)))
=>
	(assert (oav-m(objeto causa) (atributo fallo) (valor no-conocida)))
	(printout T crlf "NO HA SIDO POSIBLE ENCONTRAR EL FALLO" crlf)
)
