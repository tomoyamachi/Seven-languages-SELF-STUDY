
// Do:
// • Use foldLeft to compute the total size of a list of strings.
var list = List("6chars","ninechars")
println(list.foldLeft(0)((chars,value) => chars + value.size ) + " chars")

// • Write a Censor trait with a method that will replace the curse words
// Shoot and Darn with Pucky and Beans alternatives. Use a map to
// store the curse words and their alternatives.
trait Censor {
  var curseWords = Map("Shoot" -> "Pucky" , "Darn" -> "Beans")
  def check(text : String)={
    curseWords.foldLeft(text)((replaced,mapContent) => replaced.replace(mapContent._1,mapContent._2))
  }
}

class CurseText(ctext : String) extends Censor {def checkText = check(ctext)}

val curseText = new CurseText("Shot Shoot , it is not Shooooot. Darn is what? Do you know about Darn?")
println( curseText.checkText )

// • Load the curse words and alternatives from a file.

import scala.io.Source
trait Censor2 {
  val source = Source.fromFile( "curse.txt" )
  var curseWords = Map[String,String]()
  for( line <- source.getLines ) {
    var mapper = line.split(",")
    curseWords = curseWords + (mapper(0) -> mapper(1))
  }
  def check(text : String)={
    curseWords.foldLeft(text)((replaced,mapContent) => replaced.replace(mapContent._1,mapContent._2))
  }
}
class CT(ctext : String)extends Censor2 { def cT = check(ctext)}

val curseText2 = new CT("Shot Shoot , it is not Shooooot. Darn is what? Do you know about Darn?")
println(curseText2.cT)
