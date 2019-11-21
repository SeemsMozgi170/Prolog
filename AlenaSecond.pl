kindsOfBook(bookAstronomy).
kindsOfBook(bookDramaturg).
kindsOfBook(bookProzaic).
kindsOfBook(bookPoet).

% проверка на то, что в векторе нет повторяющихся элементов
unique([]):-!.
unique([Head|Tail]):-
    member(Head, Tail),!,fail;
    unique(Tail).

% проверка на то, что каждый не читает свою книгу
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

% каждый написал книгу
      kindsOfBook(AlekseevWrite),
      kindsOfBook(BorisovWrite),
      kindsOfBook(KonstantinovWrite),
      kindsOfBook(DmitrievWrite),
      unique([AlekseevWrite,BorisovWrite,KonstantinovWrite,DmitrievWrite]),

% каждый купил книгу
      kindsOfBook(AlekseevBuy),
      kindsOfBook(BorisovBuy),
      kindsOfBook(KonstantinovBuy),
      kindsOfBook(DmitrievBuy),
      unique([AlekseevBuy,BorisovBuy,KonstantinovBuy,DmitrievBuy]),

% каждый читает книгу
      kindsOfBook(AlekseevRead),
      kindsOfBook(BorisovRead),
      kindsOfBook(KonstantinovRead),
      kindsOfBook(DmitrievRead),
      unique([AlekseevRead,BorisovRead,KonstantinovRead,DmitrievRead]),

% никто не читает и не покупал свою книгу
      check(Info),

% поэт читает пьесу
      member([_,bookPoet,_,bookDramaturg],Info),

% прозаик читает не астрономию
      not(member([_,bookProzaic,_,bookAstronomy],Info)),

% прозаик не покупал астрономию
      not(member([_,bookProzaic,bookAstronomy,_],Info)),

% алексеев и борисов обменялись книгами
      member([alekseev,_,AlekseevBuy,BorisovBuy],Info),
      member([borisov,_,BorisovBuy,AlekseevBuy],Info),

% Борисов купил произведение Дмитриева
      member([dmitriev,DmitrievWrite,_,_],Info),
      member([borisov,_,DmitrievWrite,_],Info).





































