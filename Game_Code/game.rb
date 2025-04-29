require_relative 'player'
require_relative 'roll'
require_relative 'turn'

class Game
  attr_accessor :players

  def initialize(no_of_players)
    @players = []
    @final_round = false
    # @final_round_triggered_by = nil

    no_of_players.times do |i|
      @players << Player.new(i)
    end
  end

  def start()
    puts "Starting game.\n\n"

    while (!@final_round)
      @players.each do |player|
        play_turn(player)

        if player.score >= 3000
          @final_round = true
          # @final_round_triggered_by = player
          puts "Player #{player.id} triggered the final round!\n\n"
          break
        end
      end
    end

    # Final round: All players get one more turn
    puts "Final round started! All players get one last turn!\n\n"
    @players.each do |player|
      play_turn(player)
    end

    # final scores and winner
    print_final_scores()
    declare_winner()
    puts "Game ended."
  end

  private

  def play_turn(player)
    puts "*********** START TURN ***********"
    puts "#{player}\n"

    turn = Turn.new(player)
    turn.start()

    puts "Turn score is #{turn.score}\n"
    puts "#{player}\n"
    puts "*********** END TURN ***********\n\n"

    puts "Press enter key to continue\n"
    gets()
  end

  def print_final_scores
    puts "\n==== Final Scores ===="
    @players.each do |player|
      puts "Player #{player.id} final score: #{player.score}"
    end
  end

  def declare_winner
    winner = @players.max_by(&:score)
    puts "\n🎉 Player #{winner.id} wins with #{winner.score} points! 🎉"
  end

end

if __FILE__ == $0
  puts "Enter number of players for the new game:"
  no_of_players = gets().chomp().to_i
  Game.new(no_of_players).start()
end
