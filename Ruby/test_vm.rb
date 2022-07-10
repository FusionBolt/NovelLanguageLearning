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

class F1
  def value
    1
  end
end

class F2 < F1
  def value
    super
  end
end

puts F2.new.value
call_parent = <<SRC
class F1
  def value
    1
  end
end

class F2 < F1
  def value
    super
  end
end

F2.new.value
SRC

member_var = <<SRC
class Parent
  def initialize
    @a = 1
  end
end

class FFF < Parent
  attr_reader :a
  def initialize
    @a + @a
    @a = 3
    puts @a
  end

end

puts FFF.new
SRC

cond = <<SRC
a = 4
if a == true
  a = a * 2
elsif a > 6
  a = a * 4
else
  a = a * 6
end
SRC
inst = RubyVM::InstructionSequence.compile(cond)
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

class FFF
  attr_reader :a

  def initialize
    @a = 1
  end

end

puts FFF.new

module A

end
module B

end

class MA
  include A
  include B
end

# puts MA.ancestors
# puts 'sss'
# puts MA.superclass
# puts 'sss'
# puts MA.methods
#
def ffff
  a = 1
  while a < 3
    a = a + 1
  end
end

puts "ok"
puts ffff.nil?