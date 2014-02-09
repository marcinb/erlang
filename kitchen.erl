-module(kitchen).
-export([fridge/1, store/2, take/2, list/1, start/1]).

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

store(FridgePid, Food) ->
  FridgePid ! {self(), {store, Food}},
  receive
    {_Pid, Msg} -> Msg
  end.

take(FridgePid, Food) ->
  FridgePid ! {self(), {take, Food}},
  receive
    {_Pid, Msg} -> Msg
  end.

list(FridgePid) ->
  FridgePid ! {self(), list},
  receive
    {_Pid, {ok, Msg}} -> Msg
  end.

start(FoodList) ->
  spawn(?MODULE, fridge, [FoodList]).
