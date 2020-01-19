:-dynamic bf1/2.
:-dynamic och/1.
:-dynamic bf2/1.

likes(i,apple).
likes(i,pizza).
likes(mom,fruits).
likes(mom,games).
likes(dad,tv).
likes(dad,bed).

nolikes(i,exams).

insert:-
    assertz(bf1(i,apple)),
    assertz(bf1(i,pizza)),
    assertz(bf1(mom,fruits)),
    assertz(bf1(mom,games)),
    assertz(bf1(dad,tv)),
    assertz(bf1(dad,bed)).

outf(L,L1):-
    bf1(P,P1),
    append(L,[P,P1],L1),
    fail.

search(X,P,L):-retractall(och(_)),s(X,P),to_list(L).

to_list([X|Tail]):-och(X),!,retract(och(X)),to_list(Tail).
to_list([]).

s(X,P):-P,assert(och(X)),fail.
s(_,_).

insert_:-
    likes(P1,P2),
    assertz(bf1(P1,P2)),fail.
insert_.

insert2_:-
    assert(bf2(likes(i,pizza))),
    assert(bf2(nolikes(i,exams))).










