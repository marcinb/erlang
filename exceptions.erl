-module(exceptions).
-compile(export_all).

throws(F) ->
  try F() of
    _ -> ok
  catch
    Throw -> {"Exception raised", Throw}
  end.

errors(F) ->
  try F() of
    _ -> ok
  catch
    error:Error -> {"Error thrown", Error}
  end.

exits(F) ->
  try F() of
    _ -> ok
  catch
    exit:Exit -> {"Exit thrown", Exit}
  end.

sword(1) -> throw(slice);
sword(2) -> erlang:error(cut_arm);
sword(3) -> exit(cut_leg);
sword(4) -> throw(punch);
sword(5) -> exit(cross_bridge).

black_knight(Attack) ->
  try Attack() of
    friend -> "Hey man";
    _ -> "None shall pass."
  catch
    throw:slice -> "It is but a scratch.";
    error:cut_arm -> "I've had worse.";
    exit:cut_leg -> "Come on, you pansy!";
    _:_ -> "Just a flesh wound"
  end.

divide(X, Y) ->
  case catch(X/Y) of
    {'EXIT', {badarith, _}} -> "Dividing by 0 won't work...";
    Result -> Result
  end.
