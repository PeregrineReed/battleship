class Game

  include GameDisplay

  attr_reader :cpu_board,
              :cpu_ships,
              :player_board,
              :player_ships

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

end
