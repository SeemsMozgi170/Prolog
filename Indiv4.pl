% ��������� ����������(������� ���������� ����, � ������� ����������� ��� �����)
analyzeLists([],L,C,R):-length(L,LL),R is C + LL,!.
analyzeLists(L,[],C,R):-length(L,LL),R is C + LL,!.
analyzeLists([H|T],L,C,R):-
    % ���� ������ ���� � ����� ������, �� �� ���������� � ������� ��� �� �������� ������� �����
    member(H,L),
    % ������� ��� �� �������� ������� �����
    delete(L,H,L1),
    % ���� ������
    analyzeLists(T,L1,C,R),!.
analyzeLists([_|T],L,C,R):-
    % ���� ��� ��� � ������ �������� ������� �����, �� +1
    C1 is C + 1,
    % ���� ������
    analyzeLists(T,L,C1,R).
%====������� ���������� ����� 2�� �������================
distance(WordA,WordB,Distance):-
    % �������� �� �����
    string_length(WordA,LengthA),
    string_length(WordB,LengthB),
    % ����� ��������, ���� �� ����� �����
    LengthA = LengthB,
    % �������� ������ ��� ���������� ������� �����
    string_chars(WordA,ListCharsWordA),
    list_to_set(ListCharsWordA,SetCharsWordA),
    string_chars(WordB,ListCharsWordB),
    list_to_set(ListCharsWordB,SetCharsWordB),
    % ��������� ����������(������� ���������� ����, � ������� ����������� ��� �����)
    analyzeLists(SetCharsWordA,SetCharsWordB,0,Distance).
%=======������ �� ����� � ��������� ������ ����===========
readfile(T,R,L):-
    get0(X),
    (X<0,(T=[],L = R;
    name(T1,T),append(R,[T1],L)),!;
    (X=32;X=10;X=13),
    (T=[],readfile(T,R,L);name(T1,T),
     append(R,[T1],R1),readfile([],R1,L)),!;
    X>0,append(T,[X],T1),readfile(T1,R,L),!).

filetolist(F,L):-seen,see(F),readfile([],[],L),seen.
%=========================================================
%=============������� ���������� ����� ������� ������===========
findDistance([],[]):-!.
findDistance([Head|Tail],ResultListDistance):-
    % ������� ���������� ����� ��������������� ��������� � ����� ���������� ����� �� �����������
    findDistance(Head,[Head|Tail],[],ListDistanceWithHead),
    % ����������� � ���� ��������� (��������� ������ ��������� ���������� � ���)
    %������ ������ ��� ��� ��������� ������ ������.
    findDistance(Tail,ListDistanceBetweenElementsTail),
    % ��������� ������ � ������������ ��������� ������(������������ ����� ��������) �
    % ������ ���������� � �������(� ������ ������) � �������������� ������
    append(ListDistanceWithHead,ListDistanceBetweenElementsTail,ResultListDistance).
% ==����� ������� ���������� ������� �������� ������ � ������� ������===
findDistance(_,[],ListDistanceWithE,ListDistanceWithE):-!.
findDistance(Elem,[Head|Tail],IntermediateListDistanceWithE,ListDistanceWithE):-
    % ������� ���������� ����� 2�� ���������� � ������������� ������ ������������� ����������
    distance(Elem,Head,DistanceBetweenElemAndHead),DistanceBetweenElemAndHead>0,
    % ������������ ���������� ���������� � �������� ��� ��� ��������� ������ � ������ ���������� � ��������� E
    append(IntermediateListDistanceWithE,[[Elem,Head,DistanceBetweenElemAndHead]],L1),
    % ���� ������
    findDistance(Elem,Tail,L1,ListDistanceWithE),!.
findDistance(E,[_|T],IL,L):-
    %���� ���������� ���(����� ���� ������) ��� ���������� = 0, �� ���� ������
    findDistance(E,T,IL,L),!.
%===================================================================
max([[_,_,N]],N):-!.
max([[_,_,H3]|T],H3):- max(T,M2),H3>M2.
max([_|T],M2):- max(T,M2),!.

findMax([],_,LM,LM):-!.
findMax([H|T],M,ILM,LM):-
    H = [_,_,M],
    append(ILM,[H],ILM2),
    findMax(T,M,ILM2,LM),!.
findMax([H|T],M,ILM,LM):-
    findMax(T,M,ILM,LM),!.

writeInFile([]):-!.
writeInFile([[A,B,_]|T]):-
    write(A),
    write('\t'),
    write(B),
    write('\n\n'),
    writeInFile(T).

insertInFile(X):-
    seen,
    tell('C:/Users/Ibrag/Desktop/Knoledge_base/Programms_Prolog/Indiv4/out.txt'),
    writeInFile(X),
    told,seen.
%===========�������� �������==============================
solution:-
    % ������� ���� ���� �� �����
    filetolist('C:/Users/Ibrag/Desktop/Knoledge_base/Programms_Prolog/Indiv4/in.txt',ListWordsFromFile),
    % ������ ��������� ����� ������� � ��������� ������ ��������� ���� [�����1, �����2, ���������� ����� ����]
    findDistance(ListWordsFromFile,ListDistance),
    % ���������� ������������� ���������� ����� �������
    max(ListDistance,MaxDistanceBetweenWords),
    % �������� ����� ���� �� ��������� � ������������ ����������� ������ �� ����
    findMax(ListDistance,MaxDistanceBetweenWords,[],ListElementsWithMaxDistance),
    (% ���� ����� ������� 1, �� ������� ��� �� �������
     length(ListElementsWithMaxDistance,LengthListElementsWithMaxDistance),
        LengthListElementsWithMaxDistance =< 1,write(ListElementsWithMaxDistance),!;
     % �����, ������ ����� ���� � ���� (������ ������ � �������)
     write('�� ������ ������'), insertInFile(ListElementsWithMaxDistance)).
%=========================================================

















