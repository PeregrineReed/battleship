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
    @cp_ships = [@cp_cruiser, @cp_submarine]
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

  # def setup
  #   shuffled = @computer_board.cells.keys.shuffle
  #   first_coordinate = shuffled.pop
  #   ship_coordinates = []
  #   ship_coordinates << first_coordinate
  #
  # end
  def setup
    axes = ["horizontal", "vertical"]
      @computer_ships.each do |ship|
        first_coordinate = @computer_board.cells.keys.sample
        axis = axes.sample

        if axis == "horizontal"
          valid_horizontal_placements = []
          @computer_board.cells.keys.each do |coordinate|
            if coordinate.chars[0] == first_coordinate.chars[0]
              unless coordinate == first_coordinate
                valid_horizontal_placements << coordinate
              end
            end
          end
        else
          valid_vertical_placements = []
          @computer_board.cells.keys.each do |coordinate|
            if coordinate.chars[1] == first_coordinate.chars[1]
              unless coordinate == first_coordinate
                valid_vertical_placements << coordinate
              end
            end
          end
        end

        ship_placement = []
        ship_placement << first_coordinate
        binding.pry
        until @computer_board.valid_placement?(ship, ship_placement) do
          ship.cells_needed.times do
            ship_placement << @computer_board.cells.keys
          end
        end
        @computer_board.place(ship, ship_placement)
      end
  end

  # last_range = first_coordinate[1].ord + ship.length
  # first_range = first_coordinate[1].ord - ship.length
  # # valid_horiz_ordinals = (first_range..last_range).to_a
  # def build_horizontally(coord, shuffled, ship_length)
  #   last_range = coord[1].ord + @cp_cruiser.length
  #   first_range = coord[1].ord - @cp_cruiser.length
  #   valid_horiz_ordinals = (first_range..last_range).to_a
  #   valid_horizontal_placements = []
  #
  #   shuffled.each do |coordinate|
  #     if coordinate.chars[0] == coord.chars[0]
  #       valid_horizontal_placements << coordinate
  #     end
  #   end
  #     valid_horizontal_placements.each_cons(ship_length - 1) do |ship|
  #       if (ship << coord).sort! == horiztontal?
  #       end
  #     end
  # end


end
