import scala.util.Random
val rand = new Random
class TicTac{
  var arry = Array(Array("_","_","_"),
                 Array("_","_","_"),
                 Array("_","_","_"))
  var currentMark = "O"
  var count = 0
  def printBoard = {
    println("\n")
    arry.foreach(x => println("|" + x(0) + "|" + x(1) + "|" + x(2) + "|"))
  }
  def play = {
    var markingFlag = false
    while (markingFlag == false) {markingFlag = marking}
  }
  def marking : Boolean = {
    val row = rand.nextInt(3)
    val col = rand.nextInt(3)
    if(arry(row)(col) == "_"){
      arry(row)(col) = currentMark
      if (currentMark == "O") {currentMark = "X"} else {currentMark = "O"}
      count += 1
      return true
    }else{
      return false
    }
  }


  def status : String = {
    def judgeWin(line :Array[String]) : Boolean  = {
      if(!line(0).equals("_") && line(0).equals(line(1)) && line(1).equals(line(2))){
        return true
      } else {return false}
    }

    val rows = (0 to 2).map { index => arry(index)}
    val cols = (0 to 2).map { index => arry.map {a => a(index) }}
    val diag1 = Array(arry(0)(0), arry(1)(1), arry(2)(2))
    val diag2 = Array(arry(0)(2), arry(1)(1), arry(2)(0))
    val lines = rows ++ cols ++ Array(diag1, diag2)
    lines.foreach { line =>
      if(judgeWin(line) == true) {return line(0) + " is win!"}
    }
    return "drow"
  }
}
val tictac = new TicTac
while (tictac.status == "drow") {
 tictac.play
 tictac.printBoard
}
println(tictac.status)
