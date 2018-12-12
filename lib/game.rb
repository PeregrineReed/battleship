class Game

  attr_reader :cpu_board,
              :cpu_ships,
              :player_board,
              :player_ships

  def initialize
    @player = Player.new
    @cpu = Computer.new
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
    generate_boards
    @cpu.setup
    ship_info
    puts @player.board.render(true)
    @player.place_ships
    turn
  end

  def generate_boards
    width = 4
    height = 4
    loop do
      print "Would you like to choose the board size? (y/n)\n>  "
      select = gets.chomp.downcase
      if select == 'y' || select == 'yes'
        loop do
          print "Select board width (minimum 4, maximum 26):\n>  "
          width = gets.chomp.to_i
          print "Select board height (minimum 4, maximum 26):\n>  "
          height = gets.chomp.to_i
          if (width < 4 || height < 4) || (width > 26 || height > 26)
            puts "Sorry, those dimensions are invalid. Please enter a valid board size."
          else
            break
          end
        end
        break
      elsif select == 'n' || select == 'no'
        puts "In that case, we'll play on a 4 x 4 board"
        break
      else
        puts "I'm sorry that doesn't answer my question."
      end

  end

    @player.customize_board(width, height)
    @cpu.customize_board(width, height)
  end

  def ship_info
    num_spelling = { 1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 6 => "six" }

    puts """I have laid out my ships on the grid.
    You now need to lay out your two ships."""
    @player.ships.each do |ship|
      ship_length = num_spelling[ship.length]
      if ship == @player.ships.last
        print "and the #{ship.name} is #{ship_length} units long.\n"
      elsif ship == @player.ships.first
        print "The #{ship.name} is #{ship_length} units long "
      else
        print ", the #{ship.name} is #{ship_length} units long"
        puts "The Cruiser is two units long and the Submarine is three units long."
      end
    end
  end


  def display_boards
    #variable '=' based on board size
    puts "#{'=' * (@cpu.board.cells.values.last.coordinate[1..-1].to_i + 6)}COMPUTER BOARD#{'=' * (@cpu.board.cells.values.last.coordinate[1..-1].to_i + 6)}"
    puts @cpu.board.render
    puts "#{'=' * (@cpu.board.cells.values.last.coordinate[1..-1].to_i + 7)}PLAYER BOARD#{'=' * (@cpu.board.cells.values.last.coordinate[1..-1].to_i + 7)}"
    puts @player.board.render(true)
    print "Enter the coordinate for your shot:\n>  "
    shots_fired
  end

  def turn
    # Tracking turn count?
    loop do
      if end_game?
        end_game
        break
      end
      display_boards
    end
  end

  def end_game?
    if @cpu.health == 0 || @player.health == 0
      true
    else
      false
    end
  end


  def end_game
    puts "You won!" if @cpu.health == 0
    puts "I won!" if @player.health == 0
    @player = Player.new
    @cpu = Computer.new
  end

  def shots_fired
    loop do
      input = gets.chomp.upcase
      if @cpu.board.valid_coordinate?(input)
        player = @player.board.cells
        cpu = @cpu.board.cells
        unfired_at = player.keys - @cpu.shots
        cpu_input = unfired_at.sample

        @player.shots << input
        cpu[input].fire_upon

        report_results(cpu, input)

        if end_game?
          break
        end

        cpu_shot = player[cpu_input].fire_upon
        @cpu.shots << cpu_input

        report_results(player, cpu_input)

        break
      elsif @player.shots.include?(input)
        puts "You already fired at #{input}!"
        print "Please enter a valid coordinate:\n>  "
      else
        print "Please enter a valid coordinate:\n>  "
      end
    end
  end

  def report_results(board, cell)
    if board == @cpu.board.cells
      current_player = "Your"
    elsif board == @player.board.cells
      current_player = "My"
    end

    puts "#{current_player} shot on #{cell} was a #{hit?(board, cell)}"
  end

  def hit?(board, cell)
    if board == @cpu.board.cells
      current_player = "You"
      opposing_player = "my"
    elsif board == @player.board.cells
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
