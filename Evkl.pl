nod(A,0,A):-!.
nod(0,A,A):-!.
nod(A,B,C):-
    A>=B,!,
    X is A-B,
    nod(B,X,C).
nod(A,B,C):-
    X is B-A,
    nod(A,X,C).

nok(A,B,P):-
    nod(A,B,C),
    P is (A*B) div C.

max(A,B,A):- A>=B,!.
max(_,B,B).

min(A,B,A):- A<B,!.
min(_,B,B).

nokv2(A,B,Res):- nokv2(A,B,0,Res).

nokv2(A,B,Buf,Buf):-
    Buf \= 0,
    X is Buf mod A,
    Y is Buf mod B,
    not(dif(X,0)),
    not(dif(Y,0)),!.

nokv2(A,B,Buf,Res):-
    max(A,B,M),
    Buf2 is Buf + M,
    nokv2(A,B,Buf2,Res).
