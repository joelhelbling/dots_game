require File.dirname(__FILE__) + '/../../lib/line'

describe Line do
  before :all do
    class Square; end
  end

  before :each do
    @line = Line.new
  end

  describe 'drawing' do
    before :each do
      @line.add_square Square.new
    end

    it 'is initially un-drawn' do
      @line.should_not be_drawn
    end

    it 'has a #draw method' do
      lambda { @line.draw }.should_not raise_error(NoMethodError)
    end

    specify 'after drawing the line, it should be drawn' do
      @line.draw(:bob)
      @line.should be_drawn
    end

    specify 'cannot draw a line if it has no squares' do
      line = Line.new
      lambda { line.draw }.should raise_error
    end

  end

  describe 'has two squares' do
    it 'accepts a square' do
      lambda { @line.add_square Square.new }.should_not raise_error
    end

    it 'accepts a second square' do
      @line.add_square Square.new
      lambda { @line.add_square Square.new }.should_not raise_error
    end

    specify 'but a third square it will not accept' do
      @line.add_square Square.new
      @line.add_square Square.new
      lambda { @line.add_square Square.new }.should raise_error
    end

    it 'also freaks out if you give it the same square twice!' do
      square = Square.new
      @line.add_square square
      lambda { @line.add_square square }.should raise_error
    end

    it 'accepts a block which is called when the line is drawn' do
      foo = :bar
      line = Line.new do |line, player|
        foo = :baz
      end
      line.add_square Square.new
      foo.should == :bar
      line.draw :bob
      foo.should == :baz
    end

  end
end
