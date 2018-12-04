require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_ship_exists
    assert_instance_of Ship, @cruiser
  end

  def test_ship_has_name
    assert_equal "Cruiser", @cruiser.name
  end

  def test_ship_has_different_name
    assert_equal "Submarine", @submarine.name
  end

  def test_ship_has_health
    assert_equal 3, @cruiser.health
  end

  def test_ship_length_is_equal_to_starting_health
    assert_equal 3, @cruiser.length
    assert_equal 2, @submarine.length 
  end

end
