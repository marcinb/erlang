-module(rpn_calc).
-export([rpn/1]).

rpn(L) when is_list(L) ->
  lists:foldl(fun rpn/2, [], string:tokens(L, " ")).

rpn("+", [N1,N2|Stack]) -> [N2+N1|Stack];
rpn("-", [N1,N2|Stack]) -> [N2-N1|Stack];
rpn("*", [N1,N2|Stack]) -> [N2*N1|Stack];
rpn("/", [N1,N2|Stack]) -> [N2/N1|Stack];
rpn("^", [N1,N2|S]) -> [math:pow(N2,N1)|S];
rpn("ln", [N|S])    -> [math:log(N)|S];
rpn("log10", [N|S]) -> [math:log10(N)|S];
rpn(Op, Stack) ->
  [convert(Op)|Stack].

convert(Op) ->
  case string:to_float(Op) of
    {error,no_float} -> list_to_integer(Op);
    {F,_} -> F
  end.
