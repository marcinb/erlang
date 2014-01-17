-module(new_and).
-compile(export_all).

new_and(_, false) -> false;
new_and(false, _) -> false;
new_and(true, true) -> true.
