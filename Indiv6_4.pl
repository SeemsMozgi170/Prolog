createListChildren(1,_,[]):-!.
createListChildren(X,ParentX,[H|T]):-
    append(ParentX,[X],H),
    X1 is X-1,
    createListChildren(X1,ParentX,T).

input:-
    write('���������� ������ = '),read(CountVertex),
    write('���������� ����� = '),read(CountEdge),
    ((CountEdge >= CountVertex, CountVertex > 2, createListDegreeVertexGraph(CountVertex,CountEdge,List));
    write("������ ���! ������ �� �����")),
    write(List).

createListDegreeVertexGraph(CountVertex,CountEdges,Result):-
    SumAllDegreeVertexGraph is CountEdges*2,
    MaxDegreeVertexGraph is SumAllDegreeVertexGraph - (CountVertex-1)*2,
    createListChildren(MaxDegreeVertexGraph,[],List1),
    sortList(List1,[E-S|T]),
    CountVertex1 is CountVertex - 1,
    createList(E-S,[E-S|T],S,MaxDegreeVertexGraph,CountVertex1,Res),
    endCreateList(Res,SumAllDegreeVertexGraph,Res1),
    filterListsDegree(Res1,Result).

createList(E-S,Res,ActualSum,MaxDegreeVertexGraph,1,Res):-!.
createList(E-S,[E-S|List],ActualSum,MaxDegreeVertexGraph,CountVertex,Res):-
    replaceOneElement(E-S,[E-S|List],ActualSum,MaxDegreeVertexGraph,Res1),
%    write(Res1),nl,
    filterListsDegree(Res1,Res2),
%    write(Res2),nl,
    sortList(Res2,[Elem-Sum|Tail]),
%    write([Elem-Sum|Tail]),nl,
    CountVertex1 is CountVertex - 1,
    createList(Elem-Sum,[Elem-Sum|Tail],Sum,MaxDegreeVertexGraph,CountVertex1,Res),!.

endCreateList(Res,SumAllDegreeVertexGraph,Res):-Res = [H|_],H \= _-_,!.
endCreateList([E-S|T],SumAllDegreeVertexGraph,Res):-
    EndElem is SumAllDegreeVertexGraph - S,
    append(E,[EndElem],FinalList),
    append(T,[FinalList],NewT),
    endCreateList(NewT,SumAllDegreeVertexGraph,Res).

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

sortList(List,SortedList):-
    createNewList(List,ListWithSum),
    sort_ins(ListWithSum,SortedList).

replaceOneElement(E-S,[E-S|List],S,MaxDegreeVertexGraph,Res):-
    createListChildren(MaxDegreeVertexGraph,E,List1),
    append(List,List1,[H|T]),
    replaceOneElement(H,[H|T],S,MaxDegreeVertexGraph,Res),!.
replaceOneElement(H,Res,_,2,[H|Res]):-!.
replaceOneElement(E-S,[E-S|List],ActualSum,MaxDegreeVertexGraph,Res):-
    MaxDegreeVertexGraph1 is MaxDegreeVertexGraph - 1,
    replaceOneElement(E-S,[E-S|List],S,MaxDegreeVertexGraph1,Res),!.

filterTwoList([],[]):-!.
filterTwoList([H|T],List2):-
    sum_list([H|T],Sum1),
    sum_list(List2,Sum2),
    Sum1 = Sum2,
    delete([H|T],H,NewList1),
    delete(List2,H,NewList2),
    filterTwoList(NewList1,NewList2).

filterListDegree([H1],[H1]):-!.
filterListDegree([H1,H2|T],T1):-
    filterTwoList(H1,H2),
    filterTwoList(H2,H1),
    filterListDegree([H1|T],T1),!.
filterListDegree([H1,H2|T],[H2|T1]):-
    filterListDegree([H1|T],T1),!.

filterListsDegree([],[]):-!.
filterListsDegree([H1],[H1]):-!.
filterListsDegree(List,[H|Res]):-
    filterListDegree(List,FilterH),
    reverse(FilterH,[H|T1]),
    filterListsDegree(T1,Res),!.

member2([],L1):-!.
member2([H|T],L1):-
    member(H,L1),
    member2(T,L1),!.

degreeProv1([],T,T):-!.
degreeProv1([_-N|T],IT1,T1):-
    append(N,IT1,IT2),
    degreeProv1(T,IT2,T1).

degreeProv2([],_,S,S,[]):-!.
degreeProv2([E|T],E,IS,S,Res):-
    IS1 is  IS+1,
    degreeProv2(T,E,IS1,S,Res),!.
degreeProv2([E1|T],E,IS,S,[E1|Res]):-
    degreeProv2(T,E,IS,S,Res),!.

createGraph(X):-
    X = [1-A,2-B,3-C,4-D],
    vertices(X, L),
    length(A,LA),LA=2,
    length(B,LB),LB=2,
    length(C,LC),LC=2,
    length(D,LD),LD=2,
    member2(A,L),
    member2(B,L),
    member2(C,L),
    member2(D,L),
    degreeProv1(X,[],Res1),
    degreeProv2(Res1,1,0,S1,Ress1),S1=2,
    degreeProv2(Ress1,2,0,S2,Ress2),S2=2,
    degreeProv2(Ress2,3,0,S3,Ress3),S3=2,
    degreeProv2(Ress3,4,0,S4,[]),S4=2.












