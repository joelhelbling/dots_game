require "#{File.dirname(__FILE__)}/player"

class RandomPlayer < Player

  def pick_line_from(lines)
    lines[(rand * (lines.size - 0.0001)).to_i]
  end

end
