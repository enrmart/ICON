%----------------EJERCICIO3
%
 % Ejemplo de ejecución:
 % ?- acepta([a,a,b,b,c,c], X).
 % Resultado: X = 1 (correcto)

recorre([],0,0,0).

recorre([X|Xs],A,B,C):-X==a,recorre(Xs,As,B,C),A is As+1.
recorre([X|Xs],A,B,C):-X==b,recorre(Xs,A,Bs,C),B is Bs+1.
recorre([X|Xs],A,B,C):-X==c,recorre(Xs,A,B,Cs),C is Cs+1.

% acepta(L, Res)
% Argumentos:
% - L: lista con los elementos a comprobar. Para que sea una lista
%               "correcta", debe tener el mismo número de a's y b's que
%               c's.
% - Res: variable que contendrá 1 si es correcto.
acepta(L, Res):-recorre(L,A,B,C),A+B =:= C,Res is 1,!.

%---------------EJERCICIO4

% Meta-intérprete Vanilla mejorado
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

% Meta-intérprete Vanilla mejorado con traza
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

% Meta-intérprete Vanilla mejorado con traza y de derecha a izquierda
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
