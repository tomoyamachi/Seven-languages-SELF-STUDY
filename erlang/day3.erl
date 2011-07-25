-module(day3).
-export( [translate/1, wait_for_translate/0, translator/0] ).

translate( Word ) ->
    translation_service ! {self(), Word},
    receive
        {translation, From, To} -> {From, To}
    after
        3000 ->
            "Service is not responding in a timely manner."

    end.

wait_for_translate() ->
    receive
        {From, "casa"} ->
            From ! {translation, "casa", "house"},
            wait_for_translate();
        {From, "blanca"} ->
            From ! {translation, "casa", "white"},
            wait_for_translate();
        {From, "blam"} ->
            exit( {day3, die, at, erlang:time()} );
        {From, Word} ->
            From ! {translation, Word, "Woop! Don't know what that means!"},
            wait_for_translate()

    end

        .

translator() ->
    process_flag( trap_exit, true ),
    receive
        start_service ->
            io:format( "Translation server has been started.~n" ),
            register(
              translation_service,
              spawn_link( fun wait_for_translate/0 )
             ),
            translator();
        {'EXIT', From, Reason} ->
            io:format( "Translation service has died.~n" ),
            self() ! start_service,
            translator()

    end.
