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
