-module(hhfuns).
-compile(export_all).

one() -> 1.
two() -> 2.

add(X, Y) -> X() + Y().

increment([]) -> [];
increment([H|T]) ->
  [H+1|increment(T)].

decrement([]) -> [];
decrement([H|T]) ->
  [H-1|decrement(T)].

map(_, []) -> [];
map(F, [H|T]) ->
  [F(H)|map(F,T)].

incr(X) -> X + 1.
decr(X) -> X - 1.

anonymous(A) ->
  fun() -> A * 2 end.

redef() ->
  A = 1,
  (fun() -> A = 2 end)().

old_men(People) -> old_men(People, []).
old_men([], Acc) -> Acc;
old_men([Man = {male, Age}|People], Acc) when Age > 60 ->
  old_men(People, [Man|Acc]);
old_men([_|People], Acc) ->
  old_men(People, Acc).

filter(Pred, L) -> lists:reverse(filter(Pred, L, [])).
filter(_, [], Acc) -> Acc;
filter(Pred, [H|T], Acc) ->
  case Pred(H) of
    true -> filter(Pred, T, [H|Acc]);
    false -> filter(Pred, T, Acc)
  end.

even(L) ->
  Pred = fun(E) -> E rem 2 == 0 end,
  filter(Pred, L).

max([H|T]) -> max2(T, H).
max2([], Max) -> Max;
max2([H|T], Max) when H > Max ->
  max2(T, H);
max2([_|T], Max) ->
  max2(T, Max).

fold(_, [], Acc) ->
  Acc;
fold(F, [H|T], Acc) ->
  fold(F, T, F(H, Acc)).

sum2(List) ->
  F = fun(A, B) -> A + B end,
  fold(F, List, 0).

min2([H|T]) ->
  F = fun
    (A,B) when A < B -> A;
    (_,B) -> B
  end,
  fold(F, T, H).

reverse(List) ->
  F = fun(X, Acc) -> [X|Acc] end,
  fold(F, List, []).

filter2(Pred, List) ->
  F = fun(X, Acc) ->
      case Pred(X) of
        true -> [X|Acc];
        false -> Acc
      end
  end,
  fold(F, List, []).
