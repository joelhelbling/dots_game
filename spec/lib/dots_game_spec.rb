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

  it 'knows the score for each player' do
    @game.board.squares.each { |s| s.owner = :jan }
    @game.board.squares.first.owner = :bob
    @game.board.squares.last.owner = :bob
    @game.score_for(:bob).should == 2
    @game.score_for(:jan).should == 7
  end

  describe 'displaying the score' do
    before :each do
      (0..3).each { |i| @game.board.squares[i].owner = :bob }
      (4..8).each { |i| @game.board.squares[i].owner = :jan }
      @score_text = @game.display_score
    end

    it 'can display the score' do
      @score_text.should include('bob has 4 squares')
      @score_text.should include('jan has 5 squares')
    end

    it 'should display the winner first' do
      @score_text.should match(/^jan.*bob/m)
    end

  end
end
