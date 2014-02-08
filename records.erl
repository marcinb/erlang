-module(records).
-compile(export_all).
-include("person_record.hrl").
-include("user_record.hrl").

joe() ->
  #person{
    first_name = "Joe",
    last_name = "Swanson",
    gender = male,
    bio = "Peter's friend",
    hobbys = [tv, beer, guns]
  }.

is_admin(#user{group = admin}) ->
  true;
is_admin(#user{}) ->
  false.

adult_section(#user{name = Name, age = Age}) when Age < 18 ->
  Name ++ " is too young to access adult section!";
adult_section(#user{name = Name}) ->
  Name ++ " is old enough.".

make_admin(User = #user{}) ->
  User#user{group = admin}.
