require 'pry'

class Ship
  attr_reader :name,
              :health,
              :length

  def initialize(name, health)
    @name = name
    @health = health
    @length = health
  end
end
