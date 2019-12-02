createNeedList(0,_,[]):-!.
createNeedList(X,ParentX,[ParentX-H|T]):-
    append(ParentX,[X],H),
    X1 is X-1,
    createNeedList(X1,ParentX,T).

insert(AE-E,[],[AE-E]):-!.
insert(AE-E,[AH-H|T],[AE-E,AH-H|T]):- E<H,!.
insert(AE-E,[AH-H|T],[AH-H|T1]):-
    insert(AE-E,T,T1).

sort_ins(L,SortL):-sort_ins(L,[],SortL).
sort_ins([],SortL,SortL):-!.
sort_ins([AH-H|T],SortPart,SortL):-
    insert(AH-H,SortPart,SortPart1),
    sort_ins(T,SortPart1,SortL).

createNewList([],[]):-!.
createNewList([H|T],[H-SumH|T1]):-
    sum_list(H,SumH),
    createNewList(T,T1).

returnOldList([],[]):-!.
returnOldList([_-H|T],[H|T1]):-
    returnOldList(T,T1).

sortList(List,SortedList):-
    createNewList(List,ListWithSum),
    sort_ins(ListWithSum,SortedList).

createBranches(G,[],_,1,G):-!.
createBranches(G,[V-S|T],Sum,Max,ResG):-
    write(Max),nl,
    S = Sum,
    createNeedList(Max,V,List1),
    add_edges(G,List1,G1),
    createBranches(G1,T,Sum,Max,ResG).

createBranches(G,[V-S|T],_,Max,ResG):-
    Max1 is Max - 1,
    createBranches(G,[V-S|T],S,Max1,ResG).

getTreeLeave(_,[],[]):-!.
getTreeLeave(G,[HeadListAllVertexG|TailListAllVertexG],[HeadListAllVertexG|TailResList]):-
    neighbours(HeadListAllVertexG,G,NeighboursHeadListAllVertexG),
    NeighboursHeadListAllVertexG = [],
    getTreeLeave(G,TailListAllVertexG,TailResList),!.
getTreeLeave(G,[_|TailListAllVertexG],ResList):-
    getTreeLeave(G,TailListAllVertexG,ResList),!.

endCreateTree(G,[],_,LeaveResG):-
    vertices(G,ListAllVertexG),
    getTreeLeave(G,ListAllVertexG,LeaveResG),!.
endCreateTree(G,[HeadListVertex|TailListVertex],SumDegreeVertex,LeaveResG):-
    sum_list(HeadListVertex,SumHeadListVertex),
    NeedDegree is SumDegreeVertex - SumHeadListVertex,
    append(HeadListVertex,[NeedDegree],NeedLeave),
    add_edges(G,[HeadListVertex-NeedLeave],G1),
    endCreateTree(G1,TailListVertex,SumDegreeVertex,LeaveResG).

inputData(FilteredListDegreeAllGraph):-
    write('Количество вершин = '),read(CountVertex),
    write('Количество ребер = '),read(CountEdge),
    SumDegreeVertex is CountEdge*2,
    MaxDegreeVertex is SumDegreeVertex-CountVertex+1,
    beginCreateTree([],MaxDegreeVertex,CountVertex,SumDegreeVertex,ListDegreeAllGraph),
    filterListsDegree(ListDegreeAllGraph,FilteredListDegreeAllGraph),
    createGraphs(FilteredListDegreeAllGraph).

beginCreateTree(G,MaxDegreeVertex,CountVertex,SumDegreeVertex,ListDegreeAllGraph):-
    createNeedList(MaxDegreeVertex,[],L),
    vertices_edges_to_ugraph(G,L,G1),
    DecCountVertex is CountVertex - 1,
    returnOldList(L,NewListVertex),
    middleCreateTree(G1,DecCountVertex,NewListVertex,MaxDegreeVertex,SumDegreeVertex,ListDegreeAllGraph).

middleCreateTree(G,1,_,_,SumDegreeVertex,ListDegreeAllGraph):-
    vertices(G,ListVertexG),
    getTreeLeave(G,ListVertexG,LeaveG),
    endCreateTree(G,LeaveG,SumDegreeVertex,ListDegreeAllGraph),!.
middleCreateTree(G,Rest,ListVertex,MaxDegreeVertex,SumDegreeVertex,ListDegreeAllGraph):-
    sortList(ListVertex,[V-S|T]),
    createBranches(G,[V-S|T],S,MaxDegreeVertex,ResG),
    write([V-S|T]),nl,
    write(Rest),nl,
    Rest1 is Rest - 1,
    vertices(ResG,ListVertexResG),
    getTreeLeave(ResG,ListVertexResG,AllLeaveG),
    middleCreateTree(ResG,Rest1,AllLeaveG,MaxDegreeVertex,SumDegreeVertex,ListDegreeAllGraph),!.

max([X],X):-!.
max([I-Head|Tail],I-Head):-max(Tail,_-MaxInTail1),Head>MaxInTail1,!.
max([_|Tail],I-MaxInTail):-max(Tail,I-MaxInTail).

min([X],X):-!.
min([I-Head|Tail],I-Head):-min(Tail,_-MinInTail1),Head=<MinInTail1,!.
min([_|Tail],I-MinInTail):-min(Tail,I-MinInTail).

changeElem([I-H11],_,[I-H1]):- H1 is H11-1,!.
changeElem([I-H|T],I-H,[I-H1|T]):- H1 is H-1,!.
changeElem([I-H|T],I1-X,[I-H|R]):- changeElem(T,I1-X,R).

createListWithIndex([],_,[]):-!.
createListWithIndex([H|T],I,[I-H|ResList]):-
    I1 is I + 1,
    createListWithIndex(T,I1,ResList).


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

createOneGraph([],G,G):-!.
createOneGraph(List,IG,G):-
    max(List,IMax-MaxList),
    min(List,IMin-MinList),
    add_edges(IG,[IMax-IMin,IMin-IMax],IG1),
    changeElem(List,IMax-MaxList,ResList1),
    changeElem(ResList1,IMin-MinList,ResList),
    delete(ResList,_-0,CleanResList),
    createOneGraph(CleanResList,IG1,G).

createGraphs([]):-!.
createGraphs([H|T]):-
    createListWithIndex(H,1,NewH),
    createOneGraph(NewH,[],G),write(G),nl,
    createGraphs(T),!.

countKS(G,Count):-
    transitive_closure(G,G1).

isBlock(G,[H|T]):-
    del_vertices(G,[H],G1).











