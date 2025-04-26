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

  def initialize(no_of_dices, options = {})
    @no_of_dices = no_of_dices
    @outcome = []
    @score = 0
    simulate_roll(options)
    calc_score()
  end

  def all_scoring_dices?()
    non_scoring_dices.empty?
  end

  def to_s()
    "Rolled #{@no_of_dices} dice.\n" +
    "Outcome: #{outcome.join(', ')}\n" +
    "Roll score: #{score}\n" +
    "Non-scoring dice left: #{non_scoring_dices.count}\n"
  end

  private

  def simulate_roll(options)
    unless options[:override_outcome]
      no_of_dices.times { @outcome << throw_dice() }
    else
      @outcome = options[:override_outcome].clone
    end
    @non_scoring_dices = @outcome.clone
  end

  def throw_dice
    1 + rand(6)
  end

  def calc_score()
    # Check for triplets first
    [1, 6, 5, 4, 3, 2].each do |number|
      if arr_has_three_of_a_kind?(@outcome, number)
        @score += (number == 1) ? 1000 : (number * 100)
        3.times { @non_scoring_dices.delete_at(@non_scoring_dices.index(number)) }
      end
    end

    # Then check for single 1s and 5s
    update_score_for(@non_scoring_dices, 1, 100)
    update_score_for(@non_scoring_dices, 5, 50)
  end

  def arr_has_three_of_a_kind?(arr, number)
    arr.count(number) >= 3
  end

  def update_score_for(arr, number, points)
    number_count = arr.count(number)
    if number_count > 0
      @score += number_count * points
      number_count.times { arr.delete_at(arr.index(number)) }
    end
  end
end
