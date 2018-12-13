class Computer

  attr_reader :board,
              :ships,
              :shots_taken

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @sub = Ship.new("Submarine", 2)
    @ships = [@cruiser, @sub]
    @shots_taken = []
  end

  def customize_board(height, width)
    @board = Board.new(height: height, width: width)
  end

  def health
    ships = @ships.map do |ship|
      ship.health
    end
    ships.sum
  end

  def setup
    all_rows = @board.cells.values.group_by do |cell|
      cell.coordinate[0]
    end

    all_columns = @board.cells.values.group_by do |cell|
      cell.coordinate[1..-1]
    end
    axes = [all_rows, all_columns]

    @ships.each do |ship|
      loop do
        axis = axes.sample.values.shuffle
        cell = axis.first.shuffle[0]
        placement = nil
        axis.first.each_cons(ship.length) do |cells|
          placement = cells if cells.include?(cell)
        end
        coordinates = placement.map do |cell|
          cell.coordinate
        end
        if @board.valid_placement?(ship, coordinates)
          @board.place(ship, coordinates)
          break
        end
      end
    end
  end

end
