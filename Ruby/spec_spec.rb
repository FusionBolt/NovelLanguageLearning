require 'rspec'

class FooEql
  attr_accessor :x

  def initialize(x)
    @x = x
  end

  def eql?(other)
    @x.eql? other.x
  end
end

class FooEqual
  attr_accessor :x

  def initialize(x)
    @x = x
  end

  def ==(other)
    @x == other.x
  end
end

describe 'Spec' do
  context 'compare' do
    before do
      @eql_foo1 = FooEql.new(1)
      @eql_foo2 = FooEql.new(1)
      @equal_foo1 = FooEqual.new(1)
      @equal_foo2 = FooEqual.new(1)
    end

    it 'be' do
      # be -> equal?
      expect(@eql_foo1).not_to be @eql_foo2
      expect(@equal_foo1).not_to be @equal_foo2
      c = @eql_foo1
      expect(c).to be @eql_foo1
      cl = @eql_foo1.clone
      expect(cl).not_to be cl
    end

    it 'eq' do
      # eq -> ==
      expect(@eql_foo1).not_to eq @eql_foo2
      foo = @eql_foo1
      expect(@eql_foo1).to eq foo
    end

    it 'eql' do
      expect(@eql_foo1).to eql @eql_foo2
    end
  end
end
