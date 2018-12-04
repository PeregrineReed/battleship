require 'pry'

class Ship
  attr_reader :name 

  def initialize(name, health)
    @name = name
    @health = health
  end
end
