import scala.reflect.runtime.{universe => ru}

class Reflection extends BaseSpec {
  describe("get loader") {
    it("ok") {
      val mirror: ru.Mirror = ru.runtimeMirror(getClass.getClassLoader)
      val loader = getClass.getClassLoader
    }
  }
}
