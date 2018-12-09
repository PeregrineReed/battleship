require 'pry'
class Game

  attr_reader :cpu_board,
              :cpu_ships,
              :player_board,
              :player_ships

  def initialize
    @cpu_board = Board.new
    @cpu_ships = []
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_sub = Ship.new("Submarine", 2)
    @cpu_shots = []
    @player_board = Board.new
    @player_ships = []
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_sub = Ship.new("Submarine", 2)
    @player_shots = []
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
        if input == 'p' || 'play'
          return setup
        elsif input == 'q' || 'quit'
          break
        else
          failed_starts << input
        end
      end
    end
  end

  def setup
    player_board = @player_board.render(true)
    # @cpu_ships.each do |ship|
    #   @cpu_board.place(ship, coordinates)
    # end

    num_spelling = { 1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 6 => "six" }

    puts """I have laid out my ships on the grid.
    You now need to lay out your two ships."""
    @player_ships.each do |ship|
    ship_length = num_spelling[ship.length]
    if ship == @player_ships.last
    print "and the #{ship} is {ship_length} units long.\n"
    elsif ship == @player_ships.first
    print "The #{ship} is #{ship_length} units long "
    else
    print ", the #{ship} is #{ship_length} units long"
    puts "The Cruiser is two units long and the Submarine is three units long."
    puts player_board
    @player_ships.each do |ship|
      print "Enter the squares for #{ship} (#{ship.length} spaces)\n>  "
      input = gets.chomp.upcase.squeeze(" ")
      input = input.split(" ").sort
      if !@board.valid_placement?(ship, input)
        print "Those are invalid coordinates. Please try again:\n>  "
      elsif @board.valid_placement?(ship, input)
        @player_board.place(ship, input)
      end
    end
    turn
  end

  def turn
    cpu_board = @cpu_board.render
    cpu_health = @computer_ships.map do |ship|
      ship.health
    end
    player_board = @player_board.render(true)
    player_health = @player_ships.map do |ship|
      ship.health
    end

    puts "We're all set to play!\n\n\n"
    loop do
      puts "===============COMPUTER BOARD==============="
      puts cpu_board
      puts "================PLAYER BOARD================"
      puts player_board
      print "Enter the coordinate for your shot:\n>  "
      loop do
        input = gets.chomp.upcase
        if @cpu_board.valid_coordinate?(input)
          player = @player_board.cells
          cpu = @cpu_board.cells

          unfired_at = player.keys - @cpu_shots
          cpu_input = unfired_at.sample
          cpu_shot = player[cpu_input].fire_upon

          @player_shots << input
          @cpu_shots << cpu_input
          cpu[input].fire_upon
          puts "Your shot on #{input} was a #{hit?(cpu, input)}"
          puts "My shot on #{cpu_input} was a #{hit?(player, cpu_input)}"
          break
        elsif
          # Add prompt for already having fired on a cell
          print "Please enter a valid coordinate:\n>  "
        end
      end
      if player_health.sum == 0
        puts "I won!"
      elsif cpu_health.sum == 0
        puts "You won!"
      end
    end
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
