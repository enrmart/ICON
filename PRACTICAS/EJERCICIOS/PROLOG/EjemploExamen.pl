% Leer una cadena a^x, b^y, c^z tal que y = x + z

caso(e0,a,[],e1,[a]).
caso(e0,c,[],e1,[c]).

caso(e1,a,[a|P1],e1,[a,a|P1]).
caso(e1,c,[a|P1],e1,[c,a|P1]).
caso(e1,a,[c|P1],e1,[a,c|P1]).
caso(e1,c,[c|P1],e1,[c,c|P1]).

caso(e1,a,[b|P1],e1,P1).
caso(e1,c,[b|P1],e1,P1).

caso(e1,b,[c|P1],e2,P1).
caso(e1,b,[a|P1],e2,P1).

caso(e1,a,[],e1,[a]).
caso(e1,c,[],e1,[c]).
caso(e1,b,[],e2,[b]).

caso(e0,b,[],e2,[b]).

caso(e2,b,[b|P1],e2,[b,b|P1]).

caso(e2,b,[a|P1],e2,P1).
caso(e2,b,[c|P1],e2,P1).

caso(e2,a,[b|P1],e1,P1).
caso(e2,c,[b|P1],e1,P1).

caso(e2,a,[],e1,[a]).
caso(e2,c,[],e1,[c]).

caso(e2,b,[],e2,[b]).

comprueba(_,[],[],eF).
comprueba(Ea,[X|L],P,Ef):-caso(Ea,X,P,En,P2),comprueba(En,L,P2,Ef).

acepta(L2,X):-comprueba(e0,L2,[],Ef),Ef==eF,X is 1.


solve(A):-predicate_property(A,built_in),!,call(A).
solve(true):-!.
solve((A,B)):-!,solve(A),solve(B).
solve(A):-clause(A,B),solve(B).


% Leer una cadena a^x, b^y tal que 2*y = x




caso2(e0,a,[],e1,[a,a]).

caso2(e1,a,[a|P1],e1,[a,a,a|P1]).
caso2(e1,a,[b|P1],e1,[a|P1]).

caso2(e1,b,[a|P1],e2,P1).

caso2(e0,b,[],e2,[b]).

caso2(e2,b,[b|P1],e2,[b,b|P1]).
caso2(e2,b,[a|P1],e2,P1).

caso2(e2,a,[b|P1],e1,[a|P1]).
caso2(e2,a,[b,b|P1],e1,P1).

comprueba2(_,[],[],eF).
comprueba2(Ea,[X|L],P,Ef):-caso2(Ea,X,P,En,P2),comprueba2(En,L,P2,Ef).

acepta2(L2,X):-comprueba2(e0,L2,[],Ef),Ef==eF,X is 1.
















