%------------------EJERCICIO 1
caso(e0,a,[],e1,[a]).
caso(e0,b,[],e1,[b]).

caso(e1,a,[a|P1],e1,[a,a|P1]).
caso(e1,b,[b|P1],e1,[b,b|P1]).
caso(e1,a,[b|P1],e1,[a,b|P1]).
caso(e1,b,[a|P1],e1,[b,a|P1]).

caso(e1,a,[c|P1],e1,P1).
caso(e1,b,[c|P1],e1,P1).
caso(e1,a,[d|P1],e1,P1).
caso(e1,b,[d|P1],e1,P1).

caso(e1,c,[a|P1],e2,P1).
caso(e1,d,[a|P1],e2,P1).
caso(e1,c,[b|P1],e2,P1).
caso(e1,d,[b|P1],e2,P1).


caso(e0,c,[],e2,[c]).
caso(e0,d,[],e2,[d]).

caso(e2,c,[c|P1],e2,[c,c|P1]).
caso(e2,d,[c|P1],e2,[d,c|P1]).
caso(e2,c,[d|P1],e2,[c,d|P1]).
caso(e2,d,[d|P1],e2,[d,d|P1]).

caso(e2,c,[a|P1],e2,P1).
caso(e2,d,[b|P1],e2,P1).
caso(e2,c,[a|P1],e2,P1).
caso(e2,d,[b|P1],e2,P1).

caso(e2,a,[c|P1],e1,P1).
caso(e2,b,[c|P1],e1,P1).
caso(e2,a,[d|P1],e1,P1).
caso(e2,b,[d|P1],e1,P1).




%
 % Ejemplo de ejecuci�n:
 % ?- comprueba([a,a,b,b,c,c], X).
 % Resultado: X = 1 (correcto)
 %/
controla(e2,[],[],eF).
controla(e1,[],[],eF).

controla(Ea,[X|Xs],P1,Ef):-caso(Ea,X,P1,Es1,Ps),controla(Es1,Xs,Ps,Ef).
% acepta(L, Res)
% Argumentos:
% - L: lista con los elementos a comprobar. Para que sea una lista
%		"correcta", debe tener el mismo n�mero de a's, b's y c's.
% - Res: variable que contendr� 1 si es correcto.
acepta(L, Res):-controla(e0,L,[],EF),eF=EF,Res is 1,!.


%-----------EJERCICIO2

% Meta-int�rprete Vanilla mejorado
% Llamada con el meta-interprete:
%	solve(comprueba([a,a,b,b,c,c], X)).
solve(A):-predicate_property(A,built_in),!,call(A).
solve(true).
solve((A,B)):-solve(A),solve(B).
solve(A):-clause(A,B),solve(B).



% Funcion propia. nl significa 'new line'.
pinta_call(A):-
	write('Call: '),
	write(A),
	nl.
pinta_exit(A):-
	write('Exit: '),
	write(A),
	nl.

% Meta-int�rprete Vanilla mejorado con traza
% Llamada con el meta-interprete:
%	solve_traza(comprueba([a,a,b,b,c,c], X)).
solve_traza(A):-
	predicate_property(A,built_in),
	!,
	call(A).
solve_traza(true):-
	!.
solve_traza((A,B)):-
	!,
	solve_traza(A),
	solve_traza(B).
solve_traza(A):-
	pinta_call(A),
	clause(A,B),
	solve_traza(B),
	pinta_exit(A).

% Meta-int�rprete Vanilla mejorado con traza y de derecha a izquierda
% De derecha a izquierda es tan solo cambiar A por B en el 3er bloque.
% Llamada con el meta-interprete:
%	solve_traza(comprueba([a,a,b,b,c,c], X)).
solve_traza_inverso(A):-predicate_property(A,built_in),!,call(A).
solve_traza_inverso(true).
solve_traza_inverso((A,B)):-
	solve_traza_inverso(B),
	solve_traza_inverso(A).
solve_traza_inverso(A):-
	pinta_call(A),
	clause(A,B),
	solve_traza_inverso(B),
	pinta_exit(A).
