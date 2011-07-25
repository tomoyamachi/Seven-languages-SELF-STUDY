writeln(1 + 1)//=>2
//writeln(1 + "one")//=>Exception: argument 0 to method '+' must be a Number, not a 'Sequence'

"is 0 true?" println
(true and 0) println//=>true
"is \"\" true?" println
(true and "") println//=>true
"is nil true?" println
(true and nil) println//=>fase

(Object proto) println
 // Object_0xc1df70:
 //  Lobby            = Object_0xc1df70
 //  Protos           = Object_0xc1dd90
 //  _                = nil
 //  exit             = method(...)
 //  forward          = method(...)
 //  set_             = method(...)

sample := Object clone do ( sampleMessage := method("This is sample." println))
sample getSlot("sampleMessage") call

