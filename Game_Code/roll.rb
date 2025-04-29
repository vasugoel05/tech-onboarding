# Three 1's => 1000 points
# Three 6's =>  600 points
# Three 5's =>  500 points
# Three 4's =>  400 points
# Three 3's =>  300 points
# Three 2's =>  200 points
# One   1   =>  100 points
# One   5   =>   50 points

class Roll
  attr_reader :no_of_dices, :outcome, :non_scoring_dices, :score

  def initialize(no_of_dices)
    @no_of_dices = no_of_dices
    @outcome = []
    @score = 0
    @non_scoring_dices = []

    simulate_roll
    calculate_score
  end

  def all_scoring_dices?
    non_scoring_dices.empty?
  end

  def to_s
    <<~ROLL_OUTPUT
      Rolled #{@no_of_dices} dice.
      Outcome: #{outcome.join(', ')}
      Roll score: #{score}
      Non-scoring dice left: #{non_scoring_dices.count}
    ROLL_OUTPUT
  end

  private

  def simulate_roll
    @outcome = Array.new(@no_of_dices) { throw_dice }
    @non_scoring_dices = @outcome.dup
  end

  def throw_dice
    rand(1..6)
  end

  def calculate_score
    process_triplets
    process_single_scoring_dice(1, 100)
    process_single_scoring_dice(5, 50)
  end

  def process_triplets
    (1..6).to_a.reverse.each do |number|
      next unless @outcome.count(number) >= 3

      @score += number == 1 ? 1000 : number * 100
      3.times { @non_scoring_dices.delete_at(@non_scoring_dices.index(number)) }
    end
  end

  def process_single_scoring_dice(number, points)
    count = @non_scoring_dices.count(number)
    return if count.zero?

    @score += count * points
    count.times { @non_scoring_dices.delete_at(@non_scoring_dices.index(number)) }
  end
end
