trait Traversable[T] {
}

def traverse[T, U](list: List[T], f: T => U): List[U] =
  list.map(f)

class MyList[T] extends Traversable[T] {
  var list = List[T]()
  def traverse[U](f: T => U): List[U] = {
    list.map(f)
  }
}

class TreeNode[T](var value: T, var left: Option[TreeNode[T]] = None, var right: Option[TreeNode[T]] = None) {
  def traverse[U](f: T => U): TreeNode[U] = {
    TreeNode(f(value), left.map(_.traverse(f)), right.map(_.traverse(f)))
  }
}

class MyTree[T](var root: TreeNode[T]) extends Traversable[T] {
  def traverse[U](f: T => U): MyTree[U] = {
    new MyTree(root.traverse(f))
  }
}

def run = {
  var myList = new MyList[Int]()
  myList.list = List(1, 2, 3)
//  myList.traverse(println)
  myList.traverse(x => {
x
  })
  var myTree = new MyTree[Int](new TreeNode(7))
  myTree.root.left = Some(TreeNode(8))
  myTree.root.right = Some(TreeNode(9))
  myTree.traverse(println)
}