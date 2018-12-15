module Stats

  def customize_board(height, width)
    @board = Board.new(height: height, width: width)
  end

  def health
    ships = @ships.map do |ship|
      ship.health
    end
    ships.sum
  end

end
