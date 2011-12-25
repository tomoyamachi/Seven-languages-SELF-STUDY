import actors.Actor
import io.Source
import java.lang.StringBuilder
import scala.util.continuations.{reset, shift}
import scala.actors.Actor.{loop, react}

/**
* {@link Request}を実行し、{@link Response}を返すtrait
*/
trait Http {
  def getResponse(req: Request): Response
}

/**
* {@link scala.io.Source.fromUrl(String)}による{@link Http}の実装
*/
trait SourceHttp extends Http {
  def getResponse(req: Request) = {
    val source = Source.fromURL(req.uri)
    val stringBuilder = new StringBuilder()
    for (line <- source) {
      stringBuilder.append(line)
    }
    source.close()
    Response(stringBuilder.toString)
  }
}

// Gets the response for the request, calls handler with the response just for once.
/**
* {@link Request}を実行し、{@link Response}を取得してそれを引数に一回だけコールバック関数を呼び出すActor
*/
abstract class HttpClientActor[T](handler: (Response) => T) extends Actor with Http {
  def execute(req: Request) {
    println("5. Executing a request " + req + "...")
    handler(getResponse(req))
    exit()
  }

  def act() {
    loop {
      react {
        case req: Request => execute(req)
      }
    }
  }
}

/**
* {@link scala.io.Source.fromUrl(String)}で{@link Request}を処理する{@link HttpClientActor}の実装
*/
class SourceHttpClientActor[T](handler: (Response) => T) extends HttpClientActor(handler) with SourceHttp

/**
* 本当に簡単なHTTPリクエスト
*/
case class Request(uri: String)

/**
* 本当に簡単なHTTPレスポンス
*/
case class Response(content: String) {
  /**
* バイト数じゃなくて文字数返してるけどドンマイ
*/
  def contentSize = content.length()
}

/**
*
*/
class AsyncHttpClient {
  type ResponseHandler[T] = (Response) => T

  def executeRequestWithActor[T](req: Request, handler: ResponseHandler[T]) {
    val actor = new SourceHttpClientActor(handler)
    actor.start
    actor ! req
  }

  /**
* レスポンスを取得してコールバックする。
* よくある非同期処理のパターン
*/
  def withResponse[T](req: Request)(handler: ResponseHandler[T]) {
    println("2a. Pass the callback function to an actor")
    executeRequestWithActor(req, handler)
    println("3a. Delegated the execution of the request to the actor\n")
  }

  /**
* 指定したRequestを投げてsuspendし、Responseが取得できてから継続する
*/
  def awaitResponse[T](req: Request) = {
    shift { k: ResponseHandler[T] =>
      println("2b. Pass the continuation k to an actor.")
      executeRequestWithActor(req, k)
      println("3b. Delegated the execution of the request to the actor.\n")
    }
  }
}

val asyncHttpClient = new AsyncHttpClient
val req = Request("http://scala.playframework.org")
def printResponseSize(res: Response) = println("Got " + res.contentSize + " bytes")

// a. 限定継続なし (ブロックにコールバック)

println("1a. Asynchronously execute a block when the response is available.")
asyncHttpClient.withResponse(req) { res1: Response =>
  println("6a. The block is called.")
  printResponseSize(res1)

  // 後続の非同期処理は、このようにwithResponseをネストして表現する必要がある。
  // 処理が複雑になるとネストも深くなる・・・。
  println("7a. Asynchronously execute a block on the 2nd response.")
  asyncHttpClient.withResponse(req) { res2: Response =>
    println("8a. The 2nd block is called.")
    printResponseSize(res2)
  }
}

// b. 限定継続あり

// resetの中では非同期処理を、コールバックを使わず、同期処理的に書けることに注目
reset {
  println("1b. Await a response.")
  val res1 = asyncHttpClient.awaitResponse(req)
  // レスポンスが取得できたら、ここから継続
  println("6b. Continued with the response.")
  printResponseSize(res1)

  // 後続の非同期処理も、このようにべたに書ける。
  // コールバック方式より、処理順序がより直感的にわかりますね？
  println("7b. Await the response for the 2nd request.")
  val res2 = asyncHttpClient.awaitResponse(req)
  println("8b. Continued with the 2nd response.")
  printResponseSize(res2)
}

// 6および7が実行される前にが終わる前にここに到達します
// また、Actorが調子のいい時は4より5が先に実行されますw
println("4. End of the script.\n")
