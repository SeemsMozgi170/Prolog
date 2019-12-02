p(1,2,1).
p(1,3,2).
p(2,4,1).
p(3,4,2).
p(4,5,3).


find_all(X,G,Bag):-
    post_it(X,G),
    gather([],Bag).

post_it(X,G):-
    call(G),
    asserta(data999(X)),fail.

post_it(_,_).

gather(B,Bag):-
    data999(X),
    retract(data999(X)),
    gather([X|B],Bag),!.
gather(B,B).

search(X,Y,[X,Y]):-
    p(X,Y,_);p(Y,X,_),!.

search(X,Y,[X|T]):-
    (p(X,Z,_);p(Z,X,_)),
    search(Z,Y,T),
    not(member(X,T)),!.
%search(X,Y,T):-
%    (p(X,Z,_);p(Z,X,_)),
%    search(Z,Y,T).

max([[X,Y]],[X,Y]):-!.
max([[Head1,Head2]|Tail],[Head1,Head2]):-max(Tail,[MaxInTail1,_]),Head1>MaxInTail1,!.
max([_|Tail],MaxInTail):-max(Tail,MaxInTail).

maxDegreeVertex(Result):-
    find_all(From,p(From,To,Length),ListVertexFrom),
    find_all(To,p(From,To,Length),ListVertexTo),
    append(ListVertexFrom,ListVertexTo,ListVertexWithoutFiltered),
    list_to_set(ListVertexWithoutFiltered,ListVertex),
    write('Вершины : '),write(ListVertex),nl,
    getListDegreeVertex(ListVertex,[],ListDegreeVertex),
    write('Степени всех вершин [Степень,Вершина] : '),write(ListDegreeVertex),nl,
    max(ListDegreeVertex,Result).

getListDegreeVertex([],IntermediateResult,Result):-reverse(IntermediateResult,Result),!.
getListDegreeVertex([Head|Tail],IntermediateResult,Result):-
    find_all(Head,(p(Head,_,_);p(_,Head,_)),ListDegreeThisVertex),
    length(ListDegreeThisVertex,DegreeThisVertex),
    append([[DegreeThisVertex,Head]],IntermediateResult,IntermediateListDegreeVertex),
    getListDegreeVertex(Tail,IntermediateListDegreeVertex,Result),!.
getListDegreeVertex([_|T],IntermediateResult,Result):-
    getListDegreeVertex(T,IntermediateResult,Result),!.











