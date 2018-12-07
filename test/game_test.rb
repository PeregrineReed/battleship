require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/board'
require './lib/cell'
require './lib/ship'

class GameTest < Minitest::Test

  def setup
    @game = Game.new

  def test_it_exists
    assert_instance_of Game, @game
  end

end
