run:-
    see('C:/Users/Ibrag/Desktop/Knoledge_base/������.txt'),
    readln(X),seen,write(X).

readfile(T,R,L):-
    get0(X),
    (X<0,(T=[],L = R;
    name(T1,T),append(R,[T1],L)),!;
    (X=32;X=10;X=13),
    (T=[],readfile(T,R,L);name(T1,T),
     append(R,[T1],R1),readfile([],R1,L)),!;
    X>0,append(T,[X],T1),readfile(T1,R,L),!).

filetolist(F,L):-seen,see(F),readfile([],[],L),seen.
% � ����� ����� ���� ����������� �������. ������� ��� ����� ���
% ����������(����).

hasRepeat([],L,L1):-reverse(L1,L),!.
hasRepeat([H|T],L,L1):-not(member(H,T)),!,hasRepeat(T,L,[H|L1]),!.
hasRepeat([_|T],L,L1):-hasRepeat(T,L,L1).

solution(PathFile,ListWordsWithoutRepeat):-
    filetolist(PathFile,ListWordsInFile),
    atomics_to_string(ListWordsInFile,Sentence),
    split_string(Sentence,'.','.',ListWordsInSentence),
    hasRepeat(ListWordsInSentence,ListWordsWithoutRepeat,[]).

run2:-
    see('C:/Users/Ibrag/Desktop/Knoledge_base/1.txt'),
    readln(X),X \= end_of_file, write(X).


main :-
    open('C:/Users/Ibrag/Desktop/Knoledge_base/1.txt', read, Str),
    read_file(Str,Lines),
    close(Str),
    write(Lines), nl.

read_file(Stream,[]) :-
    at_end_of_stream(Stream).

read_file(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    read_file(Stream,L).








