-module(monitors).
-compile(export_all).

start_critic() ->
  spawn(fun() -> critic() end).

judge(Critic, Band, Song) ->
  Critic ! {self(), {Band, Song}},

  receive
    {Critic, Criticism} -> Criticism
  after 2000 ->
      timeout
  end.

critic() ->
  receive
    {From, {"Metallica", "Master of Puppets"}} ->
      From ! {self(), "Awesome stuff"};
    {From, {"Megadeth", "Holy Wars"}} ->
      From ! {self(), "Totally awesome."};
    {From, {_, _}} ->
      From ! {self(), "Dunno"}
  end,
  critic().
