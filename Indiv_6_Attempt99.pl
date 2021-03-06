getGraph([HeadMatrix|TailMatrix],Graph):-
    length(HeadMatrix,Count),
    byPassMatrix([HeadMatrix|TailMatrix],Count,1,[],Graph).

byPassMatrix([],_,_,ResultGraph,ResultGraph):-!.
byPassMatrix([Head|Tail],Count,NumberRow,IGraph,ResultGraph):-
    byPassColumnMatrix(Head,Count,NumberRow,1,IGraph,IGraph1),
    NumberRow1 is NumberRow + 1,
    byPassMatrix(Tail,Count,NumberRow1,IGraph1,ResultGraph),!.

byPassColumnMatrix([],_,_,_,Graph,Graph):-!.
byPassColumnMatrix([H|T],Count,NumberRow,NumberColumn,IGraph,Graph):-
    NumberColumn > NumberRow,
    H = 1,
    add_edges(IGraph,[NumberRow-NumberColumn,NumberColumn-NumberRow],IGraph1),
    NumberColumn1 is NumberColumn + 1,
    byPassColumnMatrix(T,Count,NumberRow,NumberColumn1,IGraph1,Graph),!.
byPassColumnMatrix([_|T],Count,NumberRow,NumberColumn,IGraph,Graph):-
    NumberColumn1 is NumberColumn + 1,
    byPassColumnMatrix(T,Count,NumberRow,NumberColumn1,IGraph,Graph),!.


analyseNeighbours([],ListNeighbours,CountComponent):-
    list_to_set(ListNeighbours,ListNeighbours1),
    length(ListNeighbours1,CountComponent).
analyseNeighbours([_-LN|T],ListNeighbours,CountComponent):-
    append(ListNeighbours,[LN],ListNeighbours1),
    analyseNeighbours(T,ListNeighbours1,CountComponent).

analyseGraph(Matrix):-
    getGraph(Matrix,Graph),
    transitive_closure(Graph,Graph1),
    findall(A,(member(A-B,Graph),length(B,LB),LB=<1),R),length(R,LR),LR=0,
    analyseNeighbours(Graph1,[],CountComponent),
    CountComponent = 1,
    vertices(Graph,VGraph),
    analyseBlock(Graph,VGraph).
analyseGraph(_):-true.

/*
analyseBlock(Graph,R):-findall(A/B,(member(A-L,Graph),
           member(B-L,Graph)),X),clear(X,Y),
           candel(Graph,Y,R).
candel(_,[],[]):-!.
candel(Graph,[A/B|T],P):-candel(Graph,T,P1),!,(mydel(Graph,A/B),
                   P=[A/B|P1];P=P1).
mydel(Graph,A/B):-
    findall(L,member(L-_,Graph),[H|T]),
    findall(G,(member(G,T),pathr(Graph,A/B,H,G,[H],_)),M),
    setof(Z,member(Z,M),M1),
    length(T,S1),
    length(M1,S2),
    S1\=S2.
pathr(_,_,X,X,P,P).
pathr(Graph,X/Y,A,B,T,R):-member(A-L,Graph),
    member(Z,L),
    not(member(Z,T)),
    A/Z\=X/Y,A/Z\=Y/X,
    pathr(X/Y,Z,B,[Z|T],R).

clear([],[]):-!.
clear([X/Y|T],R):-clear(T,R1),
    ((member(X/Y,R1);member(Y/X,R1)),
      R=R1;
    R=[X/Y|R1]),!.
*/

analyseBlock(Graph,[]):-write(Graph),!.
analyseBlock(Graph,[H|T]):-
    transitive_closure(Graph,TrClGraph),
    analyseNeighbours(TrClGraph,[],CountComponentBefore),
    del_vertices(Graph,[H],Graph1),
    transitive_closure(Graph1,TrClGraph1),
    analyseNeighbours(TrClGraph1,[],CountComponentAfter),
    CountComponentBefore = CountComponentAfter,
    analyseBlock(Graph,T).










