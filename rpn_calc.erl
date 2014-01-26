-module(rpn_calc).
-export([rpn/1, test/0]).

rpn(L) when is_list(L) ->
  [Result] = lists:foldl(fun rpn/2, [], string:tokens(L, " ")),
  Result.

rpn("+", [N1,N2|Stack]) -> [N2+N1|Stack];
rpn("-", [N1,N2|Stack]) -> [N2-N1|Stack];
rpn("*", [N1,N2|Stack]) -> [N2*N1|Stack];
rpn("/", [N1,N2|Stack]) -> [N2/N1|Stack];
rpn("^", [N1,N2|Stack]) -> [math:pow(N2,N1)|Stack];
rpn("ln", [N|Stack])    -> [math:log(N)|Stack];
rpn("log10", [N|Stack]) -> [math:log10(N)|Stack];
rpn("sum", Stack) -> [lists:sum(Stack)];
rpn("prod", Stack) -> [prod(Stack)];
rpn(Op, Stack) ->
  [convert(Op)|Stack].

convert(Op) ->
  case string:to_float(Op) of
    {error,no_float} -> list_to_integer(Op);
    {F,_} -> F
  end.

prod([X]) -> X;
prod([H|T]) -> H * prod(T).

test() ->
  5 = rpn("2 3 +"),
  87 = rpn("90 3 -"),
  -4 = rpn("10 4 3 + 2 * -"),
  -2.0 = rpn("10 4 3 + 2 * - 2 /"),
  ok = try
    rpn("90 34 12 33 55 66 + * - +")
  catch
    error:{badmatch,[_|_]} -> ok
  end,
  4037 = rpn("90 34 12 33 55 66 + * - + -"),
  8.0 = rpn("2 3 ^"),
  true = math:sqrt(2) == rpn("2 0.5 ^"),
  true = math:log(2.7) == rpn("2.7 ln"),
  true = math:log10(2.7) == rpn("2.7 log10"),
  50 = rpn("10 10 10 20 sum"),
  10.0 = rpn("10 10 10 20 sum 5 /"),
  1000.0 = rpn("10 10 20 0.5 prod"),
  ok.
