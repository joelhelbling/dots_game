require File.dirname(__FILE__) + '/../../../lib/players/player'

describe Player do
  describe '#name' do

    it 'must be constructed with a name' do
      lambda { Player.new('Bob') }.should_not raise_error
      lambda { Player.new }.should raise_error
    end

    it 'returns a name in string context' do
      player = Player.new "Dave"
      "#{player}".should == "Dave"
    end

  end

  describe 'strategy' do
    before :each do
      @player = Player.new :foo
    end

    it 'should have a #pick_line_from method' do
      lambda { @player.pick_line_from }.should_not raise_error(NoMethodError)
    end

    it 'should fail since this method must be overridden' do
      lambda { @player.pick_line_from []}.should raise_error(StrategyNotDefinedError)
    end

  end

end
