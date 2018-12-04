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

  def test_ship_can_be_placed_in_cell
    @cell.place_ship(@cruiser)
    assert_instance_of Ship, @cell.ship
    assert_same @cruiser, @cell.ship
    refute_equal true, @cell.empty?
  end

  def test_cell_default_is_not_fired_upon
    refute_equal true, @cell.fired_upon?
  end

  def test_cell_can_be_fired_upon
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
  end

  def test_ship_health_decreases_when_cell_is_fired_upon
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    # require 'pry';binding.pry
    assert_equal 2, @cell.ship.health
  end

  def test_that_render_defaults_to_a_dot
    assert_equal '.', @cell.render
  end

  def test_that_firing_on_an_empty_cell_renders_m
    assert_equal true, @cell.empty?
    @cell.fire_upon
    assert_equal 'M', @cell.render
  end

end
