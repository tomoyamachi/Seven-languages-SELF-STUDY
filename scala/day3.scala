import scala.io._
import scala.actors._
import scala.actors.Actor._
object PageLoader {
  def getPageSize(url : String) = Source.fromURL(url).getLines.mkString.length
  def getHtml(url : String) = Source.fromURL(url).mkString
}
val urls = List(
//"http://www.google.com",
"http://www.twitter.com/" ,
"http://www.cnn.com/" )

def timeMethod(method: () => Unit) = {
  val start = System.nanoTime
  method()
  val end = System.nanoTime
  println("Method took " + (end - start)/1000000000.0 + " seconds." )
}
def getPageSizeSequentially() = {
  for(url <- urls) {
    println("Size for " + url + ": " + PageLoader.getPageSize(url))
  }
}
def getPageSizeConcurrently() = {
  val caller = self
  for(url <- urls) {
    actor { caller ! (url, PageLoader.getPageSize(url)) }
  }
  for(i <- 1 to urls.size) {
    receive {
      case (url, size) =>
        println("Size for " + url + ": " + size)
    }
  }
}

def getLinkCount() = {
  for(url <- urls) {
    var html = PageLoader.getHtml(url)
    println("Link of " + url + ":" + """<a href=\"([^\"]+)\">""".r.findAllIn(html).size)
  }
}
println("Sequential run:" )
timeMethod { getPageSizeSequentially }
println("Concurrent run:" )
timeMethod { getPageSizeConcurrently }
println("Links counts:")
timeMethod { getLinkCount}
