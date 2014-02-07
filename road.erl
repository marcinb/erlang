-module(road).
-compile(export_all).

main([FileName]) ->
  {ok, Bin} = file:read_file(FileName),
  Map = parse_map(Bin),
  io:format("~p~n", [optimal_path(Map)]),
  erlang:halt().

parse_map(Bin) when is_binary(Bin) ->
  parse_map(binary_to_list(Bin));
parse_map(L) when is_list(L) ->
  Values = [list_to_integer(X) || X <- string:tokens(L, "\n")],
  group_values(Values, []).

group_values([], Acc) ->
  lists:reverse(Acc);
group_values([A,B,X|Rest], Acc) ->
  group_values(Rest, [{A,B,X} | Acc]).

shortest_step({A,B,X}, {{DistanceA, PathA}, {DistanceB, PathB}}) ->
  A1 = {DistanceA + A, [{a, A}|PathA]},
  A2 = {DistanceA + B + X, [{x,X}, {b, B}|PathB]},
  B1 = {DistanceB + B, [{b, B}|PathB]},
  B2 = {DistanceB + A + X, [{x, X}, {a, A}|PathA]},

  {erlang:min(A1, A2), erlang:min(B1, B2)}.

optimal_path(Map) ->
  {A,B} = lists:foldl(fun shortest_step/2, {{0,[]}, {0,[]}}, Map),
  {_Dist,Path} = if hd(element(2,A)) =/= {x,0} -> A;
    hd(element(2,B)) =/= {x,0} -> B
  end,
  lists:reverse(Path).
