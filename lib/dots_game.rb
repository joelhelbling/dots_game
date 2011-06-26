
class DotsGame
  attr_reader :board

  def initialize
    @player = 0
  end

  def over?
    false
  end

  def next_player
    @player += 1
  end
end

if $0 == __FILE__
  game = DotsGame.new
  until game.over? do
    game.next_player.move
  end
  puts game.board
end
