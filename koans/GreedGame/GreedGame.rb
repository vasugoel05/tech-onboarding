class GreedGame
  attr_accessor :players, :turn_scores, :total_scores

  # Initialize the game with a list of players
  def initialize(players)
    @players = players
    @turn_scores = Hash.new(0) # Store each player's turn score
    @total_scores = Hash.new(0) # Store each player's total score
    
    # Initialize @total_scores for each player
    players.each { |player| @total_scores[player] = 0 }
  end

  # Main method to play the game
  def play
    while @total_scores.values.max < 3000
      @players.each do |player|
        puts "#{player}'s turn!"
        turn_score = play_turn(player)
        @total_scores[player] += turn_score
        puts "#{player} scored #{turn_score} this turn. Total score: #{@total_scores[player]}"
        
        if @total_scores[player] >= 3000
          puts "#{player} has reached 3000 points! The final round begins."
          break
        end
      end
    end

    determine_winner
  end

  # Play a player's turn
  def play_turn(player)
    turn_score = 0
    dice = roll_dice(5) # Start by rolling 5 dice
    scoring_dice = []

    # Keep rolling until the player either scores or decides to stop
    while true
      puts "Dice rolled: #{dice.join(' ')}"
      turn_score += score_roll(dice)
      scoring_dice += dice.select { |die| score_die(die) != 0 }

      dice = dice - scoring_dice # Remove scoring dice

      if dice.empty? # If all dice are scoring dice, roll all 5 dice again
        dice = roll_dice(5)
      end

      if turn_score >= 300 && dice.empty?
        break
      elsif dice.empty?
        break
      end

      puts "Current turn score: #{turn_score}. Would you like to continue? (y/n)"
      continue = gets.chomp.downcase
      break if continue != 'y'
    end

    turn_score
  end

  # Simulate rolling a specific number of dice
  def roll_dice(num)
    Array.new(num) { rand(1..6) }
  end

  # Score a roll based on the rules
  def score_roll(dice)
    score = 0
    dice_count = Hash.new(0)

    dice.each { |die| dice_count[die] += 1 }

    dice_count.each do |die, count|
      case die
      when 1
        if count >= 3
          score += 1000
          count -= 3
        end
        score += count * 100
      when 5
        if count >= 3
          score += 500
          count -= 3
        end
        score += count * 50
      when 6
        score += 600 if count >= 3
      when 4
        score += 400 if count >= 3
      when 3
        score += 300 if count >= 3
      when 2
        score += 200 if count >= 3
      end
    end
    score
  end

  # Score a single die
  def score_die(die)
    case die
    when 1
      100
    when 5
      50
    else
      0
    end
  end

  # Determine the winner after the final round
  def determine_winner
    # Debug: Print the total scores of each player
    puts "Total Scores: #{@total_scores.inspect}"

    # Ensure no nil values in total_scores by setting them to 0
    @total_scores.each do |player, score|
      if score.nil?
        puts "#{player} has no score, setting it to 0."
        @total_scores[player] = 0
      end
    end

    winner = @total_scores.max_by { |player, score| score }
    puts "#{winner[0]} wins with #{winner[1]} points!"
  end
end

# Example of how to play the game
game = GreedGame.new(['Player 1', 'Player 2'])
game.play
