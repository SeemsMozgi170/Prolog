fib(1,1):-!.
fib(2,1):-!.
fib(X,Result):-
    X1 is X-1,
    X2 is X-2,
    fib(X1,Result1),
    fib(X2,Result2),
    Result is Result1+Result2.
fibi(X,Y):-fibin(X,Y,1,0,1).
fibin(X,P,X,_,P):-!.
fibin(X,Y,I,T,P):-
    P1 is T+P,
    I1 is I+1,
    fibin(X,Y,I1,P,P1).

