:-dynamic films/5.
:-dynamic author/3.
:-dynamic country/3.

checkingAll(IdFilm,_,_):-
    films(IdFilm,_,_,_,_),
    write("������!))) ���������� ��������������� ���������� �����").
checkingAll(_,IdAuthor,_):-
    not(author(IdAuthor,_,_)),
    write("��� �� ������ ��������� ��� � �������. ������� ������ ��� ����.").
checkingAll(_,_,IdCountry):-
    not(country(IdCountry,_,_)),
    write("����� ������ ��� � �������.").

deleteAllFilm(A,B,C,D,E):- retractall(films(A,B,C,D,E)).
deleteAllAuthor(A,B,C):- retractall(author(A,B,C)).
deleteAllCountry(A,B,C):- retractall(country(A,B,C)).

selectAllAuthor(A,B,C):- author(A,B,C).
selectAllCountry(A,B,C):- country(A,B,C).

selectAllFilm(A,B,C,D,E):-
    A=_,
    findall([A,B,C],films(A,B,C,D,E),Res1),
    findall([D,E],films(A,B,C,D,E),Res11),
    findall([A2,B2],(member([D,_],Res11),author(D,A2,B2)),Res2),
    findall([A3,B3],(country(E,A3,B3),member([_,E],Res11)),Res3),
    outInfo(Res1,Res2,Res3),!.

selectAllFilm(A,B,C,D,E):-
    findall([A,B,C,D,E],films(A,B,C,D,E),[[A1,B1,C1,D1,E1]]),
    findall([A2,B2],author(D1,A2,B2),Res2),
    findall([A3,B3],country(E1,A3,B3),Res3),
    outInfo([[A1,B1,C1]],Res2,Res3).

outInfo([],[],[]):-!.
outInfo([H1|T1],[H2|T2],[H3|T3]):-
    append(H1,H2,H1H2),
    append(H1H2,H3,[A,B,C,D,E,F,G]),
    write("==============================="),nl,
    write("�� ������ : "),write(A),nl,
    write("1 - �������� ������ : "),write(B),nl,
    write("2 - ��� ������ �� ������ : "),write(C),nl,
    write("3 - �������� : "),write(D),nl,
    write("4 - ��� �������� ��������� : "),write(E),nl,
    write("5 - ������-������������� : "),write(F),nl,
    write("6 - ������ ���� ������ : "),write(G),nl,
    outInfo(T1,T2,T3).

insertFilm:-
    write("�� ������ : "), read(Id),
    write("��� ������ �� ������ : "),read(Year),
    write("�������� ������ : "),read(Name),
    write("�� ��������� : "),read(IdAuthor),
    write("�� ������-������������� : "),read(IdCountry),
    (not(checkingAll(Id,IdAuthor,IdCountry)),
    assertz(films(Id,Year,Name,IdAuthor,IdCountry)),
    write("��������� ��������� � ���������!))) ������ ��� ���� ����� �����!)))")).

insertAuthor:-
    write("�� ��������� : "), read(Id),
    write("��� ��������� : "),read(Name),
    write("��� �������� : "),read(Year),
    (
     (not(author(Id,_,_)),
      assertz(author(Id,Name,Year)),
      write("��������� ��������� � ���������!))) ������ ��� ���� ����� �����!)))");
     write("������!))) ���������� ��������������� ���������� �����"))
    ).

insertCountry:-
    write("�� ������ : "), read(Id),
    write("��� : "),read(Name),
    write("������ : "),read(Currency),
    (
     (not(country(Id,_,_)),
      assertz(country(Id,Name,Currency)),
      write("��������� ��������� � ���������!))) ������ ��� ���� ����� ������!!)))");
     write("������!))) ���������� ��������������� ���������� �����"))
    ).

updateList([],_,_,_,[]):-!.
updateList([_|T],Index,Index,NewValue,[NewValue|T]):-!.
updateList([H|T],IIndex,Index,NewValue,[H|T1]):-
    IIndex1 is IIndex + 1,
    updateList(T,IIndex1,Index,NewValue,T1).

updateFilm:-
    write("�� ������, ���������� � ������� ����� �������� : "),read(Id),
    write("�������� ���������� �� ���� ������ : "),nl,
    findall([B,C,D,E],films(Id,B,C,D,E),[[BB,CC,DD,EE]]),
    write("1 - ��� ������ �� ������ : "),write(BB),nl,
    write("2 - �������� ������ : "),write(CC),nl,
    write("3 - �� ��������� : "),write(DD),nl,
    write("4 - �� ������-������������� : "),write(EE),nl,
    write("������� ����� �������, �������� ������ �������� : "),read(Number),
    write("������� ����� �������� : "),read(NewValue),
    updateList([BB,CC,DD,EE],1,Number,NewValue,[B1,C1,D1,E1]),
    (
     (retract(films(Id,_,_,_,_)),not(checkingAll(Id,D1,E1)),assertz(films(Id,B1,C1,D1,E1)));
     assertz(films(Id,BB,CC,DD,EE))
    ).

updateAuthor:-
    write("�� ���������, ���������� � ������� ����� �������� : "),read(Id),
    write("�������� ���������� �� ���� ��������� : "),nl,
    findall([B,C],author(Id,B,C),[[BB,CC]]),
    write("1 - ��� ��������� : "),write(BB),nl,
    write("2 - ��� �������� : "),write(CC),nl,
    write("������� ����� �������, �������� ������ �������� : "),read(Number),
    write("������� ����� �������� : "),read(NewValue),
    updateList([BB,CC],1,Number,NewValue,[B1,C1]),
    retract(author(Id,_,_)),
    assertz(author(Id,B1,C1)).

updateCountry:-
    write("�� ������, ���������� � ������� ����� �������� : "),read(Id),
    write("�������� ���������� �� ���� ������ : "),nl,
    findall([B,C],country(Id,B,C),[[BB,CC]]),
    write("1 - �������� ������ : "),write(BB),nl,
    write("2 - ������ ���� ������ : "),write(CC),nl,
    write("������� ����� �������, �������� ������ �������� : "),read(Number),
    write("������� ����� �������� : "),read(NewValue),
    updateList([BB,CC],1,Number,NewValue,[B1,C1]),
    retract(country(Id,_,_)),
    assertz(country(Id,B1,C1)).

query1(A,B,Res):-
    findall([D,E],(country(C,D,E),C>=A,C<B),Res).

query2(A,Res):-
    findall([D,E],(author(_,D,E),E>=A),Res).

query3(BeginYear,BeginLetter,Res):-
    bagof(['��� ������ = ',B,
           '�������� ������ = ',C],
          (films(_,B,C,D,E),
           author(D,_,YD),
           country(E,NE,_),
           string_chars(NE,[H|_]),
           H = BeginLetter,
           YD<BeginYear),
          Res).

test1:-
    findall(Id,author(Id,_,_),Res1),
    write(Res1),nl,
    bagof(Name,(author(Id,Name,_),member(Id,[2,3])),Res2),
    write(Res2),nl.
