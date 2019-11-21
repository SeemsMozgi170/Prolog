solution(List,L1,L2):-
    % �������� ���� L1
    list_to_set(List,L1),
    % �������� ���� L2
    getL2(List,L2).

% �������� ���� L2
getL2([],[]):-!.
getL2([Head|Tail],[CountHead|ListStatisticElementsWithoutCountHead]):-
    % ������� ���������� ������� �������� � �������� ���� ��� ����� ��������
    count(Head,[Head|Tail],ListWithoutHead,CountHead),
    % ���� ������
    getL2(ListWithoutHead,ListStatisticElementsWithoutCountHead).

% ������� ���������� ������� �������� � �������� ���� ��� ����� ��������
count(X,List,ListWithoutX,CountX):-
    % ��������������� �������
    count(X,List,ListWithoutX,0,CountX),!.
count(_,[],[],CountX,CountX):-!.
count(X,[X|Tail],ListWithoutX,IntermediateCountX,CountX):-!,
    % ���� ���� ������� = ������, �� +1
    IntermediateCountXInc is IntermediateCountX + 1,
    % ���� ������ ������ � ������
    count(X,Tail,ListWithoutX,IntermediateCountXInc,CountX),!.
count(X,[Head|Tail],[Head|NewTail],IntermediateCountXInc,CountX):-
    % ���� ���� ������� ��= ������, �� ��������� ��������������� ������� � �������������� ������
    count(X,Tail,NewTail,IntermediateCountXInc,CountX).