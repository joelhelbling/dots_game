
class Player
  attr_reader :name

  def initialize(name=nil)
    raise "You must supply a name for each player" if name.nil?
    @name = name
  end

  def to_s
    @name
  end

  def pick_line_from(args=[])
    raise StrategyNotDefinedError.new
  end

end

class StrategyNotDefinedError < StandardError
  def initialize
    @message = "Your player must implement a #pick_line_from method which accepts an array of lines"
  end
end
