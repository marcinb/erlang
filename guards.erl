-module(guards).
-compile(export_all).

right_age(Age) when Age >= 16, Age =< 100, is_integer/Age ->
  true;
right_age(_) ->
  false.

what_the_if() ->
  if 1 =:= 1 ->
      works
  end,
  if 1 =:= 2; 1 =:= 1 ->
      works
  end,
  if 1 =:= 2, 1 =:= 1 ->
      fails
  end.

might_pass(N) ->
  if N =:= 2 ->
    good;
    true ->
      fuuuuuuu
  end.
