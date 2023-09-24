;Alberto Martin De Vega
;Enrique Martin Calvo

;DEFINICION DE UNIVALUADO
(deftemplate   oav-u
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)

(deftemplate   oav-m
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)

;GARANTIZA LA UNIVARIANTE EN LA REGLA DE BUSQUEDA
(defrule Garantizar-univariante
 	?x <- (oav-u (objeto ?o1) (atributo ?a1) (valor ?v1))
    	?y <- (oav-u (objeto ?o1) (atributo ?a1) (valor ?v2))
	(test (> (fact-index ?x) (fact-index ?y)))
=>
	(retract ?y)
)

;ELIGIENDO EL PACIENTE A DIAGNOSTICAR

(defrule escenario
	(declare (salience 1000))
	=>
	(printout T crlf "BIENVENIDO" crlf )
	(printout T "ESCENARIO 1: Paciente Lucía Mujer 10 Fiebre Dolor de pecho Rumor sistólico 145/50" crlf)
	(printout T "ESCENARIO 2: Paciente Juan Hombre 50 Dolor de pecho 25 años fumando 125/75" crlf)
	(printout T "Eliga un escenario (1 o 2)" crlf)
	(assert (oav-u 
		(objeto escenario) 
		(atributo numero) 
		(valor (read T))))
)

;PACIENTE LUCIA 

(defrule Paciente1
	(declare (salience 1))
	(oav-u (objeto escenario) (atributo numero) (valor 1))
=>
	(assert(oav-u (objeto pacienteA)(atributo nombre)(valor Lucia))
		(oav-u (objeto pacienteA)(atributo sexo)(valor mujer))
		(oav-u (objeto pacienteA)(atributo edad)(valor 10))
		(oav-m (objeto pacienteA)(atributo sintomas)(valor dolor_pecho))
		(oav-m (objeto pacienteA)(atributo sintomas)(valor fiebre))
		(oav-m (objeto pacienteA)(atributo evidencias)(valor rumor_sistolico))
		(oav-u (objeto pacienteA)(atributo sistolica)(valor 145))
		(oav-u (objeto pacienteA)(atributo diastolica)(valor 50)))
)
	
;PACIENTE JUAN 

(defrule Paciente2
	(declare (salience 1))
	(oav-u (objeto escenario) (atributo numero) (valor 2))
=>
	(assert(oav-u (objeto pacienteB)(atributo nombre)(valor Juan))
		(oav-u (objeto pacienteB)(atributo sexo)(valor hombre))
		(oav-u (objeto pacienteB)(atributo edad)(valor 50))
		(oav-m (objeto pacienteB)(atributo sintomas)(valor dolor_pecho))
		(oav-m (objeto pacienteB)(atributo evidencias)(valor 25_años_fumando))
		(oav-u (objeto pacienteB)(atributo sistolica)(valor 125))
		(oav-u (objeto pacienteB)(atributo diastolica)(valor 75)))
)

; ENFERMEDADES
(defrule aneurisma_arteria_abdominal 
	(declare (salience -1000))
	(oav-m (objeto ?paciente)(atributo sintomas)(valor dolor_abdominal))
	(oav-m (objeto ?paciente)(atributo evidencias)(valor rumor_abdominal))
	(oav-m (objeto ?paciente)(atributo evidencias)(valor masa_pulsante))
=>
	(assert (oav-m (objeto ?paciente)(atributo enfermedades)(valor aneurisma_arteria_abdominal)))
	(printout t "El " ?paciente " padece de aneurisma de la arteria abdominal." crlf)
)
	

(defrule regurgitacion_aortica
	(declare (salience -1000))
	(oav-u (objeto ?paciente)(atributo sistolica)(valor ?sistolica & :(> ?sistolica 135)))
	(oav-u (objeto ?paciente)(atributo diastolica)(valor ?diastolica & :(> (- ?sistolica ?diastolica) 85)))
	(oav-m (objeto ?paciente)(atributo evidencias)(valor rumor_sistolico | dilatacion_corazon))
=>
	(assert (oav-m (objeto ?paciente)(atributo enfermedades)(valor regurgitacion_aortica)))
	(printout t "El " ?paciente " padece de regurgitacion aortica." crlf)
)


(defrule estenosis
	(declare (salience -1000))
	(oav-m (objeto ?paciente)(atributo sintomas)(valor calambres_piernas))
=>
	(assert (oav-m (objeto ?paciente)(atributo enfermedades)(valor estenosis)))
	(printout t "El " ?paciente " padece de estenosis." crlf)
)

;RIESGO ALTO DE ENFERMEDAD

(defrule riesgo
	(declare (salience -1000))
	(or (oav-u (objeto ?paciente)(atributo edad)(valor ?edad & :(> ?edad 55)))
		(oav-m (objeto ?paciente)(atributo datos_relevantes)(valor obeso | fumador_mas_de_18_años)))
=>
	(assert (oav-u (objeto ?paciente)(atributo riesgo)(valor alto)))
)

;ENFERMEDADES

(defrule arteriosclerosis
	(declare (salience -1000))
	(oav-m (objeto ?paciente)(atributo enfermedades)(valor estenosis))
	(oav-u (objeto ?paciente)(atributo riesgo)(valor alto))
=>
	(assert (oav-m (objeto ?paciente)(atributo enfermedades)(valor arteriosclerosis)))
	(printout t "El " ?paciente " padece de arteriosclerosis." crlf)
)

;DE QUE ES AFECCION 

(defrule enfermedad_corazon
	(declare (salience -1000))
	(oav-u (objeto ?paciente)(atributo nombre)(valor ?nombre))
	(oav-m (objeto ?paciente)(atributo enfermedades)(valor regurgitacion_aortica))
=>
	(printout t "El " ?paciente ", " ?nombre ", padece al menos una enfermedad cardiovascular que afecta al corazon." crlf)
)

(defrule enfermedad_vasos
	(declare (salience -1000))
	(oav-u (objeto ?paciente)(atributo nombre)(valor ?nombre))
	(oav-m (objeto ?paciente)(atributo enfermedades)(valor aneurisma_arteria_abdominal | estenosis | arteriosclerosis))
=>
	(printout t "El " ?paciente ", " ?nombre ", padece al menos una enfermedad cardiovascular que afecta a los vasos sanguineos." crlf)
)

;SANO 

(defrule sano
	(declare(salience -1000))
	(oav-u (objeto ?paciente)(atributo nombre)(valor ?nombre))
	(not	(oav-m (objeto ?paciente)(atributo enfermedades)(valor aneurisma_arteria_abdominal | estenosis | arteriosclerosis|regurgitacion_aortica))) 
=>
	(printout t "El " ?paciente ", " ?nombre ", no posee ninguna enfermedad." crlf)
)