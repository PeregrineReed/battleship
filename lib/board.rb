class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.values.one? do |cell|
      cell.coordinate == coordinate
    end
  end

  def row_confirm(y_axis)

    valid_placements = []
    row_sample = y_axis[0][0]
    cell_keys = cells.keys

    cell_keys.each_cons(y_axis.length) do |cell_key|
      if cell_key.all? {|key| key[0].eql?(row_sample)}
        valid_placements << cell_key
      end
    end

    valid_placements.any? do |placement|
      placement == y_axis
    end
  end

  def column_confirm(x_axis)

    cell_keys = cells.keys
    column_sample = x_axis[0][1]
    coordinate_pairs = []

    x_axis.each_cons(2) do |coordinate|
      coordinate_pairs << coordinate
    end

    coordinate_pairs.all? do |pair|
      pair[1][0].ord - pair[0][0].ord == 1 && pair[0][1] == pair[1][1]
    end

  end

  def valid_placement?(ship, coordinates)
    confirm_ship = coordinates.count == ship.length && ship.class == Ship
    valid_coordinates = coordinates.all? do |coordinate|
      valid_coordinate?(coordinate)
    end
    confirm_coordinates = (column_confirm(coordinates) || row_confirm(coordinates)) && valid_coordinates

    if confirm_ship && confirm_coordinates
        true
    else
      false
    end
  end

end
