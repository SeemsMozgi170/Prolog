:-dynamic fact/2.
fact(1,1):-!.
fact(X,Y):-
    X1 is X-1,
    fact(X1,Y1),
    asserta(fact(X1,Y1)),
    Y is Y1 * X,!.

:-dynamic fib/2.
fib(1,1):-!.
fib(2,1):-!.
fib(X,Result):-
    X1 is X-1,
    X2 is X-2,
    fib(X1,Result1),
    fib(X2,Result2),
    asserta(fib(X1,Result1)),
    asserta(fib(X2,Result2)),
    Result is Result1+Result2,!.

student('Иванов','21.3.1998','89484827742').
student('Лебедева','25.05.1990','89471966243').
student('Костенко','26.06.1990','82759267745').

:-dynamic studentd/3.
myassert :-
    student(X,Y,Z),
    assertz(studentd(X,Y,Z)),fail.
myassert:-!.


