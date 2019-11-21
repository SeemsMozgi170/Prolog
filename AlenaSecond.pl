kindsOfBook(bookAstronomy).
kindsOfBook(bookDramaturg).
kindsOfBook(bookProzaic).
kindsOfBook(bookPoet).

% �������� �� ��, ��� � ������� ��� ������������� ���������
unique([]):-!.
unique([Head|Tail]):-
    member(Head, Tail),!,fail;
    unique(Tail).

% �������� �� ��, ��� ������ �� ������ ���� �����
check([]):-!.
check([[_,PassengerXWrite,PassengerXBuy,PassengerXRead]|T]):-
    not(PassengerXRead = PassengerXWrite),
    not(PassengerXBuy = PassengerXWrite),
    check(T).

solution(Info):-
    Info = [[alekseev,AlekseevWrite,AlekseevBuy,AlekseevRead],
             [borisov,BorisovWrite,BorisovBuy,BorisovRead],
             [konstantinov,KonstantinovWrite,KonstantinovBuy,KonstantinovRead],
             [dmitriev,DmitrievWrite,DmitrievBuy,DmitrievRead]],

% ������ ������� �����
      kindsOfBook(AlekseevWrite),
      kindsOfBook(BorisovWrite),
      kindsOfBook(KonstantinovWrite),
      kindsOfBook(DmitrievWrite),
      unique([AlekseevWrite,BorisovWrite,KonstantinovWrite,DmitrievWrite]),

% ������ ����� �����
      kindsOfBook(AlekseevBuy),
      kindsOfBook(BorisovBuy),
      kindsOfBook(KonstantinovBuy),
      kindsOfBook(DmitrievBuy),
      unique([AlekseevBuy,BorisovBuy,KonstantinovBuy,DmitrievBuy]),

% ������ ������ �����
      kindsOfBook(AlekseevRead),
      kindsOfBook(BorisovRead),
      kindsOfBook(KonstantinovRead),
      kindsOfBook(DmitrievRead),
      unique([AlekseevRead,BorisovRead,KonstantinovRead,DmitrievRead]),

% ����� �� ������ � �� ������� ���� �����
      check(Info),

% ���� ������ �����
      member([_,bookPoet,_,bookDramaturg],Info),

% ������� ������ �� ����������
      not(member([_,bookProzaic,_,bookAstronomy],Info)),

% ������� �� ������� ����������
      not(member([_,bookProzaic,bookAstronomy,_],Info)),

% �������� � ������� ���������� �������
      member([alekseev,_,AlekseevBuy,BorisovBuy],Info),
      member([borisov,_,BorisovBuy,AlekseevBuy],Info),

% ������� ����� ������������ ���������
      member([dmitriev,DmitrievWrite,_,_],Info),
      member([borisov,_,DmitrievWrite,_],Info).





































