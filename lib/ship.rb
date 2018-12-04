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
    false
  end
end
