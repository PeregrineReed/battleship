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
    self.cells.values.one? do |cell|
      cell.coordinate == coordinate
    end
  end

  def valid_horizontal(coordinates)
    placement_validator = []
    horizontal = coordinates[0][0]

    cells.keys.each_cons(coordinates.length) do |cell_key|
      if cell_key.all? {|element| element[0].eql?(horizontal)}
        placement_validator << cell_key
      end
    end

    placement_validator.any? do |placement|
      placement == coordinates
    end
  end

  def valid_placement?(ship, coordinates)
    if coordinates.count == ship.length && ship.class == Ship
      if valid_horizontal(coordinates)
        true
      end

    else
      false
    end
  end

end
