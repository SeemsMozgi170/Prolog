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
    % 5 �����. ������ ��������������� (�������������� �������, ���������� ��� ��������, ����� �������, ��� ����, ���� ����).
    Houses = [_,_,_,_,_],
    % �������� ���� � ������ ����
    elem_is_n_pos_to_list(1,Houses,[norwegian,_,_,_,_]),
    % ���������� ���� � ������� ����
    member_([englishman,_,_,_,red],Houses),
    % ������ ��� ��������� ����� �� ������, ����� � ���
    isleft([_,_,_,_,green],[_,_,_,_,white],Houses),
    % �������� ���� ���
    member_([dane,_,_,tea,_],Houses),
    % ���, ��� ����� Marlboro, ���� ����� � ���, ��� ���������� �����
    near([_,_,marlboro,_,_],[_,cat,_,_,_],Houses),
    % ���, ��� ���� � ����� ����, ����� Dunhill
    member_([_,_,dunhill,_,yellow],Houses),
    % ����� ����� Rothmans
    member_([german,_,rothmans,_,_],Houses),
    % ���, ��� ���� � ������, ���� ������
    elem_is_n_pos_to_list(3,Houses,[_,_,_,milk,_]),
    % ����� ����, ��� ����� Marlboro, ���� ����
    near([_,_,marlboro,_,_],[_,_,_,water,_],Houses),
    % ���, ��� ����� Pall Mall, ���������� ����
    member_([_,bird,pallmall,_,_],Houses),
    % ���� ���������� �����
    member_([swede,dog,_,_,_],Houses),
    % �������� ���� ����� � ����� �����
    near([norwegian,_,_,_,_],[_,_,_,_,blue],Houses),
    % ���, ��� ���������� �������, ���� � ����� ����
    member_([_,horse,_,_,blue],Houses),
    % ���, ��� ����� Winfield, ���� ����
    member_([_,_,winfield,beer,_],Houses),
    % � ������ ���� ���� ����
    member_([_,_,_,coffee,green],Houses),
    % ����, ��� �������� �����(��������������).
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
