require 'pry'

class Game

  attr_reader :computer_board,
              :computer_ships,
              :player_board,
              :player_ships

  def initialize
    @cp_cruiser = Ship.new("cruiser", 3)
    @cp_submarine = Ship.new("submarine", 2)
    @pl_cruiser = Ship.new("cruiser", 3)
    @pl_submarine = Ship.new("submarine", 2)
    @computer_board = Board.new
    @computer_ships = [@cp_cruiser, @cp_submarine]
    @player_board = Board.new
    @player_ships = [@pl_cruiser, @pl_submarine]
  end

  def main_menu
    failed_starts = []
    loop do
      if failed_starts.length > 9
        puts "\n\n\nAre you having trouble with your keyboard?\n\nDO YOU WANT TO PLAY BATTLESHIP?\n\nENTER P TO PLAY OR Q TO QUIT\n"
        input = gets.chomp
      else
        puts "\n\n\nWelcome to BATTLESHIP\n\nEnter p to play or q to quit\n"
        input = gets.chomp.downcase
      end
      if input == 'p' || input == 'play'
        setup
      elsif input == 'q' || input == 'quit'
        break
      else
        failed_starts << input
      end
    end
  end

  def setup
    occupied_spaces = []
    @computer_ships.each do |ship|
      open_spaces = @computer_board.cells.keys - occupied_spaces
      random_coordinate = open_spaces.sample
      axes = [horizontal(random_coordinate), vertical(random_coordinate)]
      axis = axes.sample

      ship_placement = []
      until @computer_board.valid_placement?(ship, ship_placement)

        axis.each do |coordinate|
          ship_placement << coordinate unless ship_placement.length == ship.length
        end
        ship_placement.sort!
      end
      @computer_board.place(ship, ship_placement)
        ship_placement.each do |coordinate|
          occupied_spaces << coordinate
        end
        # binding.pry
    end
  end

  def horizontal(random_coordinate)
    valid_horizontal_placements = []
    @computer_board.cells.keys.each do |coordinate|
      if coordinate[0] == random_coordinate[0]
         valid_horizontal_placements << coordinate
      end
    end
    valid_horizontal_placements
  end

  def vertical(random_coordinate)
    valid_vertical_placements = []
    @computer_board.cells.keys.each do |coordinate|
      if coordinate[1] == random_coordinate[1]
          valid_vertical_placements << coordinate
      end
    end
    valid_vertical_placements
  end
end
