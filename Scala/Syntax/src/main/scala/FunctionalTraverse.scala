import cats.implicits._


trait MyFunctor[T[_]] {
  def map[A, B](fa: T[A])(f: A => B): T[B]
}

class MyFList[T](var list: List[T]) extends MyFunctor[MyFList] {
  override def map[T, B](fa: MyFList[T])(f: T => B): MyFList[B] = MyFList(fa.list.map(f))

  def traverse[U](f: T => U): MyFList[U] = {
    map(this)(f)
  }
}

class FTreeNode[T](var value: T, var left: Option[FTreeNode[T]] = None, var right: Option[FTreeNode[T]] = None) {
}
implicit val traverseTree: MyFunctor[FTreeNode] = new MyFunctor[FTreeNode] {
  override def map[T, B](fa: FTreeNode[T])(f: T => B): FTreeNode[B] = {
    FTreeNode(f(fa.value), fa.left.map(x => map(x)(f)), fa.right.map(x => map(x)(f)))
  }
}


trait MyApplicative[T[_]] {
  def pure[A](a: A): T[A]
  def ap[A, B](fa: T[A])(f: T[A => B]): T[B]
}
