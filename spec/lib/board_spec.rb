require File.dirname(__FILE__) + '/../../lib/board'

describe Board do
  before :each do
    @board = Board.new
  end

  it 'offers a collection of available (undrawn) lines' do
    @board.lines.size.should > 0
  end

end
