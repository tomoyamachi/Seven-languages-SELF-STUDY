def whileLoop{
  var i = 1
  while(i <=3){
    println(i)
    i += 1
  }
}
whileLoop

class Compass {
  val directions = List("north" , "east" , "south" , "west" )
  var bearing = 0
  print("Initial bearing: " )
  println(direction)
  def direction() = directions(bearing)
  def inform(turnDirection: String) {
    println("Turning " + turnDirection + ". Now bearing " + direction)
  }
  def turnRight() {
    bearing = (bearing + 1) % directions.size
    inform("right" )
  }
  def turnLeft() {
    bearing = (bearing + (directions.size - 1)) % directions.size
    inform("left" )
  }
}
val myCompass = new Compass
myCompass.turnRight
myCompass.turnRight
myCompass.turnLeft
myCompass.turnLeft
myCompass.turnLeft

import scala.util.Random

class Game{
  val board = Array(Array("_", "_", "_"),
                    Array("_", "_", "_"),
                    Array("_", "_", "_"))
  var currentPlayer = "X"
  def play(mark: String, pos : List[Int]) : Boolean = {
    if(mark == currentPlayer && board(pos(0))(pos(1)) == "_"){
      board(pos(0))(pos(1)) = mark
      if(currentPlayer == "X") { currentPlayer = "O"} else { currentPlayer = "X"}
      return true
    }
    else {
      return false
    }
  }

  def status : String = {
    def row(index : Int) = board(index)

    def col(index : Int) = board.map { row => row(index)}
    def winner(line : Array[String]) = {
      if(!line(0).equals("_") && line(0).equals(line(1)) && line(1).equals(line(2))){
        true
      }
      else {
       false
      }
    }
    def boardIsFull() : Boolean = {
      board.foreach { row =>
          row.foreach { element => if(element == "_")
           return false
          }
      }
      return true
    }

    val rows = (0 to board.size-1).map { index => row(index)}
    val cols = (0 to board.size-1).map { index => col(index)}
    val diag1 = Array(board(0)(0), board(1)(1), board(2)(2))
    val diag2 = Array(board(0)(2), board(1)(1), board(2)(0))
    val lines = rows ++ cols ++ Array(diag1, diag2)
print(rows)
    lines.foreach { line =>
      if(winner(line)) {
        return "WINNER is " + line(0)
      }
    }

    if(boardIsFull()){
      return "TIE"
    }

    return "UNFINISHED"
  }

  def printBoard = {
    board.foreach { row => println("" + row(0) + " | "
                                      + row(1) + " | "
                                      + row(2) )}
  }
}

val rand = new Random
val game = new Game

while(game.status == "UNFINISHED"){
  game.printBoard
  println(game.currentPlayer + "'s turn.\n")
  var valid = false
  do {
    val row = rand.nextInt(3)
    val col = rand.nextInt(3)
    valid = game.play(game.currentPlayer , List(row,col))
  } while(valid == false)
}

game.printBoard
println(game.status)


///kokokarabetukaitou--------------------------------------------

class TicTacToeCell {
  var occupant = " ";
  val validOccupants = List( "X", "O" );
  def ==( target: TicTacToeCell ):Boolean = {
    return( this.getOccupant() == target.getOccupant() );
  }

  def getOccupant():String = this.occupant;
  def isOccupied() = {
    (this.getOccupant() != " ");
  }

  def isValidOccupant( occupant: String ) = {
    this.validOccupants.contains( occupant );
  }
  def setOccupant( newOccupant: String ):Unit = {
    if (this.isOccupied()){
      throw new IllegalStateException( "This cell is currently occupied by " + this.occupant + ". A cell can only be occupied once." );
    }

    if (!this.isValidOccupant( newOccupant )){
      throw new IllegalArgumentException( "The incoming occupant is not valid. Valid types include: " + this.validOccupants );
    }

    this.occupant = newOccupant;
  }
  override def toString():String = {
    if (this.isOccupied()){
      return( this.getOccupant() );
    } else {
      return( "." );
    }
  }

}

class TicTacToeBoard {
  val board = List(
    new TicTacToeCell(),
    new TicTacToeCell(),
    new TicTacToeCell(),
    new TicTacToeCell(),
    new TicTacToeCell(),
    new TicTacToeCell(),
    new TicTacToeCell(),
    new TicTacToeCell(),
    new TicTacToeCell()
  );

  val winningPaths = List(
    List( 0, 1, 2 ),
    List( 3, 4, 5 ),
    List( 6, 7, 8 ),
    List( 0, 3, 6 ),
    List( 1, 4, 7 ),
    List( 2, 5, 8 ),
    List( 0, 4, 8 ),
    List( 2, 4, 6 )
  );

  def getWinner():String = {
    if (!this.hasWinner){
      throw new IllegalStateException( "The board does not have a winner." );
    }
    this.winningPaths.foreach( path =>
      if (this.pathContainsWinner( path )){
        return(
          this.board( path( 0 ) ).getOccupant()
        );
      }
                            );
    return( "SHOULD NEVER MAKE IT THIS FAR" );
  }
  def hasFreeCells():Boolean = {
    this.board.foreach( cell =>
      if (!cell.isOccupied()){
        return( true );
      }
                     );
    return( false );
  }


  def hasNextMove() = {
    (this.hasFreeCells() && !this.hasWinner);
  };
  def hasWinner:Boolean = {
    this.winningPaths.foreach( path =>
      if (this.pathContainsWinner( path )){
        return( true );
      }
                            );
    return( false );
  }
  def isTieBoard() = {
    (!this.hasFreeCells() && !this.hasWinner);
  }
  def pathContainsWinner( path: List[Int] ) = {
    val cell1 = this.board( path( 0 ) );
    val cell2 = this.board( path( 1 ) );
    val cell3 = this.board( path( 2 ) );
    cell1.isOccupied() &&
    (cell1 == cell2) &&
    (cell1 == cell3);
  }
  def setOccupant( cellIndex: Int, occupant: String ) = {
    this.board( cellIndex ).setOccupant( occupant );
  };
  override def toString():String = {
    return(
      this.board( 0 ) + " | " +
      this.board( 1 ) + " | " +
      this.board( 2 ) + "\n" +
      "---------\n" +
      this.board( 3 ) + " | " +
      this.board( 4 ) + " | " +
      this.board( 5 ) + "\n" +
      "---------\n" +
      this.board( 6 ) + " | " +
      this.board( 7 ) + " | " +
      this.board( 8 ) + "\n"
    );
  };

}
class TicTacToeGame {
  this.play();
  def getNextPlayer( player: String ):String = {
    if (player == "X"){
      return( "O" );
    } else {
      return( "X" );

    }
  }
  def play():Unit = {
    var board = new TicTacToeBoard();
    var currentPlayer = "X";
    println( "" );
    while( board.hasNextMove() ){
      println( board );
      print( "\n" + currentPlayer + "'s Move: " );
      try {
        var cellIndex = Console.readInt();
        board.setOccupant( cellIndex, currentPlayer );
        currentPlayer = this.getNextPlayer( currentPlayer );
      } catch {
        case e:Exception =>
          println( "That index is not valid!" );

      }
      println( "" );
    }
    println( board );
    if (board.isTieBoard()){
      println( "Tie Game!" );
    } else {
      var winner = board.getWinner();
      println( "And the winner is: " + winner );
      println( "Hate the game, not the player!" );
    }
    print( "\nWant to play again? (Y/N) " );
    var playAgain = Console.readLine().toLowerCase();
    if ((playAgain != "") && (playAgain != "n")){
      this.play();

    }
  }

}



var tictacgame = new TicTacToeGame();
