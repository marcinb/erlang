-module(selective_receives).
-compile(export_all).

important() ->
  receive
    {Priority, Message} when Priority > 10 ->
      [Message | important()]
    after 0 ->
      normal()
  end.

normal() ->
  receive
    {_, Message} ->
      [Message | normal()]
  after 0 ->
    []
  end.

cats_and_dogs() ->
  receive
    dog ->
      [dog | cats_and_dogs()]
    after 0 ->
      cats()
  end.

cats() ->
  receive
    cat ->
      [cat | cats()]
  after 0 ->
    others()
  end.

others() ->
  receive
    Something ->
      [Something | others()]
  after 0 ->
    []
  end.
