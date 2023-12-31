/*Asistente al diagn�stico de la instalaci�n el�ctrica propuesto por Poole y Mackworth.
 *
 *bombilla (light)
 *funciona correctamente(ok)
 *lega tensi�n (live)
 *enciende (lit)
 *cable est� conectado a otro (connected_to)
 *interruptor cerrado(up)
 *interruptor abierto(down)
 *
 *
*/

:-op(40, xfy, &).
:-op(50, xfy, --->).

true--->live(outside).
true--->light(l1).
true--->light(l2).
true--->down(s1).
true--->up(s2).
true--->up(s3).
true--->ok(_).
true--->connected_to(p2,w6).
true--->connected_to(p1,w3).

light(L)& ok(L) & live(L)---> lit(L).
connected_to(W,W1) & live(W1)---> live(W).
up(s2) & ok(s2) ---> connected_to(w0,w1).
ok(cb2) ---> connected_to(w6,w5).
ok(cb1) ---> connected_to(w3,w5).
up(s1) & ok(s1) ---> connected_to(w1,w3).
up(s3) & ok(s3) ---> connected_to(w4,w3).
