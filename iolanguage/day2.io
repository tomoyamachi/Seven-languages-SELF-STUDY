"Reflect start ====================" println
unless := method(
  (call sender doMessage(call message argAt(0))) ifFalse(
  (call sender doMessage(call message argAt(1)))) ifTrue(
  (call sender doMessage(call message argAt(2))))
  )
unless(1==3, "one is not three" println, "one is three" println)

princessButtercup := Object clone
westley := Object clone do ( trueLove ::= true )
westley princessButtercup := method(princessButtercup, unless(trueLove,("It is false" println), ("It is true" println)))
westley princessButtercup


"question1 start =============" println
fib := method(x,
  a := list(1,1)
  for(i,1,x,a append(a at(i) + a at(i-1)))
  a at(x-1) println
)
fib(1)
fib(4)


"question2 start =============" println
OperatorTable addOperator("/",2)
Number / 0 := 0
4 / 0 println//==>0

"question3 start =============" println
add := method(x,y,addList(x) + addList(y))
addList := method(x,x at(0) + x at(1))
add(list(1,5),list(2,4)) println//==> 12

"question4 start =============" println
myAverage := method(x,
  totalListNum := 0
  x foreach(i,v,
    if(v type == Number type,totalListNum = v + totalListNum,Exception raise("myAverage only accept Number"))
  )
  totalListNum / x size
)
myAverage(list(1,2,3)) println//=>2
//myAverage(list(1,"error",3)) println//=>Exception: myAverage only accept Number

"question5 start =============" println
Matrix := Object clone
Matrix dim := method(x,y,
  self arry ::= List clone
  for(i,1,y,arry append(List clone setSize(x)))
)
Matrix set := method(x, y, value, self arry at(y) atPut(x,value))
Matrix get := method(x, y, self arry at(y) at(x))

m := Matrix clone
m dim(3,3) println
for(x,0,2,
  for(y,0,2,
    m set(x,y,Random value(1000) floor)
    ))
m arry println
"question6 start =============" println


"question7 start =============" println
f := File with("matrixArry.txt")
f remove
f openForUpdating
xSize := m arry size
ySize := m arry(0) size
for(xs,1,xSize,
  for(ys,1,ySize,
    f write((m get(xs - 1,ys - 1)) asString)
    f write("|")
  )
  f write("\n")
)
f close


"question8 start =============" println
randomNumber := (Random value(99) + 1) floor
input := File standardInput
for(i,1,1,
  "Input number 1..100 " println
  guess := input readLine asNumber
  if(guess == randomNumber,break)
  if(guess > randomNumber,"colder" println,"hotter" println)
)
if((guess == randomNumber),
  ("OK!" println),
  ("Not correct..." println)
)