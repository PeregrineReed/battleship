class Computer

  attr_reader :board,
              :ships,
              :shots

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @sub = Ship.new("Submarine", 2)
    @ships = [@cruiser, @sub]
    @shots = []
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
    occupied_spaces = []
    @ships.each do |ship|
      open_spaces = @board.cells.keys - occupied_spaces
      random_coordinate = open_spaces.sample
      axes = [horizontal(random_coordinate), vertical(random_coordinate)]
      ship_placement = []

      until @board.valid_placement?(ship, ship_placement)
        if ship_placement.length >= ship.length
          ship_placement.clear
          random_coordinate = open_spaces.sample
          axes = [horizontal(random_coordinate), vertical(random_coordinate)]
        end
        axis = axes.sample
        axis.each do |coordinate|
          unless occupied_spaces.include?(coordinate) || ship_placement.length >= ship.length
            ship_placement << coordinate
          end
        end
        ship_placement.sort!
      end
      @board.place(ship, ship_placement)
        ship_placement.each do |coordinate|
          occupied_spaces << coordinate
        end
    end
  end

  def horizontal(random_coordinate)
    valid_horizontal_placements = []
    @board.cells.keys.each do |coordinate|
      if coordinate[0] == random_coordinate[0]
         valid_horizontal_placements << coordinate
      end
    end
    valid_horizontal_placements.shuffle
  end

  def vertical(random_coordinate)
    valid_vertical_placements = []
    @board.cells.keys.each do |coordinate|
      if coordinate[1..-1] == random_coordinate[1..-1]
          valid_vertical_placements << coordinate
      end
    end
    valid_vertical_placements.shuffle
  end

end
