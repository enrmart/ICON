
valor(w1, 1).
conectado(w2, w1).
conectado(w3, w2).
valor(W,X):-conectado(W,V), valor(V,X).


/*Vanilla versión traza*/

solve_traza(true):-!.
solve_traza((A, B)) :-!, solve_traza(A), solve_traza(B).
solve_traza(A):-write('Call: '), write(A), nl,clause(A,B), solve_traza(B),write('Exit: '), write(A), nl.




/*Ejercicio Vanilla Trazas*/
solve_traza_nivel(A):-N is 0,solve_traza_nivel_aux(A,N).
solve_traza_nivel_aux(true,_):-!.
solve_traza_nivel_aux((A, B),Z) :-!,tab(Z),solve_traza_nivel_aux(A,Z),tab(Z), solve_traza_nivel_aux(B,Z).
solve_traza_nivel_aux(A,Z):-clause(A,B),write(Z),write(A),Zs is Z+1,nl,solve_traza_nivel_aux(B,Zs).
