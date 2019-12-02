createNeedList(1,_,[]):-!.
createNeedList(X,ParentX,[H|T]):-
    append(ParentX,[X],H),
    X1 is X-1,
    createNeedList(X1,ParentX,T).

insert(AE-E,[],[AE-E]):-!.
insert(AE-E,[AH-H|T],[AE-E,AH-H|T]):- E<H,!.
insert(AE-E,[AH-H|T],[AH-H|T1]):-
    insert(AE-E,T,T1).

sort_ins(L,SortL):-sort_ins(L,[],SortL).
sort_ins([],[],_):-!.
sort_ins([],SortL,SortL):-!.
sort_ins([AH-H|T],SortPart,SortL):-
    insert(AH-H,SortPart,SortPart1),
    sort_ins(T,SortPart1,SortL).

createNewList([],[]):-!.
createNewList([H|T],[H-SumH|T1]):-
    sum_list(H,SumH),
    createNewList(T,T1).

returnOldList([],[]):-!.
returnOldList([H-_|T],[H|T1]):-
    returnOldList(T,T1).

sortList(List,SortedList):-
    createNewList(List,ListWithSum),
    sort_ins(ListWithSum,SortedList).

inputData(FilteredListDegreeAllGraph):-
    write('Количество вершин = '),read(CountVertex),
    write('Количество ребер = '),read(CountEdge),
    SumDegreeVertex is CountEdge*2,
    MaxDegreeVertex is SumDegreeVertex-2*CountVertex+2,
    write(MaxDegreeVertex),nl,
    CountVertex1 is CountVertex - 1,
    createNeedList(MaxDegreeVertex,[],List1),
    beginCreateList(List1,MaxDegreeVertex,SumDegreeVertex,CountVertex1,ResList),
    filterListsDegree(ResList,FilteredListDegreeAllGraph),write(FilteredListDegreeAllGraph),nl,
    createGraphs(FilteredListDegreeAllGraph).

filterTwoList([],[]):-!.
filterTwoList([H|T],List2):-
    delete([H|T],H,NewList1),
    delete(List2,H,NewList2),
    filterTwoList(NewList1,NewList2).

filterListDegree([H1],[H1]):-!.
filterListDegree([H1,H2|T],T1):-
    filterTwoList(H1,H2),
    filterListDegree([H1|T],T1),!.
filterListDegree([H1,H2|T],[H2|T1]):-
    filterListDegree([H1|T],T1),!.

filterListsDegree([],[]):-!.
filterListsDegree([H1],[H1]):-!.
filterListsDegree(List,[H|Res]):-
    filterListDegree(List,FilterH),
    reverse(FilterH,[H|T1]),
    filterListsDegree(T1,Res),!.

createBranches([],_,1,G,G):-!.
createBranches([V-S|T],Sum,Max,IResG,ResG):-
    S = Sum,
    createNeedList(Max,V,List2),
    append(IResG,List2,G1),
    createBranches(T,Sum,Max,G1,ResG),!.

createBranches([V-S|T],_,Max,IResG,ResG):-
    Max1 is Max - 1,
    createBranches([V-S|T],S,Max1,IResG,ResG),!.

lastMove([],Sum,[]):-!.
lastMove([H|T],Sum,[H1|ResList]):-
    sum_list(H,SH),
    N is Sum - SH,N>1,
    append(H,[N],H1),
    lastMove(T,Sum,ResList).
lastMove([H|T],Sum,ResList):-
    lastMove(T,Sum,ResList).

beginCreateList(R,MDV,Sum,1,R1):-
    lastMove(R,Sum,R1),!.
beginCreateList(List1,MDV,Sum,CountVertex,R):-
%    isNeed(List,List1),
%    write(List1),nl,
    sortList(List1,[V-S|T]),
    createBranches([V-S|T],S,MDV,[],Res),
    CountVertex1 is CountVertex-1,
    beginCreateList(Res,MDV,Sum,CountVertex1,R),!.
















