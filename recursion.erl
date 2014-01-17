-module(recursion).
-export([
    fac/1, len/1,
    tail_fac/1, tail_len/1,
    duplicate/2, tail_duplicate/2,
    reverse/1, tail_reverse/1,
    sublist/2, tail_sublist/2,
    zip/2, tail_zip/2,
    quicksort/1
  ]).

fac(0) -> 1;
fac(N) when N > 0 ->
  N * fac(N - 1).

tail_fac(N) -> tail_fac(N, 1).
tail_fac(0, Acc) -> Acc;
tail_fac(N, Acc) when N > 0 ->
  tail_fac(N-1, N*Acc).

len([]) -> 0;
len([_|T]) -> 1 + len(T).

tail_len(L) -> tail_len(L, 0).
tail_len([], Acc) -> Acc;
tail_len([_|T], Acc) -> tail_len(T, Acc + 1).

duplicate(0, _) ->
  [];
duplicate(N, E) when N > 0 ->
  [E|duplicate(N - 1, E)].

tail_duplicate(N, E) when N >= 0 -> tail_duplicate(N,E,[]).
tail_duplicate(0, _, Acc) -> Acc;
tail_duplicate(N, E, Acc) -> tail_duplicate(N-1, E, [E|Acc]).

reverse([]) -> [];
reverse([H|T]) -> reverse(T) ++ [H].

tail_reverse(List) -> tail_reverse(List, []).
tail_reverse([], Acc) -> Acc;
tail_reverse([H|T], Acc) -> tail_reverse(T, [H|Acc]).

sublist(_, 0) -> [];
sublist([], N) -> [];
sublist([H|T], N) when N > 0 ->
  [H|sublist(T, N-1)].

tail_sublist(List, N) -> tail_sublist(List, N, []).
tail_sublist(_, 0, Acc) -> Acc;
tail_sublist([], N, Acc) -> Acc;
tail_sublist([H|T], N, Acc) when N > 0 ->
  tail_sublist(T, N-1, Acc++[H]).

zip([], []) -> [];
zip([Hx|Tx], [Hy|Ty]) ->
  [{Hx, Hy}|zip(Tx, Ty)].

tail_zip(ListX, ListY) -> tail_zip(ListX, ListY, []).
tail_zip([], [], Acc) -> Acc;
tail_zip([Hx|Tx], [Hy|Ty], Acc) ->
  tail_zip(Tx, Ty, Acc++[{Hx, Hy}]).

quicksort([]) -> [];
quicksort([Pivot|Rest]) ->
  {Smaller, Larger} = partition(Pivot, Rest, [], []),
  quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).
partition(_, [], Smaller, Larger) -> {Smaller, Larger};
partition(Pivot, [H|T], Smaller, Larger) ->
  if H =< Pivot -> partition(Pivot, T, [H|Smaller], Larger);
     H > Pivot -> partition(Pivot, T, Smaller, [H|Larger])
  end.
