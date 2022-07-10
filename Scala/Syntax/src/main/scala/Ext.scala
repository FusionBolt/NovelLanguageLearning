def ext = {
  println(List(A()).n)
}

class A:
  def f = 1

extension (l: List[A])
  def n = 2
