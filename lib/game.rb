require 'pry'
class Game

  attr_reader :computer_board,
              :computer_ships,
              :player_board,
              :player_ships

  def initialize
    @computer_board = Board.new
    @computer_ships = []
    @player_board = Board.new
    @player_ships = []
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
  end

end
