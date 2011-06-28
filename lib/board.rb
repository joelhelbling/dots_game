lib = File.dirname(__FILE__)
require "#{lib}/square"
require "#{lib}/line"

class Board
  attr_reader :squares, :lines

  def initialize(width=3, height=3)
    @lines = []
    @squares = []
    @width = width
    @height = height
    build_board
  end

  def build_board
    @height.times do |y|
      @width.times do |x|
        @squares << Square.new(lines_for(x,y)) do
          line_maker
        end
      end
    end
  end

  def lines_for(x,y)
    case
    when x + y == 0
      { }
    when y == 0 && x > 0
      { :west => @squares.last.east_line }
    when y > 0 && x == 0
      north_of_me = @squares[@squares.size - @width]
      { :north => north_of_me.south_line }
    else
      north_of_me = @squares[@squares.size - @width]
      west_of_me  = @squares.last
      { :north => north_of_me.south_line, :west => west_of_me.east_line }
    end
  end

  def line_maker
    line = Line.new do |line, player|
      handle_line_draw(line, player)
    end
    @lines << line
    line
  end

  def handle_line_draw(line, player)
    line.squares.each do |square|
      square.owner = player if square.complete?
    end
  end

  def available_lines
    @lines.reject {|line| line.drawn? }
  end

  def squares_for(name)
    @squares.select { |square| square.owner == name }
  end

  def unclaimed_squares
    @squares.select { |square| square.owner.nil? }
  end
end
