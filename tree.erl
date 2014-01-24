-module(tree).
-export([empty/0, insert/3, lookup/2, has_value/2]).

empty() -> {node, 'nil'}.

insert(Key, Val, {node, 'nil'}) ->
  {node, {Key, Val, {node, 'nil'}, {node, 'nil'}}};

insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) when NewKey < Key ->
  {node, {Key, Val, insert(NewKey, NewVal, Smaller), Larger}};

insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) when NewKey > Key ->
  {node, {Key, Val, Smaller, insert(NewKey, NewVal, Larger)}};

insert(NewKey, NewVal, {node, {_, _, Smaller, Larger}}) ->
  {node, {NewKey, NewVal, Smaller, Larger}}.

lookup(_, {node, nil}) ->
  undefined;

lookup(Key, {node, {Key, Val, _, _}}) ->
  {ok, Val};

lookup(Key, {node, {NodeKey, _, Smaller, _}}) when Key < NodeKey ->
  lookup(Key, Smaller);

lookup(Key, {node, {NodeKey, _, _, Larger}}) when Key > NodeKey ->
  lookup(Key, Larger).

has_value(_, {node, nil}) ->
  false;
has_value(Val, {node, {_, Val, _, _}}) ->
  throw(found);
has_value(Val, {node, {_, _, Left, Right}}) ->
  try has_value(Val, Left) of
    false -> has_value(Val, Right)
  catch
    found -> true
  end.
