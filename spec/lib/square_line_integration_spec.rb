lib = File.dirname(__FILE__) + '/../../lib'
require "#{lib}/square"
require "#{lib}/line"

describe Square, Line, 'integration' do
  specify 'every square should have real lines!' do
    Square.new.lines.each do |line|
      line.should respond_to(:drawn?)
    end
  end

  specify "every square's lines should own their square" do
    square = Square.new
    square.north_line.should have(1).squares
    square2 = Square.new(:north => square.south_line)
    square2.north_line.should have(2).squares
    lambda { Square.new(:north => square2.north_line) }.should raise_error
  end

  specify 'a square can tell you how many borders are drawn' do
    square = Square.new
    square.borders_drawn.should == 0
    square.north_line.draw :jan
    square.borders_drawn.should == 1
  end

end
