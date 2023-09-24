/*Construir un automata de moore segun la diapositiva 3 de los apuntes*/
mov(q0,a,q2).
mov(q0,b,q1).
mov(q1,a,q0).
mov(q1,b,q3).
mov(q2,a,q2).
mov(q2,b,q3).
mov(q3,a,q0).
mov(q3,b,q3).
z(Qi,[],Qi):-!.
z(Qi,[X|Xs],Qf):-X\=[],mov(Qi,X,R1),z(R1,Xs,Qf).
acepta(X,Res):-z(q0,X,Qf),Qf=q1,Res is 1,!.
