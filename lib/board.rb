class Board

  include CellGenerator
  include PlacementValidation

  attr_reader :cells,
              :height,
              :width

  def initialize(height: 4, width: 4)
    @height = height
    @width = width
    @cells = cell_generator
    @full_cells = []
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

    counter = -1
    board = all_rows.keys.map do |row|
      counter += 1
      "#{row} #{row_renders[abcs[counter]].join('  ')} \n"
    end
     board_header + board.join
  end

  def all_rows
    rows = @cells.values.group_by do |cell|
      cell.coordinate[0]
    end
    rows
  end

  def board_header
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
  end

end
