parent(tom,ann). % tom - parent, ann-child tom
parent(tom,mike).
parent(mary,mike).
parent(mike,sue).
parent(mike,john).
parent(mike,nick).
parent(john,jane).
parent(sue,bob).
parent(sue,mark).
parent(john,jim). % , - коньюнкция
parent(john,kate).
parent(jerry,micky).

husband(micky,ann).
husband(sam,jane).
husband(robby,kate).

man(tom).
man(mike).
man(john).
man(nick).
man(jim).

woman(mary).
woman(ann).
woman(sue).
woman(jane).

grandchild(X,Y):-
    parent(Z,X),
    parent(Y,Z).
haschild(X):-parent(X,_).
sister(X,Y):-
    woman(X),
    parent(Z,X),parent(Z,Y),
    dif(X,Y).
%ancestor(X,Y):-parent(X,Y).
%ancestor(X,Y):-parent(Z,Y),ancestor(X,Z).
ancestor(X,Y):-parent(X,Y).%дно рекурсии
ancestor(X,Y):-parent(X,Z),ancestor(Z,Y).

patriarch(X):-parent(X,_),not(parent(_,X)).

cousin(X,Y):-
    parent(Z,X),parent(W,Y),
    dif(Z,W),
    parent(O,Z),parent(O,W),
    dif(X,Y).
relative(X,Y):-
    ancestor(Z,X),
    ancestor(Z,Y).
married_on_sisters(X,Y):-
    husband(X,A),
    husband(Y,B),
    sister(A,B).













