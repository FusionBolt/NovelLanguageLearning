import scala.quoted.*

//transparent inline def quotes(using inline q: Quotes): q.type = q

inline def callF(inline x: Int): Int = {
  ${macroF('{x})}
}

def macroF(x: Expr[Int])(using Quotes): Expr[Int] =
  import quotes.reflect.* // Import `Tree`, `TypeRepr`, `Symbol`, `Position`, .....
  val tree: Tree = x.asTerm
  given Printer[Tree] = Printer.TreeStructure
  println(tree.show)
  println(tree.show(using Printer.TreeStructure))
  x

inline def timed[T](inline expr: T):T = ${timedImpl('expr)}

def timedImpl[T: Type](expr: Expr[T])(using Quotes): Expr[T] = {
  import quotes.reflect.*
  val pos = Position.ofMacroExpansion
  val path = pos.sourceFile.jpath.toString
  val start = pos.start
  val end = pos.end
  val startLine = pos.startLine
  val endLine = pos.endLine
  val startColumn = pos.startColumn
  val endColumn = pos.endColumn
  val sourceCode = pos.sourceCode
  val tree: Tree = expr.asTerm
  println("not exec")
  '{
   val start = System.currentTimeMillis();
    try $expr
   finally {
     val end = System.currentTimeMillis()
     val exprAsStr = ${Expr(expr.show)}
     val pathAsStr = ${Expr(path)}
     println("what")
     println(s"Evaluating $exprAsStr: ${end - start} ms. Path:${pathAsStr}")
   }
  }
}