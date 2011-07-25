likes(wallace, cheese).
likes(grommit, cheese).
likes(wendolene, sheep).
friend(X, Y) :- \+(X = Y), likes(X, Z), likes(Y, Z).

food_type(velveeta, cheese).
food_type(ritz, cracker).
food_type(spam, meat).
food_type(sausage, meat).
food_type(jolt, soda).
food_type(twinkie, dessert).
flavor(sweet, dessert).
flavor(savory, meat).
flavor(savory, cheese).
flavor(sweet, soda).
food_flavor(X, Y) :- food_type(X, Z), flavor(Y, Z).


different(red, green). different(red, blue).
different(green, red). different(green, blue).
different(blue, red). different(blue, green).
coloring(Alabama, Mississippi, Georgia, Tennessee, Florida) :-
  different(Mississippi, Tennessee),
  different(Mississippi, Alabama),
  different(Alabama, Tennessee),
  different(Alabama, Mississippi),
  different(Alabama, Georgia),
  different(Alabama, Florida),
  different(Georgia, Florida),
  different(Georgia, Tennessee).
cat(lion).
cat(tiger).
dorothy(X, Y, Z) :- X = lion, Y = tiger, Z = bear.
twin_cats(X, Y) :- cat(X), cat(Y).

title('the remains of the day').
title('never let me go').
title('the country of last things').
title('moon palace').
title('hackers & painters').
author('Kazuo Ishiguro').
author('Paul Austor').
author('Paul Graham').

written_by('the remains of the day','Kazuo Ishiguro').
written_by('never let me go','Kazuo Ishiguro').
written_by('moon palace','Paul Austor').
written_by('the country of last things','Paul Austor').
written_by('hackers & painters','Paul Graham').
written_by('never let me go','Paul Graham').

cowritten(A) :- author(X),author(Y),written_by(A,X),written_by(A,Y),\+(X=Y).
by_oneself(A) :- title(A),cowritten(X),\+(A = X).

musician(bob).
musician(bill).
musician(sam).
musician(newton).
inst(guitar).
inst(piano).
inst(drums).
genre(country).
genre(jazz).
genre(rock).

play(bob,guitar).
play(bill,piano).
play(sam,drums).
play(newton,guitar).

genre_of(bob,country).
genre_of(bill,jazz).
genre_of(sam,jazz).
genre_of(newton,rock).

guitarist(X) :- musician(X), play(X,guitar).