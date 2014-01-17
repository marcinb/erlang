-module(functions).
-compile(export_all).

head([H|_]) ->
  H.

tail([_|T]) ->
  T.

second([_,X|_]) ->
  X.

same(X,X) ->
  true;
same(_,_) ->
  false.

valid_time({Date = {Y,M,D}, Time = {H,Min,S}}) ->
  io:format("Date tuple is (~p), ~p/~p/~p~n", [Date, Y, M, D]),
  io:format("Time tuple is (~p), ~p/~p/~p~n", [Time, H, Min, S]);
valid_time(_) ->
  io:format("Stop feeding me wrong data!").
