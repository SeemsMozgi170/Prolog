% вычисляем расстояние(считаем количество букв, в которых различаются эти слова)
analyzeLists([],L,C,R):-length(L,LL),R is C + LL,!.
analyzeLists(L,[],C,R):-length(L,LL),R is C + LL,!.
analyzeLists([H|T],L,C,R):-
    % если символ есть в обоих словах, то не прибавляем и удаляем его из символов второго слова
    member(H,L),
    % удаляем его из символов второго слова
    delete(L,H,L1),
    % идем дальше
    analyzeLists(T,L1,C,R),!.
analyzeLists([_|T],L,C,R):-
    % если его нет в списке символов второго слова, то +1
    C1 is C + 1,
    % идем дальше
    analyzeLists(T,L,C1,R).
%====Находим расстояние между 2мя словами================
distance(WordA,WordB,Distance):-
    % получаем их длину
    string_length(WordA,LengthA),
    string_length(WordB,LengthB),
    % слова сравнимы, если их длины равны
    LengthA = LengthB,
    % получаем массив без повторений каждого слова
    string_chars(WordA,ListCharsWordA),
    list_to_set(ListCharsWordA,SetCharsWordA),
    string_chars(WordB,ListCharsWordB),
    list_to_set(ListCharsWordB,SetCharsWordB),
    % вычисляем расстояние(считаем количество букв, в которых различаются эти слова)
    analyzeLists(SetCharsWordA,SetCharsWordB,0,Distance).
%=======Чтение из файла и получение списка слов===========
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
%=============Находим расстояние между словами списка===========
findDistance([],[]):-!.
findDistance([Head|Tail],ResultListDistance):-
    % находим расстояние между рассматриваемым элементом и всеми элементами листа по отдельности
    findDistance(Head,[Head|Tail],[],ListDistanceWithHead),
    % разобрались с этим элементом (построили список доступных расстояний с ним)
    %Теперь делаем это для элементов хвоста списка.
    findDistance(Tail,ListDistanceBetweenElementsTail),
    % соединяем список с расстояниями элементов хвоста(относительно этого элемента) и
    % список расстояний с головой(в данном случае) в результирующий список
    append(ListDistanceWithHead,ListDistanceBetweenElementsTail,ResultListDistance).
% ==Здесь находим расстояние каждого элемента списка с головой списка===
findDistance(_,[],ListDistanceWithE,ListDistanceWithE):-!.
findDistance(Elem,[Head|Tail],IntermediateListDistanceWithE,ListDistanceWithE):-
    % находим расстояние между 2мя элементами и рассматриваем только положительное расстояние
    distance(Elem,Head,DistanceBetweenElemAndHead),DistanceBetweenElemAndHead>0,
    % присоединяем полученное расстояние и элементы как уже описанную тройку в список расстояний с элементом E
    append(IntermediateListDistanceWithE,[[Elem,Head,DistanceBetweenElemAndHead]],L1),
    % идем дальше
    findDistance(Elem,Tail,L1,ListDistanceWithE),!.
findDistance(E,[_|T],IL,L):-
    %Если расстояния нет(длина слов разная) или расстояние = 0, то идем дальше
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
%===========Основное решение==============================
solution:-
    % Получаю лист слов из файла
    filetolist('C:/Users/Ibrag/Desktop/Knoledge_base/Programms_Prolog/Indiv4/in.txt',ListWordsFromFile),
    % Нахожу дистанцию между словами и получение списка элементов вида [слово1, слово2, расстояние между ними]
    findDistance(ListWordsFromFile,ListDistance),
    % Нахождение максисального расстояния между словами
    max(ListDistance,MaxDistanceBetweenWords),
    % Получаем новый лист из элементов с максимальным расстоянием такого же вида
    findMax(ListDistance,MaxDistanceBetweenWords,[],ListElementsWithMaxDistance),
    (% Если такой элемент 1, то выводим его на консоль
     length(ListElementsWithMaxDistance,LengthListElementsWithMaxDistance),
        LengthListElementsWithMaxDistance =< 1,write(ListElementsWithMaxDistance),!;
     % Иначе, вывдим такие пары в файл (формат вывода в задании)
     write('Их больше одного'), insertInFile(ListElementsWithMaxDistance)).
%=========================================================

















