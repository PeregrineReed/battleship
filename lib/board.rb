class Board

  include PlacementValidation

  attr_reader :cells,
              :width,
              :height

  def initialize(width: 4, height: 4)
    @width = width
    @height = height
    @cells = cell_generator
    @full_cells = []
  end

  def cell_generator
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

    board_cells = {}
    counter = 0
    x_axis.each do |letter|

      y_axis * y_axis.length.times do
        coordinate = letter + y_axis[counter].to_s
        board_cells[coordinate] = Cell.new(coordinate)
        counter += 1
        counter = 0 if counter == y_axis.length
      end
    end
    board_cells
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

    row_renders = {}
    all_rows.each do |row, coordinates|
      row_renders[row] = coordinates.map do |cell|
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

    if num_header.length > 10
      header = "  #{num_header[0..8].join("  ")} #{num_header[9..-1].join(" ")} \n"
    elsif num_header.length == 10
      header = "  #{num_header[0..8].join("  ")} #{num_header[9]} \n"
    else
      header = "  #{num_header[0..8].join("  ")} \n"
    end

    counter = -1
    board = all_rows.keys.map do |row|
      counter += 1
      "#{row} #{row_renders[abcs[counter]].join('  ')} \n"
    end
     header + board.join
  end

end
