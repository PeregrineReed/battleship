class Cell

  attr_reader :coordinate

  def initialize(coordinate)
    @coordinate = coordinate
  end

  def empty?
    true
  end

end
