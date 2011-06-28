require File.dirname(__FILE__) + '/../../lib/board'

describe Board do
  before :each do
    @board = Board.new
  end

  describe "has squares" do

    specify 'at least one' do
      @board.squares.size.should >= 1
    end

    specify "the board's size can be set" do
      Board.new(3,4).should have(12).squares
      Board.new(10, 10).should have(100).squares
    end

    specify 'the board tracks the number of squares captured by each player' do
      @board.should have(0).squares_for(:bob)
      @board.squares.first.owner = :bob
      @board.should have(1).squares_for(:bob)
    end

  end

  describe "has lines" do

    specify 'at least 4' do
      @board.lines.size.should >= 4
    end

    specify 'the number of lines depends on the size of the board' do
      def calculate_lines_for(w,h)
        (w*h*2) + h + w
      end
      [[1,1], [2,3], [4,7], [21, 3], [1,30]].each do |p|
        Board.new(p.first, p.last).should have(calculate_lines_for(p.first, p.last)).lines
      end
    end

    specify 'the board tracks the available (undrawn) lines' do
      initial_line_count = @board.available_lines.size
      @board.available_lines.first.draw :bob
      @board.should have(initial_line_count - 1).available_lines
      @board.available_lines.last.draw :jim
      @board.should have(initial_line_count - 2).available_lines
    end

    specify 'the board tracks the owners (winners) of squares' do
      first_square = @board.squares.first
      first_square.owner.should be_nil
      first_square.lines.each { |l| l.draw :bob }
      first_square.owner.should == :bob
    end

    specify 'the board has a count of unclaimed squares' do
      @board.should have(9).unclaimed_squares
      @board.squares[5].owner = :bill
      @board.should have(8).unclaimed_squares
    end

    #      o       o       o       o
    #
    #
    #
    #      o-------o       o       o
    #
    #
    #
    #      o-------o       o       o
    #      |       |
    #      |  bob  |
    #      |       |
    #      o-------o       o       o
    #

  end




end
