/*Construir un automata de pila que acepte los palindromos*/
mueve(q0, a, [z], q0, [a|z]).
mueve(q0, a, [a|H], q0, [a|[a|H]]).
mueve(q0, b, [a|H], q1, H).
mueve(q1, b, [a|H], q1, H).
mueve(q1,[],[z],qf,[z]).
transita(q1,[],z,qf,[z]):-!.
transita(Qi, [X|Y], R, Qf, T):- X \=[],mueve(Qi, X, R, P, S), transita(P,Y, S, Qf, T).
recorre([X|XS],_):-X\=e,recorre(XS,_).
recorre([X|XS]):-X==e.
acepta(X,Resultado) :-recorre(X,L),transita(q0,X,[L|[z]],Q,_), Q=qf,Resultado is 1, !.

