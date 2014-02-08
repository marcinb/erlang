-module(robot).
-compile(export_all).

robot() ->
  receive
    {Sender, kill} ->
      Sender ! "No, this violates my first directive",
      robot();
    {Sender, transform} ->
      Sender ! "Transforming into big mustache",
      robot();
    {Sender, shutdown} ->
      Sender ! "Bye!";
    {Sender, _} ->
      Sender ! "Say whaaaaaa?",
      robot()
  end.
