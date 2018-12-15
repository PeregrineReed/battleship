module GameDisplay

  def main_menu
    failed_starts = []
    loop do
      if failed_starts.length > 9
        puts "\n\n\nAre you having trouble with your keyboard?\n\nDO YOU WANT TO PLAY BATTLESHIP?\n\nENTER P TO PLAY OR Q TO QUIT\n"
        select = input.downcase
      else
        puts "\n\n\nWelcome to BATTLESHIP\n\nEnter p to play or q to quit\n"
        select = input.downcase
      end
      if select == 'p' || select == 'play'
        setup
      elsif select == 'q' || select == 'quit'
        break
      else
        failed_starts << input
      end
    end
  end

  def input
    user_input = gets.chomp
  end

  def generate_boards
    height = 4
    width = 4
    loop do
      print "Would you like to choose the board size? (y/n)\n>  "
      select = input.downcase
      if select == 'y' || select == 'yes'
        loop do
          print "Select board width (minimum 4, maximum 26):\n>  "
          width = input.to_i
          print "Select board height (minimum 4, maximum 26):\n>  "
          height = input.to_i
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
        puts "I'm sorry, I need a yes or no answer."
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
    header = @cpu.board.cells.values.last.coordinate[1..-1].to_i
    print '=' * (header + 6)
    print "COMPUTER BOARD"
    print '=' * (header + 6) + "\n"
    puts @cpu.board.render
    print '=' * (header + 7)
    print "PLAYER BOARD"
    print '=' * (header + 7) + "\n"
    puts @player.board.render(true)
    print "Enter the coordinate for your shot:\n>  "
    shots_fired
  end

  def already_fired_at?(cell)
    if @player.shots_taken.include?(cell)
      print "You already fired at #{cell}!\nPlease enter a valid coordinate:\n>  "
    else
      print "Please enter a valid coordinate:\n>  "
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

  def end_game
    puts "You won!" if @cpu.health == 0
    puts "I won!" if @player.health == 0
  end

end
