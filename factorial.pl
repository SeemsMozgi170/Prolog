factorial(0,1):-!.
factorial(1,1):-!.
factorial(X,Res):-
    X1 is X-1,
    factorial(X1,Res1),
    Res is X*Res1.

facti(X,Y):-facti(X,Y,1,1).
/*
factn(X,Y,I,P):-
    I=<X,!,
    P1 is P*I,
    I1 is I+1,
    factn(X,Y,I1,P1).
factn(_,P,_,P).
*/
facti(X,P,X,P):-!.
facti(X,Y,I,P):-
    I1 is I+1,
    print(I1),
    P1 is P*I1,
    print(P1),
    facti(X,Y,I1,P1).

sochet(N,N,1):-!.
sochet(N,M,R):-
    N > M,
    factorial(N,R1),
    factorial(M,R2),
    factorial(N-M,R3),
    R is R1//(R2*R3).






