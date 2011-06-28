require File.dirname(__FILE__) + '/../../lib/dots_game'

describe DotsGame do
  before :each do
    @game = DotsGame.new
  end

  it 'has a board' do
    lambda { @game.board }.should_not raise_error
  end

  it 'can tell if the game is over' do
    @game.should_not be_over
    @game.board.squares.each { |s| s.owner = :bob }
    @game.should be_over
  end

  it 'can return the next player' do
    @game.pick_next_player.should be_true
  end

  specify 'often the next player will be different from the current player' do
    player1 = @game.pick_next_player
    @game.pick_next_player.should_not == player1
  end
end
