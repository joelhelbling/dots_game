def require_player(player)
  require "#{File.dirname(__FILE__)}/../../../lib/players/#{player}"
end

require_player :random_player
require_player :player


describe RandomPlayer do

  before :each do
    @player = RandomPlayer.new :foo
  end

  it 'should be a player' do
    @player.should be_kind_of(Player)
  end

  it 'should pick lines randomly' do
    lines = (0...100).to_a
    picks = []
    100.times { picks << @player.pick_line_from(lines) }
    picks.uniq.size.should > 20
  end

end
