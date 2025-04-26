class Player
  attr_accessor :id, :score, :in_the_game

  def initialize(id)
    @id = id
    @score = 0
    @in_the_game = false
  end

  def to_s
    "Player #{@id} with current score #{@score}"
  end
end
