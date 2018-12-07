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
    @full_cells = []
  end

  def valid_coordinate?(coordinate)
    @cells.values.one? do |cell|
      cell.coordinate == coordinate
    end
  end

  def horizontal?(coordinates)

    valid_placements = []
    row_sample = coordinates[0][0]
    cell_keys = cells.keys

    cell_keys.each_cons(coordinates.length) do |cell_key|
      if cell_key.all? {|key| key[0].eql?(row_sample)}
        valid_placements << cell_key
      end
    end

    valid_placements.any? do |placement|
      placement == coordinates
    end
  end

  def vertical?(coordinates)

    cell_keys = cells.keys
    column_sample = coordinates[0][1]
    coordinate_pairs = []

    coordinates.each_cons(2) do |coordinate|
      coordinate_pairs << coordinate
    end

    coordinate_pairs.all? do |pair|
      pair[1][0].ord - pair[0][0].ord == 1 && pair[0][1] == pair[1][1]
    end

  end

  def confirmed?(coordinates)
    empty_spaces = cells.keys.reject do |coordinate|
      @full_cells.include?(coordinate)
    end
    valid_coordinates = coordinates.all? do |coordinate|
      valid_coordinate?(coordinate) && empty_spaces.include?(coordinate)
    end
    confirm_coordinates = (vertical?(coordinates) || horizontal?(coordinates)) && valid_coordinates
  end


  def valid_placement?(ship, coordinates)
    confirm_ship = coordinates.count == ship.length

    confirm_ship && confirmed?(coordinates)
  end

  def fill_cells(coordinates)
    @full_cells << coordinates
    @full_cells.flatten!
  end


  def place(ship, coordinates)
    board_cells = @cells.values

    board_cells.each do |cell|
      if cell.empty? && coordinates.one? { |coordinate| cell.coordinate == coordinate }
        cell.place_ship(ship) if valid_placement?(ship, coordinates)
      end
    end
    fill_cells(coordinates)
  end

  def render(reveal = false)
    abcs = ('A'..'Z').to_a

    all_rows = @cells.values.group_by do |cell|
      cell.coordinate[0]
    end
    all_renders = {}
    row = []
    all_rows.each do |key, value|
      all_renders[key] = value.map do |cell|
        if reveal
          cell.render(true)
        else
          cell.render
        end
      end
    end
    # require 'pry';binding.pry
    "  1 2 3 4 \nA #{all_renders[abcs[0]].join(' ')} \nB #{all_renders[abcs[1]].join(' ')} \nC #{all_renders[abcs[2]].join(' ')} \nD #{all_renders[abcs[3]].join(' ')} \n"
  end

end
