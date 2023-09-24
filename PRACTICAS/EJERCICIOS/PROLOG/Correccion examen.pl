caso(e0,a,[],e1,[a]).
caso(e0,b,[],e1,[b]).
caso(e0,c,[],e1,[c]).

caso(e1,a,[a|P1],e1,[a,a|P1]).
caso(e1,b,[a|P1],e1,[b,a|P1]).
caso(e1,c,[a|P1],e1,[c,a|P1]).


caso(e1,a,[b|P1],e1,[a,b|P1]).
caso(e1,b,[b|P1],e1,[b,b|P1]).
caso(e1,c,[b|P1],e1,[c,b|P1]).

caso(e1,a,[c|P1],e1,[a,c|P1]).
caso(e1,b,[c|P1],e1,[b,c|P1]).
caso(e1,c,[c|P1],e1,[c,c|P1]).

caso(e1,a,[d|P1],e1,P1).
caso(e1,b,[d|P1],e1,P1).
caso(e1,c,[d|P1],e1,P1).

caso(e1,d,[a|P1],e2,P1).
caso(e1,d,[b|P1],e2,P1).
caso(e1,d,[c|P1],e2,P1).

caso(e0,d,[],e2,[d]).

caso(e2,d,[d|P1],e2,[d,d|P1]).

caso(e2,d,[a|P1],e2,P1).
caso(e2,d,[b|P1],e2,P1).
caso(e2,d,[c|P1],e2,P1).

caso(e2,a,[d|P1],e1,P1).
caso(e2,b,[d|P1],e1,P1).
caso(e2,c,[d|P1],e1,P1).

comprueba(e2,[_],[],eF).
comprueba(e2,[],[],eF).

comprueba(e1,[],[],eF).
comprueba(e1,[],[_],eF).
% CASO RECURSIVO QUE VA RECORRIENDO LA LISTA RECIBIDA HASTA QUE ESTA
% VACIA
comprueba(Ea,[X|L],Pa,Ef):-caso(Ea,X,Pa,Es,Ps),comprueba(Es,L,Ps,Ef).

% FUNCION QUE EJECUTA EL USUARIO Y QUE DEVUELVE 1 SI HAY MAS DES QUE
% LA SUMA DE LAS DEMAS LETRAS
acepta(L,X):-comprueba(e0,L,[],Ef),Ef==eF, X is 1.
