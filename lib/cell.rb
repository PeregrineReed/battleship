class Cell

  attr_reader :coordinate,
              :ship,
              :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    if @ship == nil
      true
    else
      false
    end
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @ship.hit unless self.empty?
    @fired_upon = true
  end

  def fired_upon?
    @fired_upon
  end

  def render(reveal = false)
    if !empty? && @ship.sunk?
      'X'
    elsif @fired_upon && !empty?
      'H'
    elsif !empty? && reveal
      'S'
    elsif @fired_upon && empty?
      'M'
    else
      '.'
    end
  end

end
