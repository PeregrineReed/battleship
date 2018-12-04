require "minitest/autorun"
require "minitest/pride"
require "./lib/ship"
require "./lib/cell"

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_cell_class_exists
    assert_instance_of Cell, @cell
  end

  def test_cell_has_coordinates
    assert_equal "B4", @cell.coordinate
  end

  def test_cell_starts_empty
    assert_nil @cell.ship
    assert_equal true, @cell.empty?
  end

  def test_ships_can_be_placed_in_cell
    @cell.place_ship(@cruiser)
    assert_instance_of Ship, @cell.ship
    assert_same @cruiser, @cell.ship
  end

end
