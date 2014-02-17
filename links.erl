-module(links).
-compile(export_all).

crasher() ->
  timer:sleep(5000),
  exit(superfatal_error).

chain(0) ->
  receive
    _ -> ok
  after(2000) ->
    exit(reason)
  end;

chain(N) ->
  Pid = spawn(fun() -> chain(N-1) end),
  link(Pid),
  receive
    _ -> ok
  end.

