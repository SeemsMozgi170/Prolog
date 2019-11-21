divisor(A,Result):-
    div_routine(A,1,[],Result).

div_routine(A,N,IntermediateList,Result):-
    % ������ �������� �����
    A/N < 2,
    % ������������ � ������ ��������� ���� ��� ����� � ������
    append(IntermediateList,[A],Result),!.

div_routine(A,N,IntermediateList,Result):-
    % ��������� mod
    AmodN is A mod N,
    % �������� �� ���������?
    AmodN = 0,
    % ���� ��, ������������ ��������������� ������ ����� N � ������ ���������
    append(IntermediateList,[N],IntermediateListPlusN),
    % ���� � ���������� �����
    N2 is N + 1,
    % ���� ������
    div_routine(A,N2,IntermediateListPlusN,Result),!.

div_routine(A,N,IntermediateList,Result):-
    % ���� �� ��������, �� ������ ��������� � ���������� �����
    N2 is N + 1,
    % � ���� ������
    div_routine(A,N2,IntermediateList,Result),!.

solution(X,R):-solution(X,[],R).
solution([],Result1,Result):-list_to_set(Result1,Result),!.
solution([H|T],Result1,Result):-
    divisor(H,ListDivisorH),
    append(Result1,ListDivisorH,Result2),
    solution(T,Result2,Result).






