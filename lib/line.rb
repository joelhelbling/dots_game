
class Line

  def initialize
    @squares = []
  end

  def drawn?
    @drawn
  end

  def draw(player_name)
    raise "Where exactly should I draw myself?  I got no squares!  I'm nowhere!" if @squares.size < 1
    @drawn = true
  end

  def squares
    @squares
  end

  def add_square(square)
    raise "A line can't have more than two sides in this 2D universe!" if @squares.size >= 2
    raise "Ok, mind officially blone: the same square is on both sides of this line?!" if @squares.first === square
    @squares << square
  end
end
