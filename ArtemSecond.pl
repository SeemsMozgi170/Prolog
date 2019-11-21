% проверка на то, что в векторе нет повторяющихся элементов
unique([]):-!.
unique([Head|Tail]):-
    member(Head, Tail),!,fail;
    unique(Tail).

% предметы
lesson(biology).
lesson(french).
lesson(english).
lesson(geography).
lesson(history).
lesson(math).

% предикат решения
solution(Info):-

    % будущий результат
    Info = [[morozov,MorozovLesson1,MorozovLesson2],
            [vasiliev,VasilievLesson1,VasilievLesson2],
            [tokarev,TokarevLesson1,TokarevLesson2]],

    % их предметы должны быть в списке предметов выше
    lesson(MorozovLesson1),lesson(MorozovLesson2),
    lesson(VasilievLesson1),lesson(VasilievLesson2),
    lesson(TokarevLesson1),lesson(TokarevLesson2),

    % Проверка на то, что каждый предмет у каждого учителя свой(нет повторений, уникально)
    unique([MorozovLesson1,MorozovLesson2,
            VasilievLesson1,VasilievLesson2,
            TokarevLesson1,TokarevLesson2]),

    % Учителя географии и французского - соседи по дому
    not(member([_,geography,french],Info)),
    not(member([_,french,geography],Info)),

    % В понедельник первый урок по расписанию у Токарева, у биолога и у учителя французского языка(это разные люди)
    not(member([tokarev,biology,_],Info)),
    not(member([tokarev,_,biology],Info)),
    not(member([tokarev,_,french],Info)),
    not(member([tokarev,french,_],Info)),
    not(member([_,biology,french],Info)),
    not(member([_,french,biology],Info)),

    % Учитель биологии старше учителя математики. Морозов – самый молодой.
    not(member([morozov,biology,_],Info)),
    not(member([morozov,_,biology],Info)),

    % Учитель биологии старше учителя математики
    not(member([_,biology,math],Info)),
    not(member([_,math,biology],Info)),

    % В воскресенье Морозов, математик и учитель английского язык были на рыбалке
    not(member([_,english,math],Info)),
    not(member([_,math,english],Info)),
    not(member([morozov,_,english],Info)),
    not(member([morozov,english,_],Info)),
    not(member([morozov,_,math],Info)),
    not(member([morozov,math,_],Info)),!.












