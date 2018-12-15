class Game

  include GameDisplay

  attr_reader :cpu,
              :player

  def initialize
    @player = Player.new
    @cpu = Computer.new
  end

  def setup
    generate_boards
    @cpu.setup
    ship_info
    puts @player.board.render(true)
    @player.place_ships
    turn
  end

  def turn
    loop do
      if end_game?
        end_game
        restart
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

  def restart
    @player = Player.new
    @cpu = Computer.new
  end

  def shots_fired
    loop do
      input = gets.chomp.upcase
      if @cpu.board.valid_coordinate?(input)
        player = @player.board.cells
        cpu = @cpu.board.cells
        unfired_at = player.keys - @cpu.shots_taken
        cpu_input = unfired_at.sample

        @player.shots_taken << input
        cpu[input].fire_upon

        report_results(cpu, input)

        if end_game?
          break
        end

        cpu_shot = player[cpu_input].fire_upon
        @cpu.shots_taken << cpu_input

        report_results(player, cpu_input)

        break
      else
        already_fired_at?(input)
      end
    end
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
