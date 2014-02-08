-module(records).
-compile(export_all).

-record(person, {
  first_name,
  last_name,
  gender,
  bio = "A person.",
  hobbys=[]
}).

joe() ->
  #person{
    first_name = "Joe",
    last_name = "Swanson",
    gender = male,
    bio = "Peter's friend",
    hobbys = [tv, beer, guns]
  }.
