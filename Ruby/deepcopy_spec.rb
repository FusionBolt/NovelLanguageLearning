require 'rspec'

class Foo
    attr_accessor :x
end

describe 'CloneAndDup' do
  context 'normal usage' do
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

    it 'when singleton obj' do
      o = Object.new
      def o.x
          233
      end
      c = o.clone
      d = o.dup
      expect { c.x }.not_to raise_error
      expect { d.x }.to raise_error NoMethodError
    end
  end
end