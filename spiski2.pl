bubble([],[]):-!.
bubble([X],[X]):-!.
bubble([X,Y|T],[Y|T1]):-
    X>=Y,!,
    bubble([X|T],T1).
bubble([X,Y|T],[X|T1]):-
    bubble([Y|T],T1).

bubble_sort(X,X):-
    bubble(X,X1),
    X = X1,!.

bubble_sort(X,R):-
    bubble(X,R1),
    bubble_sort(R1,R).
%-----------------------------------
swap([X,Y|Z],[Y,X|Z]):-X>Y,!.
swap([X|Y],[X|Y1]):-swap(Y,Y1),!.

bubbleSort(Q,W):-
    swap(Q,X),!,
    bubbleSort(X,W).
bubbleSort(X,X):-!.
%-----------------------------------
append_([],X,X):-!.
append_([X1|Y1],Z,[X1|Y1Z]):-
    append_(Y1,Z,Y1Z).

split([],[],[]):-!.
split([H],[H|_],_):-!.
split([H1,H2|T],[H2|T1],BList):-
    H1>=H2,!,
    split([H1|T],T1,BList).
split([H1,H2|T],MList,[H2|T1]):-
    split([H1|T],MList,T1).

qs([],[]):-!.
qs([X],[X]):-!.
qs(L,L1):-
    split(L,ML,BL),
    qs(ML,ML1),
    qs(BL,BL1),
    append(ML1,BL1,L1).

