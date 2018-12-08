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

end
