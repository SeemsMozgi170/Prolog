sum([],0):-!.
sum([H|X],R):-
    sum(X,R1),
    R is R1+H.

find(0,[X|_],X):-!.
find(I,[_|Y],Z):-
    I1 is I-1,
    find(I1,Y,Z).

member_(X,[X|_]):-!.
member_(X,[_|Z]):-member_(X,Z).

min_in_sp([X],X):-!.
min_in_sp([X|Y],R):-
    min_in_sp(Y,R1),
    X =< R1,!,
    R is X.
min_in_sp([X|Y],R):-
    min_in_sp(Y,R1),
    R is R1.
%H/W: сделать min итеративно
reverse(X,Y):-reverse(X,[],Y).
reverse([],Y,Y):-!.
reverse([X|Y],Z,T):-
    reverse(Y,[X|Z],T).

isbegin([],_):-!.
isbegin([X|Y],[X|Z]):-
    isbegin(Y,Z).

sublist(X,Y):-isbegin(X,Y),!.
sublist(X,[Y|Z]):-sublist(X,Z).

delete_([],_,[]):-!.
delete_([X|Y],X,Z):-delete_(Y,X,Z),!.
delete_([X|Y],T,[X|Z]):-
    delete_(Y,T,Z).

append_([],X,X):-!.
append_([X1|Y1],Z,[X1|Y1Z]):-
    append_(Y1,Z,Y1Z).

% предикат, в списке нет повт элем
% объединить 2 отсорт(типа уже) списка в 1 отсорт список(по возр).
% найти длину списка

length1([],0):-!.
length1([H|R],T):-
    length1(R,T1),
    T is T1+1.

first_two([H1,H2|R2]):-
    print(H1),
    print(H2).

mini([X],X):-!.
mini([H1,H2|T],R):-
    H1>=H2,!,
    mini([H2|T],R).
mini([H1,H2|T],R):-
    mini([H1|T],R).

mini2([X]):-print(X),!.
mini2([H1,H2|T]):-
    H1>=H2,!,
    mini2([H2|T]).
mini2([H1,H2|T]):-
    mini2([H1|T]).

hasRepeat([H|T]):-
    member(H,T),!.
hasRepeat([H|T]):-
    hasRepeat(T).

sort_unite([],L1,L1):-!.
sort_unite(L,[],L):-!.

sort_unite([H1|T1],[H2|T2],[H1|T]):-
    H1=<H2,!,
    sort_unite(T1,[H2|T2],T).

sort_unite([H1|T1],[H2|T2],[H2|T]):-
    sort_unite([H1|T1],T2,T).
