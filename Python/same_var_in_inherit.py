class Parent:
    def __init__(self) -> None:
        self.a = 9

    def get_parent_a(self):
        return self.a

class Child(Parent):
    def __init__(self) -> None:
        self.a = 7
        super(Child, self).__init__()

    def get_child_a(self):
        return self.a

c = Child()
print(c.get_parent_a())
print(c.get_child_a())
print(c.get_child_a() == c.get_parent_a())