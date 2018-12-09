require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/board'
require './lib/cell'
require './lib/ship'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_two_boards
    assert_instance_of Board, @game.cpu_board
    assert_instance_of Board, @game.player_board
  end

  def test_each_player_has_ships
    assert_equal [], @game.cpu_ships
    assert_equal [], @game.cpu_ships
  end

  def test_it_has_a_main_menu
    skip
    assert_equal @game.setup, @game.main_menu
  end

end
