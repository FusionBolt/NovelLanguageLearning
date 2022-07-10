
def testt = {
  case class Config(port: Int, baseUrl: String)

  def renderWebsite(path: String)(using c: Config): String =
    "<html>" + renderWidget(List("cart")) + "</html>"

  //  def renderWebsite(path: String)(using Config): String =
  //    "<html>" + renderWidget(List("cart")) + "</html>"
  def renderWidget(items: List[String])(using c: Config): String = "widget!!"

  val config = Config(8080, "docs.scala-lang.org")

  //  this is the type that we want to provide the
  //  canonical value for
  //    vvvvvv
  given Config = config

  renderWebsite("/home")
  renderWebsite("/home")(using config)

  // todo: array[T] translate to extensions

  def testGiven(using name: String): String = name
  //  given name: String = "test"

  def renderText(using c: String): String = "widget!!"

  given String = "mole"

  renderText
  renderText(using "hello")
}


def givenAimbl = {
  def testGiven(using name: String): String = name
  //  given name: String = "test"

  def renderText(using c: String): String = "widget!!"

  given String = "mole"

  renderText
  renderText(using "hello")
}

@main def f = {
  val r = getResult[DomTreeAnalysis](Fn())
  r.ok
}


trait Ord[T]:
  def compare(x: T, y: T): Int

  def lteq(x: T, y: T): Boolean = compare(x, y) < 1

object Ord:
  //  given intOrd: Ord[Int] =
  //    new Ord[Int]:
  //      def compare(x: Int, y: Int) = if x == y then 0 else if x > y then 1 else -1

  given intOrd: Ord[Int] with
    def compare(x: Int, y: Int) = if x == y then 0 else if x > y then 1 else -1

  given stringOrd: Ord[String] with
    def compare(s: String, t: String) = s.compareTo(t)



def isort[T](xs: List[T])(using ord: Ord[T]): List[T] =
  if xs.isEmpty then Nil
  else insert(xs.head, isort(xs.tail))
def insert[T](x: T, xs: List[T])
             (using ord: Ord[T]): List[T] =
  if xs.isEmpty || ord.lteq(x, xs.head) then x :: xs
  else xs.head :: insert(x, xs.tail)


case class DomTree() {
  def ok = 1
}

trait Analysis:
  type ResultT
  def run(): ResultT

case class DomTreeAnalysis() extends Analysis:
  type ResultT = DomTree
  def run(): DomTree = DomTree()

object Analysis:
  given DomTreeAnalysis with
    override type ResultT = DomTree

case class Fn()
def getResult[T](fn: Fn)(using analysis: Analysis): analysis.ResultT = {
  analysis.run()
}