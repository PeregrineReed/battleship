require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_display'
require './lib/player'
require './lib/computer'
require './lib/game'
require './lib/cell_generator'
require './lib/placement_validation'
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
    assert_instance_of Board, @game.cpu.board
    assert_instance_of Board, @game.player.board
  end

  def test_each_player_can_have_ships
    cpu_ships = @game.cpu.ships.all? do |ship|
      ship.class == Ship
    end
    player_ships = @game.player.ships.all? do |ship|
      ship.class == Ship
    end
    assert_equal true, cpu_ships
    assert_equal true, player_ships
  end

  def test_computer_can_place_ships
    @game.cpu.setup
    cpu_cells = @game.cpu.board.cells
    occupied_cells = cpu_cells.values.count do |cell|
      !cell.empty?
    end

    assert_equal 5, occupied_cells
  end

  def test_that_each_player_has_health
    assert_equal 5, @game.player.health
    assert_equal 5, @game.cpu.health
  end

  def test_it_starts_with_a_4_x_4_board
    assert_equal 4, @game.player.board.height
    assert_equal 4, @game.player.board.width
    assert_equal 4, @game.cpu.board.height
    assert_equal 4, @game.cpu.board.width
  end

  def test_players_can_customize_board_size
    @game.player.customize_board(12, 10)

    assert_equal 12, @game.player.board.height
    assert_equal 10, @game.player.board.width
  end

  def test_game_is_over_when_health_is_zero
    @game.cpu.ships.each do |ship|
      3.times do
        ship.hit
      end
    end

    assert_equal true, @game.end_game?
  end

end
