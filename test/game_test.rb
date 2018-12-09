require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/board'
require './lib/cell'
require './lib/ship'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
    @shuffled = @game.computer_board.cells.keys.shuffle
    @random_coord = @shuffled.pop
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_two_boards
    assert_instance_of Board, @game.computer_board
    assert_instance_of Board, @game.player_board
  end

  def test_each_player_can_have_ships
    skip
    assert_equal [], @game.computer_ships
    assert_equal [], @game.computer_ships
  end

  def test_computer_can_place_ships
    @game.setup
    assert_equal 5, @game.computer_board.cells.values.count {|cell|
      !cell.empty?
    }
  end
  # def test_it_has_a_main_menu
  #   assert_equal @game.setup, @game.main_menu
  # end

  # def test_computer_can_place_ships
  #   @game.build_horizontally(@random_coord, @shuffled)
  #
end
