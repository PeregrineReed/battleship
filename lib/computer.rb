module Computer

  def computer_attr
    @cpu_board = Board.new
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_sub = Ship.new("Submarine", 2)
    @cpu_ships = [@cpu_cruiser, @cpu_sub]
    @cpu_shots = []
  end

  def cpu_health
    ships = @cpu_ships.map do |ship|
      ship.health
    end
    ships.sum
  end

  def cpu_setup
    occupied_spaces = []
    @cpu_ships.each do |ship|
      open_spaces = @cpu_board.cells.keys - occupied_spaces
      random_coordinate = open_spaces.sample
      axes = [horizontal(random_coordinate), vertical(random_coordinate)]
      ship_placement = []

      until @cpu_board.valid_placement?(ship, ship_placement)
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
      @cpu_board.place(ship, ship_placement)
        ship_placement.each do |coordinate|
          occupied_spaces << coordinate
        end
    end
  end

  def horizontal(random_coordinate)
    valid_horizontal_placements = []
    @cpu_board.cells.keys.each do |coordinate|
      if coordinate[0] == random_coordinate[0]
         valid_horizontal_placements << coordinate
      end
    end
    valid_horizontal_placements.shuffle
  end

  def vertical(random_coordinate)
    valid_vertical_placements = []
    @cpu_board.cells.keys.each do |coordinate|
      if coordinate[1..-1] == random_coordinate[1..-1]
          valid_vertical_placements << coordinate
      end
    end
    valid_vertical_placements.shuffle
  end

end
