class TestGiven extends BaseSpec {
  case class Prompt(str: String)
  // can define multi var and explicitly import one of them
  // import pkg.given
  // import pkg.{given XX, given XXX}
  // import pkg.{given XX[?]}
  // if import multi var, it will ambiguous implicit arguments
  // matched by type
  // using for select a Concrete given obj
  given prompt: Prompt = Prompt("global>")
  def output(str: String)(using p: Prompt): String = p.str + str

  describe("given") {
    it("normal") {
      assert(output("hello") == "global>hello" )
    }

    it("overload") {
      given Prompt = Prompt("local>")
      val s = output("hello")
      assert(s == "local>hello")
    }

    it("multi") {
      given prompt1: Prompt = Prompt("prompt1>")
      given prompt2: Prompt = Prompt("prompt2>")
      assert(output("hello")(using prompt1) == "prompt1>hello")
      assert(output("hello")(using prompt2) == "prompt2>hello")
    }
  }

  describe("di") {
    trait Animal
    case class Dog() extends Animal
    case class Cat() extends Animal
    given cat: Animal = Cat()
    given dog: Animal = Dog()
  }
}