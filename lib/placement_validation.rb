module PlacementValidation

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

end
