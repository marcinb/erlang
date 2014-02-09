-module(kitchen).
-export([fridge/1]).

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

