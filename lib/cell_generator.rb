module CellGenerator

  def cell_generator
    abcs =('A'..'Z').to_a
    nums = (1..26).to_a

    num_letter = {}
    nums.zip(abcs).each do |pair|
      num_letter[pair[0]] = pair[1]
    end

    height = num_letter[@width]
    width = @height.to_i
    x_axis = ('A'..height).to_a
    y_axis = (1..width).to_a

    board_cells = {}
    counter = 0
    x_axis.each do |letter|

      y_axis * y_axis.length.times do
        coordinate = letter + y_axis[counter].to_s
        board_cells[coordinate] = Cell.new(coordinate)
        counter += 1
        counter = 0 if counter == y_axis.length
      end
    end
    board_cells
  end

end
