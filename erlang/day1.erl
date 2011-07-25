-module(day1).
-export([another_factorial/1]).
-export([another_fib/1]).
-export([count_words/1]).
-export([count_upto_ten/1]).
-export([display_message/1]).

display_message(Message) -> case Message of
                              success -> io:format("success\n");
                              {error,M} -> io:format("error : " ++ M ++ "\n")
                            end.

count_upto_ten(10) -> io:format("10");
count_upto_ten(Num) -> io:format( integer_to_list(Num) ++ "\n" ),
                     count_upto_ten(Num + 1).
count_words(Text) -> length(re:split(Text,"[\s]",[{return,list}])).
another_factorial(0) -> 1;
another_factorial(N) -> N * another_factorial(N-1).
another_fib(0) -> 1;
another_fib(1) -> 1;
another_fib(N) -> another_fib(N-1) + another_fib(N-2).
