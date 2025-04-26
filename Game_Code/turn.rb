class Turn
  attr_accessor :player, :score, :no_of_dices, :end_of_turn

  def initialize(player)
    @player = player
    @score = 0
    @no_of_dices = 5
    @end_of_turn = false
  end

  def start()
    take_roll()
  end

  private

  def take_roll()
    roll = Roll.new(@no_of_dices)
    puts roll.to_s + "\n"

    if roll.score == 0
      puts "No points scored! You lose all points for this turn.\n"
      @score = 0
      end_turn()
    else
      @score += roll.score
      @no_of_dices = roll.all_scoring_dices? ? 5 : roll.non_scoring_dices.count
      prompt_user()
    end
  end

  def prompt_user()
    puts "Player #{@player.id} : Type 'roll' to roll again (#{@no_of_dices} dice) or 'end' to stop and keep your turn score."
    user_input = gets.chomp.downcase

    if user_input == "roll"
      take_roll()
    elsif user_input == "end"
      end_turn()
    else
      puts "Invalid input. Try again.\n"
      prompt_user()
    end
  end

  def end_turn()
    if !@player.in_the_game && @score >= 300
      @player.in_the_game = true
      puts "Player #{@player.id} is now 'In The Game'!"
    end

    if @player.in_the_game
      @player.score += @score
    end

    @end_of_turn = true
  end
end
