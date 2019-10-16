reverse_str(Str,ReverseStr):-
    string_chars(Str,ListChars),
    reverse(ListChars,ReverseListChars),
    atomics_to_string(ReverseListChars,ReverseStr).

simm_word(Word):-
    string_length(Word,LengthWord),
    LengthWordMod2 is LengthWord mod 2,
    LengthWordDiv2 is LengthWord div 2,
    LW_Div2_Plus_LW_Mod2 is LengthWordDiv2+LengthWordMod2,
    sub_string(Word,_,LengthWordDiv2,LW_Div2_Plus_LW_Mod2,SubString1),
    sub_string(Word,LW_Div2_Plus_LW_Mod2,LengthWordDiv2,_,SubString2),
    reverse_str(SubString1,ReverseSubString1),
    ReverseSubString1 = SubString2.


solution2([],Res,Res):-!.
solution2([H|T],Res1,Res):-
    simm_word(H),
    string_length(Res1,LengthRes1),
    string_length(H,LengthH),
    (LengthRes1 < LengthH, solution2(T,H,Res),!; solution2(T,Res1,Res),!).

solution2([H|T],Res1,Res):- solution2(T,Res1,Res).
solution(Str,Res):-
    split_string(Str,' ',' ',ListWords),
    solution2(ListWords,"",Res).

