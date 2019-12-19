edge(1,2).
edge(2,3).
edge(2,4).
edge(3,5).
edge(4,5).
edge(4,6).
edge(5,6).
edge(5,7).
diam(N):-
    findall(V,(edge(V,_);edge(_,V)),T),
    findall(P,(member(A,T),member(B,T),A\=B,findminpath(A,B,P)),L),
    maxpath(L,N).

findminpath(A,B,P):-
    findall(X,findpath(A,B,X),L),minpath(L,P),!.
findpath(A,B,P):-
    findpath(A,B,[A],P).

findpath(A,A,P,P).
findpath(A,B,T,P):-
    (edge(A,Z);edge(Z,A)),
    not(member(Z,T)),findpath(Z,B,[Z|T],P).
minpath([A],A):-!.
minpath([H|T],P):-
    minpath(T,P1),!,length(H,N),length(P1,M),
    (N<M,P=H;P=P1).
maxpath([A],A):-!.
maxpath([H|T],P):-
    maxpath(T,P1),!,length(H,N),length(P1,M),
    (N>M,P=H;P=P1).

