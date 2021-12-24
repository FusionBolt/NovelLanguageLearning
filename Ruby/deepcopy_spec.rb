require 'rspec'

class Foo
  attr_accessor :x
end

describe 'CloneAndDup' do
  context 'normal usage' do
    # in simple case, clone and dup are same result
    it 'clone' do
      a = Foo.new
      a.x = 1
      b = a.clone
      b.x = 2
      expect(a.x).not_to eq b.x
    end

    it 'dup' do
      a = Foo.new
      a.x = 1
      b = a.dup
      b.x = 2
      expect(a.x).not_to eq b.x
    end
  end

  context 'when singleton obj' do
    before do
      @o = Object.new
      def @o.x
        233
      end
      c = @o.clone
      d = @o.dup
    end

    it 'clone is ok' do
      expect { c.x }.not_to raise_error
    end

    it 'dup is no method error' do
      expect { d.x }.to raise_error NoMethodError
    end
  end
end