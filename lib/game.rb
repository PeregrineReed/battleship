require 'pry'

class Game

  include Computer

  attr_reader :cpu_board,
              :cpu_ships,
              :player_board,
              :player_ships

  def initialize
    computer_attr
    player_attr
  end

  def player_attr
    @player_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_sub = Ship.new("Submarine", 2)
    @player_ships = [@player_cruiser, @player_sub]
    @player_shots = []
  end

  def reset
    computer_attr
    player_attr
  end

  def main_menu
    failed_starts = []
    loop do
      if failed_starts.length > 9
        puts "\n\n\nAre you having trouble with your keyboard?\n\nDO YOU WANT TO PLAY BATTLESHIP?\n\nENTER P TO PLAY OR Q TO QUIT\n"
        input = gets.chomp.downcase
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

    print "Select board width:\n>  "
    width_select = gets.chomp.to_i
    print "Select board height:\n>  "
    height_select = gets.chomp.to_i
    @player_board = Board.new(width: width_select, height: height_select)
    @cpu_board = Board.new(width: width_select, height: height_select)
    player_board = @player_board.render(true)

    cpu_setup
    ship_info

    puts player_board
    player_ship_placement
    turn
  end

  def ship_info
    num_spelling = { 1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 6 => "six" }

    puts """I have laid out my ships on the grid.
    You now need to lay out your two ships."""
    @player_ships.each do |ship|
      ship_length = num_spelling[ship.length]
      if ship == @player_ships.last
        print "and the #{ship.name} is #{ship_length} units long.\n"
      elsif ship == @player_ships.first
        print "The #{ship.name} is #{ship_length} units long "
      else
        print ", the #{ship.name} is #{ship_length} units long"
        puts "The Cruiser is two units long and the Submarine is three units long."
      end
    end
  end


  def render_boards
    cpu_board = @cpu_board.render
    player_board = @player_board.render(true)
    #variable '=' based on board size
    puts "#{'=' * 14}COMPUTER BOARD==============="
    puts cpu_board
    puts "================PLAYER BOARD================"
    puts player_board
    print "Enter the coordinate for your shot:\n>  "
    shots_fired
  end


  def turn
    # Tracking turn count?
    puts "We're all set to play!\n\n\n"
    loop do

      if end_game?
        end_game
        break
      end

      render_boards

    end
  end

  def end_game?
    if cpu_health == 0 || player_health == 0
      true
    else
      false
    end
  end


  def end_game
    puts "You won!" if cpu_health == 0
    puts "I won!" if player_health == 0
    reset
  end

  def shots_fired
    loop do
      input = gets.chomp.upcase
      if @cpu_board.valid_coordinate?(input)
        player = @player_board.cells
        cpu = @cpu_board.cells
        unfired_at = player.keys - @cpu_shots
        cpu_input = unfired_at.sample

        @player_shots << input
        cpu[input].fire_upon
        puts "Your shot on #{input} was a #{hit?(cpu, input)}"
        if end_game?
          break
        end

        cpu_shot = player[cpu_input].fire_upon
        @cpu_shots << cpu_input
        puts "My shot on #{cpu_input} was a #{hit?(player, cpu_input)}"
        break
      elsif @player_shots.include?(input)
        puts "You already fired at #{input}!"
        print "Please enter a valid coordinate:\n>  "
      else
        print "Please enter a valid coordinate:\n>  "
      end
    end
  end

  def player_ship_placement
    @player_ships.each do |ship|
      print "Enter the squares for #{ship.name} (#{ship.length} spaces)\n>  "
      loop do
        input = gets.chomp.upcase.squeeze(" ")
        input = input.split(" ").sort
        if !@player_board.valid_placement?(ship, input)
          print "Those are invalid coordinates. Please try again:\n>  "
        elsif @player_board.valid_placement?(ship, input)
          @player_board.place(ship, input)
          break
        end
      end
    end
  end

  def player_health
    ships = @player_ships.map do |ship|
      ship.health
    end
    ships.sum
  end

  def hit?(board, cell)
    if board == @cpu_board.cells
      current_player = "You"
      opposing_player = "my"
    elsif board == @player_board.cells
      current_player = "I"
      opposing_player = "your"
    end
    if board[cell].empty?
    "miss."
    elsif board[cell].empty? == false && board[cell].ship.health > 0
      "hit."
    elsif board[cell].empty? == false && board[cell].ship.health == 0
      "hit!\n#{current_player} sunk #{opposing_player} battleship!"
    end
  end

end
