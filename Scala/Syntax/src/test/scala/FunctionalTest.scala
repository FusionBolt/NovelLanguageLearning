import org.scalatest.BeforeAndAfter
import org.scalatest.funspec.AnyFunSpec

class Functional extends BaseSpec {

  describe("param") {
    var out = List[String]()
    before {
      out = List()
    }

    def callByName(a: => Int) = {
      out = out :+ "callByName"
      var n = a
    }

    def callByNameNotRun(a: => Int) = {
      out = out :+ "callByName"
    }

    def callByValue(a: Int): Int = {
      out = out :+ "callByValue"
      a
    }

    it("not use arg") {
      callByNameNotRun(callByValue(2))
      assert(out == List("callByName"))
    }

    it("use arg") {
      callByName(callByValue(2))
      assert(out == List("callByName", "callByValue"))
    }
  }

  describe("currying") {
    def carrying(a: Int)(b: Int): Int = {
      a + b
    }

    it("ok") {
      assert(3 == carrying(1)(2))
    }

    def carryingMultiFn(a: => Int)(b: => Int): Int = {
      a + b
    }

    it("multiFn") {
      val res1 = carryingMultiFn { 1 } { 2 }
      val res2 = carryingMultiFn (1) { 2 }
      val res3 = carryingMultiFn { 1 } (2)
      assert(res1 == 3)
      assert(res2 == 3)
      assert(res3 == 3)
    }
  }

  describe("partial function") {
    val negativeOrZeroToPositive: PartialFunction[Int, Int] = {
      case x if x <= 0 => Math.abs(x)
    }

    val positiveToNegative: PartialFunction[Int, Int] = {
      case x if x > 0 => -1 * x
    }

    val swapSign: PartialFunction[Int, Int] = {
      positiveToNegative orElse negativeOrZeroToPositive
    }

    val printIfPositive: PartialFunction[Int, Unit] = {
      case x if x > 0 => println(x)
    }

    it("ok") {
      (swapSign andThen printIfPositive)(-1)
    }


    it("collect") {
      val l1 = List(1, 2, 12) collect { case i: Int => i > 10 }
      val l2 = List(1, 2, 12) filter { case i: Int => i > 10 }
      println(l1)
      println(l2)
    }
  }

  describe("namedParam") {
    def f(a: Int, b: Int): Int = a + b
    it("ok") {
      assert(f(a = 1, b = 2) == 3)
    }
  }

  describe("call without parentheses") {
    def addOne(x: Int, y: Int) = x + 1
    it("ok") {
    }
  }
}
