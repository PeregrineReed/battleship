class Player

  include Stats

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

  def place_ships
    @ships.each do |ship|
      print "Enter the squares for #{ship.name} (#{ship.length} spaces)\n>  "
      loop do
        input = gets.chomp.upcase.squeeze(" ")
        input = input.split(" ").sort_by { |cell| cell.length }
        if !@board.valid_placement?(ship, input)
          print "Those are invalid coordinates. Please try again:\n>  "
        elsif @board.valid_placement?(ship, input)
          @board.place(ship, input)
          break
        end
      end
    end
    puts "\nWe're all set, let's play BATTLESHIP!\n\n\n"
  end

end
