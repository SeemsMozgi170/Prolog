member_(X,[X|_]).
member_(X,[_|Z]):-member_(X,Z).

elem_is_n_pos_to_list(1,[Elem|_],Elem).
elem_is_n_pos_to_list(N,[_|T],Elem):-
    N > 1,
    K is N-1,
    elem_is_n_pos_to_list(K,T,Elem).

isleft(X,Y,[X,Y|_]).
isleft(X,Y,[_|T]):-isleft(X,Y,T).

near(X,Y,List):-
    isleft(X,Y,List).
near(X,Y,List):-
    isleft(Y,X,List).

einstein(Owner):-
    % 5 домов. Каждый характеризуется (национальность хозяина, разводимые там животные, марка сигарет, что пьет, цвет дома).
    Houses = [_,_,_,_,_],
    % Норвежец живёт в первом доме
    elem_is_n_pos_to_list(1,Houses,[norwegian,_,_,_,_]),
    % Англичанин живёт в красном доме
    member_([englishman,_,_,_,red],Houses),
    % Зелёный дом находится слева от белого, рядом с ним
    isleft([_,_,_,_,green],[_,_,_,_,white],Houses),
    % Датчанин пьёт чай
    member_([dane,_,_,tea,_],Houses),
    % Тот, кто курит Marlboro, живёт рядом с тем, кто выращивает кошек
    near([_,_,marlboro,_,_],[_,cat,_,_,_],Houses),
    % Тот, кто живёт в жёлтом доме, курит Dunhill
    member_([_,_,dunhill,_,yellow],Houses),
    % Немец курит Rothmans
    member_([german,_,rothmans,_,_],Houses),
    % Тот, кто живёт в центре, пьёт молоко
    elem_is_n_pos_to_list(3,Houses,[_,_,_,milk,_]),
    % Сосед того, кто курит Marlboro, пьёт воду
    near([_,_,marlboro,_,_],[_,_,_,water,_],Houses),
    % Тот, кто курит Pall Mall, выращивает птиц
    member_([_,bird,pallmall,_,_],Houses),
    % Швед выращивает собак
    member_([swede,dog,_,_,_],Houses),
    % Норвежец живёт рядом с синим домом
    near([norwegian,_,_,_,_],[_,_,_,_,blue],Houses),
    % Тот, кто выращивает лошадей, живёт в синем доме
    member_([_,horse,_,_,blue],Houses),
    % Тот, кто курит Winfield, пьет пиво
    member_([_,_,winfield,beer,_],Houses),
    % В зелёном доме пьют кофе
    member_([_,_,_,coffee,green],Houses),
    % Ищем, кто разводит рыбок(национальность).
    member_([Owner,fish,_,_,_],Houses).


mod_(X,Y,R):-
   R1 is X mod Y,
   R = R1.

del(X,[X|T]):-
    E is X div 2,
    del(X,T,1).
del(X,_,E):-
    E = X div 2,!.
del(X,[I|T],I):-
    mod_(X,I,0),
    I1 is I+1,
    print([I,T]),
    del(X,T,I1).
