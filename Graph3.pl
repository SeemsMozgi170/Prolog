findbr(R):-
    findall(A/B,
           (childrean(A,L),
           member(B,L)),X),
    clear(X,Y),candel(Y,R).

candel([],[]):-!.
candel([A/B|T],P):-
    candel(T,P1),!,
    (mydel(A/B), P=[A/B|P1]; P=P1).

mydel(A/B):-
    findall(L,children(L,_),[H|T]),
    findall(G,(member(G,T),pathr))
