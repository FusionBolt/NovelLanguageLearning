import org.scalatest.BeforeAndAfter
import org.scalatest.funspec.AnyFunSpec

class CollectionTest extends BaseSpec {

  describe("list") {
    it("add") {
      var l = List(1, 2, 3)
      l = l :+ 1
      assert(l == List(1, 2, 3, 1))
    }
  }
}
