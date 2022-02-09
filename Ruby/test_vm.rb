s = <<SRC
def f(a, b)
  if a > 1
    return 2
  end
  a + b
end
t = foo
a = f(1, 2)
def foo
 a = 3 * 2
end

SRC

put_str = <<SRC
  puts 'str'
  puts 2
SRC

mem_method = <<SRC
def f1
  9
end
class S
  def initialize
    9
  end

  def f1
    9
  end
end
m = f1
a = S.new()
a.initialize
a.f1
SRC
inst = RubyVM::InstructionSequence.compile(mem_method)
puts inst
puts inst.disasm

def f(a, b)
  if a > 1
    return 2
  end
  a + b
end
puts Kernel.method(:f)
a = f(1, 2)
def foo
  a = 3 * 2
end
t = foo