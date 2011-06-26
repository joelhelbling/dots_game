
class Square
  attr_accessor :owner

  def initialize(lines={})
    @lines = lines
    @lines[:north] ||= "a brand new north"
    @lines[:east]  ||= :'bar'
    @lines[:south] ||= :'baz'
    @lines[:west]  ||= :'bo'
  end

  def lines
    @lines
  end

  def north_line
    lines[:north]
  end

  def east_line
    lines[:east]
  end

  def south_line
    lines[:south]
  end

  def west_line
    lines[:west]
  end

end
