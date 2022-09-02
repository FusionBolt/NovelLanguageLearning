import scala.quoted.{Expr, Quotes, Type}
import scala.reflect.runtime.universe as ru

class Reflection extends BaseSpec {
  describe("get loader") {
    it("ok") {
      val mirror: ru.Mirror = ru.runtimeMirror(getClass.getClassLoader)
      val loader = getClass.getClassLoader
    }
  }
}
