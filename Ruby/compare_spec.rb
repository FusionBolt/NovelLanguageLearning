class Foo1
  attr_accessor :x

  def initialize(x)
    @x = x
  end
end

class ImplEql < Foo1
  def initialize(x)
    super(x)
  end

  def eql?(other)
    @x.eql? other.x
  end
end

class ImplSame < Foo1
  def initialize(x)
    super(x)
  end

  def ==(other)
    @x == other.x
  end
end

describe 'Compare' do
  before do
    @a = Foo1.new(1)
    @b = Foo1.new(1)
  end

  context '==' do
    it 'a same obj' do
      expect(@a == @b).to be false
    end
    it 'same object' do
      c = @a
      expect(@a == c).to be true
    end
    it 'when dup' do
      d = @a.dup
      expect(@a == d).to be false
    end
  end

  context 'eql' do
    it 'normal' do

    end
  end

  context 'equal' do
    # equal should never be overridden by subclass as it is used to determine object identity
    #  a.equal?(b) if and only if a is the same object as b)
    it 'succeed' do
      expect(@a.equal? @b).to be false
    end
  end

  context 'number' do
    it 'succeed' do
      expect(1 == 1.0).to be true
      expect(1.eql? 1.0).to be false
    end
  end

  context 'override' do
    it 'eql' do
      a = ImplEql.new(1)
      b = ImplEql.new(1)
      expect(a == b).to be false
      expect(a.eql? b).to be true
    end

    it '==' do
      a = ImplSame.new(1)
      b = ImplSame.new(1)
      expect(a == b).to be true
      expect(a.eql? b).to be false
    end
  end
end
