dsolve(true,D,D):-!.
dsolve((A,B), D1,D2) :-!, dsolve(A,D1,D3), dsolve(B,D3,D2).
dsolve(A,D,[A|D]) :- delay(A).
dsolve(A,D1,D2) :- clause(A, B), dsolve(B,D1,D2).
