class Board
  attr_reader :cells,
              :width,
              :height

  def initialize(width: 4, height: 4)
    @width = width
    @height = height
    @cells = cell_generator#{
    #   "A1" => Cell.new("A1"),
    #   "A2" => Cell.new("A2"),
    #   "A3" => Cell.new("A3"),
    #   "A4" => Cell.new("A4"),
    #   "B1" => Cell.new("B1"),
    #   "B2" => Cell.new("B2"),
    #   "B3" => Cell.new("B3"),
    #   "B4" => Cell.new("B4"),
    #   "C1" => Cell.new("C1"),
    #   "C2" => Cell.new("C2"),
    #   "C3" => Cell.new("C3"),
    #   "C4" => Cell.new("C4"),
    #   "D1" => Cell.new("D1"),
    #   "D2" => Cell.new("D2"),
    #   "D3" => Cell.new("D3"),
    #   "D4" => Cell.new("D4")
    # }
    @full_cells = []
  end

  def cell_generator
    # hash of number keys and corresponding letter values
    abcs =('A'..'Z').to_a
    nums = (1..26).to_a
    num_letter = {}
    nums.zip(abcs).each do |pair|
      num_letter[pair[0]] = pair[1]
    end

    width = num_letter[@width]
    height = @height.to_i


    x_axis = ('A'..width).to_a
    y_axis = (1..height).to_a

    hash = {}
    counter = 0
    x_axis.each do |letter|

      y_axis * y_axis.length.times do
        coordinate = letter + y_axis[counter].to_s
        hash[coordinate] = Cell.new(coordinate)
        counter += 1
        counter = 0 if counter == y_axis.length
      end
    end
    hash
  end

  def valid_coordinate?(coordinate)
    @cells.values.one? do |cell|
      cell.coordinate == coordinate && !cell.fired_upon?
    end
  end

  def horizontal?(coordinates)

    cell_keys = cells.keys
    row_sample = coordinates[0][0]
    coordinate_pairs = []

    coordinates.each_cons(2) do |coordinate|
      coordinate_pairs << coordinate
    end

    coordinate_pairs.all? do |pair|
      pair[1][1..-1].to_i - pair[0][1..-1].to_i == 1 && pair[0][0] == pair[1][0]
    end
  end

  def vertical?(coordinates)

    cell_keys = cells.keys
    column_sample = coordinates[0][1..-1]
    coordinate_pairs = []

    coordinates.each_cons(2) do |coordinate|
      coordinate_pairs << coordinate
    end

    coordinate_pairs.all? do |pair|
      pair[1][0].ord - pair[0][0].ord == 1 && pair[0][1..-1] == pair[1][1..-1]
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
    all_rows.each do |row, coordinates|
      all_renders[row] = coordinates.map do |cell|
        if reveal
          cell.render(true)
        else
          cell.render
        end
      end
    end

    num_header = all_rows.values.first.map do |cell|
      cell.coordinate[1..-1]
    end

    header = "  #{num_header[0..8].join("  ")} #{num_header[9..-1].join(" ")} \n"
    counter = -1
    board = all_rows.keys.map do |row|
      counter += 1
      "#{row} #{all_renders[abcs[counter]].join('  ')} \n"
    end
     header + board.join
  end

end
