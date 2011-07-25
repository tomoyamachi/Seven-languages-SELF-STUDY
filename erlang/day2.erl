-module(day2).
-export([display_value/2]).
-export([get_total_price/1]).

%% Programming = [{erlang, "a functional language"}, {ruby, "an OO language"}, {scala, "based on Java language"}].

display_value(L,Key) -> ThisTuple = lists:keyfind(Key,1,L),
                        case ThisTuple of
                            {Key,Value} -> Value;
                            _ -> false
                        end.

%% Goods = [{shirt, 3, 3500}, {shoes, 2, 7000}]

get_total_price(L) -> [{Item, (Num * Price)} || {Item, Num, Price} <- L ].
