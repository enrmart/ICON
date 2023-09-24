/*Propagacion de se�al modificada*/

:-op(40, xfy, &).
:-op(50, xfy, --->).

true ---> valor(w1, 1).
true ---> conectado(w2, w1).
true ---> conectado(w3, w2).
conectado(W,V) & valor(V,X) ---> valor(W,X).


/*Metainterprete vanilla modificado*/

:-op(40, xfy, &).
:-op(50, xfy, --->).

solve(true):-!.
solve((A & B)) :-!, solve(A), solve(B).
solve(A) :- (B ---> A), solve(B).


