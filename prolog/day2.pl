father(zeb,john_boy_sr).
father(john_boy_sr, john_boy_jr).
ancestor(X, Y) :- father(X, Y).
ancestor(X, Y) :- father(X, Z), ancestor(Z, Y).

count(0, []).
count(Count, [Head|Tail]) :- count(TailCount, Tail), Count is TailCount + 1.
sum(0, []).
sum(Total, [Head|Tail]) :- sum(Sum, Tail), Total is Head + Sum.
average(Average, List) :- sum(Sum, List), count(Count, List), Average is Sum/Count.

concatenate([], List, List).
concatenate([Head|Tail1], List, [Head|Tail2]) :-
concatenate(Tail1, List, Tail2).


reverse([],List,List).
reverse([Head|Tail],Pre,Reversed) :- reverse(Tail,[Head|Pre],Reversed).
reverseList(List,Reversed) :- reverse(List,[],Reversed).

findMini([Result],Result).
findMini([Head,Second|Tail],Result) :-
    Head =< Second ->
    findMini([Head|Tail],Result);
    findMini([Second|Tail],Result).

qsort([], []).
qsort([Border|List], Result) :-
    partition(List, Border, List1, List2),
    qsort(List1, Smaller),
    qsort(List2, Bigger),
    append(Smaller, [Border|Bigger], Result).

partition([], _, [], []).
partition([Head|Tail], Border, [Head|Smaller], Bigger) :- Head < Border,partition(Tail, Border, Smaller, Bigger).
Smaller, Bigger).