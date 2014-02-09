-module(kitchen).
-export([store/2, take/2, list/1, start/1]).

fridge(FoodList) ->
  receive
    {Sender, {store, Food}} ->
      Sender ! {self(), ok},
      fridge([Food|FoodList]);
    {Sender, {take, Food}} ->
      case lists:member(Food, FoodList) of
        true ->
          Sender ! {self(), {ok, Food}},
          fridge(lists:delete(Food, FoodList));
        false ->
          Sender ! {self(), not_found},
          fridge(FoodList)
      end;
    {Sender, list} ->
      Sender ! {self(), {ok, FoodList}},
      fridge(FoodList);
    terminate ->
      ok
  end.

start(FoodList) ->
  spawn(fun() -> fridge(FoodList) end).

store(FridgePid, Food) ->
  communicate(FridgePid, {store, Food}).

take(FridgePid, Food) ->
  communicate(FridgePid, {take, Food}).

list(FridgePid) ->
  communicate(FridgePid, list).

communicate(FridgePid, Command) ->
  FridgePid ! {self(), Command},
  receive
    {_Pid, Msg} -> Msg
  after 100 ->
    timeout
  end.
