% �������� �� ��, ��� � ������� ��� ������������� ���������
unique([]):-!.
unique([Head|Tail]):-
    member(Head, Tail),!,fail;
    unique(Tail).

% ��������
lesson(biology).
lesson(french).
lesson(english).
lesson(geography).
lesson(history).
lesson(math).

% �������� �������
solution(Info):-

    % ������� ���������
    Info = [[morozov,MorozovLesson1,MorozovLesson2],
            [vasiliev,VasilievLesson1,VasilievLesson2],
            [tokarev,TokarevLesson1,TokarevLesson2]],

    % �� �������� ������ ���� � ������ ��������� ����
    lesson(MorozovLesson1),lesson(MorozovLesson2),
    lesson(VasilievLesson1),lesson(VasilievLesson2),
    lesson(TokarevLesson1),lesson(TokarevLesson2),

    % �������� �� ��, ��� ������ ������� � ������� ������� ����(��� ����������, ���������)
    unique([MorozovLesson1,MorozovLesson2,
            VasilievLesson1,VasilievLesson2,
            TokarevLesson1,TokarevLesson2]),

    % ������� ��������� � ������������ - ������ �� ����
    not(member([_,geography,french],Info)),
    not(member([_,french,geography],Info)),

    % � ����������� ������ ���� �� ���������� � ��������, � ������� � � ������� ������������ �����(��� ������ ����)
    not(member([tokarev,biology,_],Info)),
    not(member([tokarev,_,biology],Info)),
    not(member([tokarev,_,french],Info)),
    not(member([tokarev,french,_],Info)),
    not(member([_,biology,french],Info)),
    not(member([_,french,biology],Info)),

    % ������� �������� ������ ������� ����������. ������� � ����� �������.
    not(member([morozov,biology,_],Info)),
    not(member([morozov,_,biology],Info)),

    % ������� �������� ������ ������� ����������
    not(member([_,biology,math],Info)),
    not(member([_,math,biology],Info)),

    % � ����������� �������, ��������� � ������� ����������� ���� ���� �� �������
    not(member([_,english,math],Info)),
    not(member([_,math,english],Info)),
    not(member([morozov,_,english],Info)),
    not(member([morozov,english,_],Info)),
    not(member([morozov,_,math],Info)),
    not(member([morozov,math,_],Info)),!.












