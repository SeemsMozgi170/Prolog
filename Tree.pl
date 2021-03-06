create_tree(X,tree(X,empty,empty)).
insert_left(X,tree(A,_,B),tree(A,X,B)).
insert_right(X,tree(A,B,_),tree(A,B,X)).

tr:-
    create_tree(5,X),
    create_tree(6,Y),
    insert_right(Y,X,Z),
    write(Z),tree_member(5,Z),
    nl,write('height = '),tree_height(Z,M),write(M),
    nl,write('count_elem = '),col_elem_tree(Z,C),write(C).

tree_member(X,tree(X,_,_)):-!.
tree_member(X,tree(_,L,_)):-
    tree_member(X,L),!.
tree_member(X,tree(_,_,R)):-
    tree_member(X,R).

max(A,B,A):- A>=B,!.
max(_,B,B).

tree_height(empty,0):-!.
tree_height(tree(_,L,R),D):-
    tree_height(L,D1),
    tree_height(R,D2),
    max(D1,D2,M),
    D is M+1.

col_elem_tree(empty,0):-!.
col_elem_tree(tree(_,L,R),D):-
    col_elem_tree(L,D1),
    col_elem_tree(R,D2),
    D is D1 + D2 + 1.

treesort(X,Y):-sort_tree(X,Tree),tree_list(Tree,Y).
sort_tree([],empty):-!.
sort_tree([X|Y],Tree):-
    sort_tree(Y,Tree1),ins(X,Tree1,Tree).

ins(X,empty,tree(X,empty,empty)):-!.
ins(X,tree(Y,L,R),tree(Y,L,R1)):-
    X>=Y,
    ins(X,R,R1),!.
ins(X,tree(Y,L,R),tree(Y,L1,R)):-
    ins(X,L,L1).

tree_list(empty,[]):-!.
tree_list(tree(X,L,R),List):-
    tree_list(L,L1),
    tree_list(R,R1),
    append(L1,[X|R1],List).

countlist(empty,0):-!.
countlist(tree(_,empty,empty),1):-!.
countlist(tree(_,L,R),C):-
    countlist(L,C1),
    countlist(R,C2),
    C is C1 + C2.


countlists(X,Y):-sort_tree(X,Tree),countlist(Tree,Y).
