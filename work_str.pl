
pr3(X):-
    string_concat(X,', ',Z),
    write(Z),
    write(Z),
    write(X),nl,
    string_length(X,L),write(L).


pr1(X):-
    string_length(X,L1),
    Y is L1 mod 2,Y=0,!,
    sub_string(X,0,1,_,B),
    print(B),nl,
    sub_string(X,_,1,0,E),
    print(E).
pr1(X):-
    string_length(X,L1),
    sub_string(X,0,1,_,B),
    print(B),nl,
    D is L1 div 2,
    sub_string(X,D,1,_,Z1),
    print(Z1),nl,
    sub_string(X,_,1,0,E),
    print(E).

pr4(X):-
    sub_string(X,_,1,0,S),
    sub_string(X,Y,_,_,S),
    print(Y).

pr5(X):-
    split_string(X,"abc","abc",L),
    print(L),
    atomics_to_string(L,'',S),
    print(S).
pr6(X):-
    split_string(X,' ',' ',L),
    atomics_to_string(L,' ',R),
    print(R).
