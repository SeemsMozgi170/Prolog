insert(E,[],[E]):-!.
insert(E,[H|T],[E,H|T]):- E<H,!.
insert(E,[H|T],[H|T1]):-
    insert(E,T,T1).

sort_ins(L,SortL):-sort_ins(L,[],SortL).
sort_ins([],SortL,SortL):-!.
sort_ins([H|T],SortPart,SortL):-
    insert(H,SortPart,SortPart1),
    sort_ins(T,SortPart1,SortL).

