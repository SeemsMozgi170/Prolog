solution:-
    write('������� ���������� ������ : '),read(V),
    write('������� ���������� ����� : '),read(R),
    ((R >= V),(V > 2),(VMAS is V*(1+((V-1)/2))),(R =< VMAS),initmas(VMAS,Mas),stp(VMAS,D),gen_and_check(V,R,Mas,D),!);
            (write('������������ ��������')).

initmas(V,Mas):-(V1 is V-1),initmas(V1,Mas,[0]).
initmas(V,Mas,Mas):-((V = 0);(V = 0.0)),!.
initmas(V,Mas,T):-(V1 is V-1),initmas(V1,Mas,[0|T]).

initmat(V,Mat):-(V1 is V-1),initmas(V,Res),initmat(V,Mat,[Res],V1).
initmat(_,Mat,Mat,0):-!.
initmat(V,Mat,T,Kol):-(Kol1 is Kol-1),initmas(V,Res),initmat(V,Mat,[Res|T],Kol1).

mas_to_mat(V,Mas,Res):-initmat(V,Mat),set_mas_to_mat(V,Mas,Mat,Res).

set_mas_to_mas(V,Kol,Mas,MasRes,OstMasRes):-set_mas_to_mas(V,Kol,Mas,MasRes,OstMasRes,[]).
set_mas_to_mas(0,_,Y,Res,Y,ReverseRes):-reverse(ReverseRes,Res),!.
set_mas_to_mas(V,Kol,[X|Y],MasRes,OstMasRes,T):-(Kol = 0),!,(V1 is V-1),set_mas_to_mas(V1,Kol,Y,MasRes,OstMasRes,[X|T]).
set_mas_to_mas(V,Kol,Y,MasRes,OstMasRes,T):-(Kol1 is Kol-1),set_mas_to_mas(V,Kol1,Y,MasRes,OstMasRes,[0|T]).

set_mas_to_mat(V,Mas,Mat,Res):-set_mas_to_mat(V,0,Mas,Mat,Res,[]).
set_mas_to_mat(0,_,[],_,Res,Res1):-reverse(Res1,Res),!.
set_mas_to_mat(V,Kol,Mas,[_|Y],Res,T):-set_mas_to_mas(V,Kol,Mas,MasRes,OstMasRes),(V1 is V-1),(Kol1 is Kol+1),
                                       set_mas_to_mat(V1,Kol1,OstMasRes,Y,Res,[MasRes|T]).

kol(Mas,Res):-kol(Mas,Res,0).
kol([],Res,Res):-!.
kol([X|Y],Res,T):-(X = 1),!,(T1 is T+1),kol(Y,Res,T1).
kol([_|Y],Res,T):-kol(Y,Res,T).

inc(Mas,Res):-reverse(Mas,Res1),inc(Res1,Res,1,[]).
inc([],Res,0,Res):-!.
inc([X|Y],Res,INC,T):-(INC = 1),(X = 1),!,inc(Y,Res,1,[0|T]).
inc([X|Y],Res,INC,T):-(INC = 1),(X = 0),!,inc(Y,Res,0,[1|T]).
inc([X|Y],Res,INC,T):-(INC = 0),inc(Y,Res,INC,[X|T]).

stp(X,Res):-stp(X,Res,1).
stp(0,Res,Res):-!.
stp(0.0,Res,Res):-!.
stp(X,Res,T):-(X1 is X-1),(T1 is T*2),stp(X1,Res,T1).

gen_and_check(V,R,Mas,St):-told,tell('C:/Users/Ibrag/Desktop/Knoledge_base/Programms_Prolog/Indiv6/out.txt'),gen_and_check(V,R,Mas,St,0),told.
gen_and_check(_,_,_,St,St):-!.
gen_and_check(V,R,Mas,St,I):-(I < St),inc(Mas,Mas1),kol(Mas1,K),(K = R),!,mas_to_mat(V,Mas1,Mat),analyseGraph(Mat),
                               (I1 is I+1),gen_and_check(V,R,Mas1,St,I1).
gen_and_check(V,R,Mas,St,I):-(I < St),inc(Mas,Mas1),!,(I1 is I+1),gen_and_check(V,R,Mas1,St,I1).
gen_and_check(_,_,_,_,_):-true.

getGraph([HeadMatrix|TailMatrix],Graph):-
    length(HeadMatrix,Count),
    byPassMatrix([HeadMatrix|TailMatrix],Count,1,[],Graph).

byPassMatrix([],_,_,ResultGraph,ResultGraph):-!.
byPassMatrix([Head|Tail],Count,NumberRow,IGraph,ResultGraph):-
    byPassColumnMatrix(Head,Count,NumberRow,1,IGraph,IGraph1),
    NumberRow1 is NumberRow + 1,
    byPassMatrix(Tail,Count,NumberRow1,IGraph1,ResultGraph),!.

byPassColumnMatrix([],_,_,_,Graph,Graph):-!.
byPassColumnMatrix([H|T],Count,NumberRow,NumberColumn,IGraph,Graph):-
    NumberColumn > NumberRow,
    H = 1,
    add_edges(IGraph,[NumberRow-NumberColumn,NumberColumn-NumberRow],IGraph1),
    NumberColumn1 is NumberColumn + 1,
    byPassColumnMatrix(T,Count,NumberRow,NumberColumn1,IGraph1,Graph),!.
byPassColumnMatrix([_|T],Count,NumberRow,NumberColumn,IGraph,Graph):-
    NumberColumn1 is NumberColumn + 1,
    byPassColumnMatrix(T,Count,NumberRow,NumberColumn1,IGraph,Graph),!.


analyseNeighbours([],ListNeighbours,CountComponent):-
    list_to_set(ListNeighbours,ListNeighbours1),
    length(ListNeighbours1,CountComponent).
analyseNeighbours([_-LN|T],ListNeighbours,CountComponent):-
    append(ListNeighbours,[LN],ListNeighbours1),
    analyseNeighbours(T,ListNeighbours1,CountComponent).

analyseGraph(Matrix):-
    getGraph(Matrix,Graph),
    vertices(Graph,AllV),
    length(AllV,LAllV),
    length(Matrix,LM),
    LM = LAllV,
    transitive_closure(Graph,Graph1),
    findall(A,(member(A-B,Graph),length(B,LB),LB=<1),R),length(R,LR),LR=0,
    analyseNeighbours(Graph1,[],CountComponent),
    CountComponent = 1,
    vertices(Graph,VGraph),
    analyseBlock(Graph,VGraph).
analyseGraph(_):-true.

analyseBlock(Graph,[]):-writeln(Graph),!.
analyseBlock(Graph,[H|T]):-
    transitive_closure(Graph,TrClGraph),
    analyseNeighbours(TrClGraph,[],CountComponentBefore),
    del_vertices(Graph,[H],Graph1),
    transitive_closure(Graph1,TrClGraph1),
    analyseNeighbours(TrClGraph1,[],CountComponentAfter),
    CountComponentBefore = CountComponentAfter,
    analyseBlock(Graph,T).



