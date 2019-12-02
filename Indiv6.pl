inputBridge(R,R,MS,MS):-!.
inputBridge(IR,R,IMS,MS):-
    write('A-B = '),read(A-B),nl,
    add_edges(IMS,[A-B],IMS2),
    add_edges(IMS2,[B-A],IMS3),
    IR1 is IR + 1,
    inputBridge(IR1,R,IMS3,MS).

cutVerteces([],ResLV,ResLV):-!.
cutVerteces([H|T],FromLV,ResLV):-
    delete(FromLV,H,Res1),
    cutVerteces(T,Res1,ResLV).

analyze(MS,[H|T],Res):-
    neighbours(H,MS,NeighboursH),
    cutVerteces(NeighboursH,T,Res),
    Res = [].
analyze(MS,[H|T],Res):-
    neighbours(H,MS,NeighboursH),
    cutVerteces(NeighboursH,T,ResLV2),
    analyze(MS,NeighboursH,ResLV2,Res).

analyze(MS,[],R,R):-!.
analyze(MS,[H|T],LV,R):-
    neighbours(H,MS,NeighboursH),
    cutVerteces(NeighboursH,LV,LV2),
    (LV2 = [];analyze(MS,T,LV2,R1)),
    (R1 = [];analyze(MS,NeighboursH,R1,R)).

findVertecesSochl(_,[],Res,Res):-!.
findVertecesSochl(MS,[H|T],R,Res):-
    del_vertices(MS,[H],MS2),
    analyze(MS2,T,R2),
    write(R2),
    R2 = [],
    append(R,[H],R1),
    findVertecesSochl(MS,T,R1,Res).
findVertecesSochl(MS,[_|T],R,Res):-
    findVertecesSochl(MS,T,R,Res).

mergeLists([],L2,[]):-!.
mergeLists([H|T],L2,[NH|T1]):-
    neighbours(H,L2,NH),
    mergeLists(T,L2,T1).


inputGraph(MS):-
    write('���������� ����� = '),read(CountR),nl,
    inputBridge(0,CountR,[],MS),
    write(MS),
    transitive_closure(MS,L),
    vertices(MS,VS),
    mergeLists(VS,L,R),
    write(R).
%    findVertecesSochl(MS,VS,[],VertexSochl),
%    write(VertexSochl).


















