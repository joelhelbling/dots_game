require File.dirname(__FILE__) + '/line'

class Square
  attr_accessor :owner

  def initialize(lines_hash={}, &block)
    block ||= lambda { Line.new }
    @lines_hash = lines_hash
    [:north, :east, :south, :west].each do |direction|
      @lines_hash[direction] ||= block.call
    end
    raise "This square is a cylinder: same line on both sides!" unless lines_all_distinct?
    @lines_hash.values.each do |line|
      line.add_square self
    end
  end

  def lines_hash
    @lines_hash
  end

  def lines
    @lines_hash.values
  end

  def north_line; lines_hash[:north]; end
  def east_line;  lines_hash[:east];  end
  def south_line; lines_hash[:south]; end
  def west_line;  lines_hash[:west];  end

  def borders_drawn
    lines.select {|line| line.drawn?}.size
  end

  private

  def lines_all_distinct?
    comparable_lines = lines.clone
    while comparable_lines.size > 1 do
      first_line = comparable_lines.shift
      comparable_lines.each do |other_line|
        return false if first_line === other_line
      end
    end
    true
  end

end
