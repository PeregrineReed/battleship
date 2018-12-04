require 'pry'

class Ship
  attr_reader :name,
              :health,
              :length

  def initialize(name, health_arg)
    @name = name
    @health = health_arg
    @length = health_arg
  end

  def sunk?
    if @health == 0
      true
    else
      false
    end
  end

  def hit
    if @health > 0
      @health -= 1
    end
  end
end
