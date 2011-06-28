require File.dirname(__FILE__) + '/../../lib/square'

describe Square do
  before :each do
    @square = Square.new
  end

  describe 'lines' do
    it 'has exactly four lines around it' do
      @square.lines.size.should == 4
    end

    it 'has a "north" line' do
      @square.north_line.should_not be_nil
    end

    it 'has an "east" line' do
      @square.east_line.should_not be_nil
    end

    it 'has a "south" line' do
      @square.south_line.should_not be_nil
    end

    it 'has a "west" line' do
      @square.west_line.should_not be_nil
    end

    it 'reports how many of its borders have been drawn' do
      @square.north_line.draw :bob
      @square.borders_drawn.should == 1
      @square.south_line.draw :bob
      @square.west_line.draw :bob
      @square.borders_drawn.should == 3
    end

    it 'reports when it is complete' do
      @square.north_line.draw :bob
      @square.east_line.draw :bob
      @square.south_line.draw :bob
      @square.west_line.draw :bob
      @square.should be_complete
    end
  end

  describe 'when constructed' do
    before :all do
      class Line; end
    end

    [:north, :east, :south, :west].each do |direction|
      specify "with an existing line as '#{direction}', it has that #{direction} line" do
        line = Line.new
        square = Square.new(direction => line)
        square.__send__("#{direction}_line").object_id.should == line.object_id
      end
    end

    specify 'cannot add the same line for two different borders' do
      just_one_line = Line.new
      lambda { Square.new :north => just_one_line, :south => just_one_line }.should raise_error
    end
  end

  describe 'owner' do
    it 'haz one' do
      lambda { @square.owner }.should_not raise_error
    end

    specify 'the owner should initially be nil' do
      @square.owner.should be_nil
    end

    specify 'after owner is set, it reports that owner' do
      @square.owner = :player1
      @square.owner.should == :player1
    end
  end
end
