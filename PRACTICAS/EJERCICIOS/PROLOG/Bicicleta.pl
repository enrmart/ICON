% Definir el �rbol mediante las relaciones:
%	pieza_basica(cadena).
%	ensamblaje(bicicleta, [rueda_delantera, cuadro, rueda_trasera]).
% Construir relaciones �piezas_de�, que sirva para obtener la lista de
% piezas b�sicas para construir una determinada parte de (o toda) la
% bicicleta.
%
pieza_basica(llanta).
pieza_basica(radios).
pieza_basica(eje).
pieza_basica(manillar).
pieza_basica(sillin).
pieza_basica(plato).
pieza_basica(pedales).
pieza_basica(cadena).
pieza_basica(pi�ones).

ensamblaje(bicicleta,[rueda_delantera,cuadro,rueda_trasera]).
ensamblaje(rueda_delantera, [llanta, radios, eje]).
ensamblaje(cuadro, [manillar, sillin, traccion]).
ensamblaje(traccion, [eje, plato, pedales, cadena]).
ensamblaje(rueda_trasera, [llanta, radios, eje, pi�ones]).

desmontar([B|_],B):-pieza_basica(B).

desmontar([_|L1],L):-desmontar(L1,L).

desmontar([C|_],L):-ensamblaje(C,L1),desmontar(L1,L).

piezas_de(X,L):-ensamblaje(X,L1),desmontar(L1,L).
