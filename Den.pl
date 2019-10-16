append_([],X,X):-!.
append_([X1|Y1],Z,[X1|Y1Z]):-
    append_(Y1,Z,Y1Z).

z([],_):-!.
z([H|T],[H|L1]):-
    del2(H,[H|T],L,CS),CS>3,
    z(L,L1),!.
%z([H|T],L1):- z([H|T],L1).
z([H|T],L1):-
    del2(H,[H|T],L,_),
    z(L,L1).

del2(E,[E|T],R,CC):-del(E,[E|T],R,0,CC).
del(_,[],[],C,CC):-CC is C,!.
del(E,[E|T],R,C,CC):-
    C1 is C+1,
    del(E,T,R,C1,CC),!.
del(E,[H|T],[H|R],C,CC):-del(E,T,R,C,CC).



