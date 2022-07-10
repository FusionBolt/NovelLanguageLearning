require 'rspec'

class Parent
  attr_reader :a

  def initialize
    @a = 9
  end

  def get_parent_a
    @a
  end
end

class Child < Parent
  attr_reader :a

  def initialize
    @a = 5
  end

  def get_child_a
    @a
  end
end

describe 'same var in inherit' do
  context '' do
    it 'succeed' do
      c = Child.new
      expect(c.get_child_a).to eq c.get_parent_a
    end
  end
end
