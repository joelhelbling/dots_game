require File.dirname(__FILE__) + '/board'

class DotsGame
  attr_reader :board

  def initialize(players=[:random, :random])
    @board = Board.new
    @players = [:bob, :jan] #players.map do |player_type|
      #require "players/#{player_type}"
      #eval "#{player_type.capitalize}.new"
    #end
    @next_player = @players.first
  end

  def over?
    board.unclaimed_squares.size == 0
  end

  def pick_next_player
    @next_player = (@players.first === @next_player) ? @players.last : @players_first
  end

  def run
    until game.over? do
      player = pick_next_player
      next_line = player.pick_a_line from @board.available_lines
      next_line.draw player
    end
    puts game.board
  end
end

if $0 == __FILE__
  DotsGame.new.run
end
