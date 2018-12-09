require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_starts_with_cells
      all_cells = @board.cells.values.all? do |cell|
        cell.class == Cell
      end
    assert_equal true, all_cells
  end

  def test_it_can_can_validate_coordinates
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    @board.cells.values[0].fire_upon
    assert_equal false, @board.valid_coordinate?("A1")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
  end

  def test_it_validates_placement_equal_to_a_ships_length
    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "A2", "A3"])
  end

  def test_it_validates_placement_only_when_consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "B1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
  end

  def test_it_doesnt_validate_coordinates_outside_the_board
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A4", "A5"])
    assert_equal false, @board.valid_placement?(@cruiser, ["C1", "D1", "E1"])
  end

  def test_diagonal_placements_return_false
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_a_ship_is_placed_in_consecutive_cells_equal_to_length
    cell_1 = @board.cells["B1"]
    cell_2 = @board.cells["C1"]
    cell_3 = @board.cells["D1"]

    @board.place(@cruiser, ["B1", "C1", "D1"])

    assert_equal @cruiser, cell_1.ship
    assert_equal @cruiser, cell_2.ship
    assert_equal @cruiser, cell_3.ship
    assert_equal cell_1.ship, cell_2.ship
  end

  def test_ships_cant_overlap_coordinates
    @board.place(@cruiser, ["B1", "C1", "D1"])
    assert_equal false, @board.valid_placement?(@submarine, ["B1", "B2"])
  end

  def test_it_can_render_cells
    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", @board.render
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n", @board.render(true)
  end

end
