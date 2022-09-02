import scala.quoted.*


@main def main = {
  callF(1)
  timed {
    println("start")
    println("end")
  }
}
