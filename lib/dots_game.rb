lib = File.expand_path(File.dirname(__FILE__))
require "#{lib}/board"
require "#{lib}/players/random_player"
require 'active_support/inflector'

class DotsGame
  attr_reader :board

  def initialize(players={'Jan' => :random_player, 'Bob' => :random_player})
    @board = Board.new
    @players = []
    players.each_pair do |name, player_type|
      require "#{File.dirname(__FILE__)}/players/#{player_type}"
      @players << player_type.to_s.camelize.constantize.new(name)
    end
    @next_player = @players.first
  end

  def lines_per_player
    @board.squares.group_by { |square| square.owner }
  end

  def score_for(player)
    lines_per_player[player].size
  end

  def pick_next_player
    @next_player = (@players.first === @next_player) ? @players.last : @players.first
  end

  def display_score
    lines_per_player.sort_by{|p| p.last.size}.reverse.map do |p|
      "#{p.first} has #{p.last.size} squares"
    end.join("\n")
  end

  def over?
    board.unclaimed_squares.size == 0
  end

  def run
    until over? do
      player = pick_next_player
      next_line = player.pick_line_from @board.available_lines
      next_line.draw player
    end
    puts board.render
    puts display_score
  end
end

if $0 == __FILE__
  DotsGame.new.run
end
