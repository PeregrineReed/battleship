require 'pry'
class Game

  attr_reader :computer_board,
              :computer_ships,
              :player_board,
              :player_ships

  def initialize
    @cp_cruiser = Ship.new("crusier", 3)
    @cp_submarine = Ship.new("submarine", 2)
    @pl_cruiser = Ship.new("crusier", 3)
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
      if input == 'p || ''play'
        setup
      elsif input == 'q' || 'quit'
        break
      else
        failed_starts << input
      end
    end
  end

  def setup
    shuffled = @computer_board.cells.keys.shuffle
    first_coordinate = shuffled.pop
    axes = [build_horizontally(first_coordinate, shuffled), build_vertically(first_coordinate, shuffled)]
    axis = axes.sample

    @computer_board.place("cruiser", axis[0])
  end

end
