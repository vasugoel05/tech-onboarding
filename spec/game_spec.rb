# spec/game_spec.rb

require_relative '../Game_Code/game'
require_relative '../Game_Code/player'
require_relative '../Game_Code/roll'
require_relative '../Game_Code/turn'
require_relative '../spec_helper'

RSpec.describe Game do
  let(:game) { Game.new(2) }

  before do
    allow($stdout).to receive(:puts) 
    allow(game).to receive(:gets).and_return("\n") 
  end

  it 'initializes the correct number of players' do
    expect(game.players.length).to eq(2)
    expect(game.players.map(&:id)).to eq([0, 1])
  end

  it 'allows a player to trigger the final round at 3000 points' do
    allow_any_instance_of(Turn).to receive(:start) do |turn|
      if turn.player.id == 0 && turn.player.score == 0
        turn.score = 3000
        turn.player.score = 3000
      else
        turn.score = 500
        turn.player.score += turn.score
      end
    end

    game.start

    expect(game.players.find { |p| p.id == 0 }.score).to be >= 3000
  end

  it 'ensures all players get one final turn after triggering final round' do
    turn_counts = Hash.new(0)

    allow_any_instance_of(Turn).to receive(:start) do |turn|
      turn_counts[turn.player.id] += 1

      if turn.player.id == 0 && turn_counts[turn.player.id] == 1
        turn.score = 3000
        turn.player.score = 3000
      else
        turn.score = 500
        turn.player.score += turn.score
      end
    end

    game.start

    game.players.each do |player|
      expect(turn_counts[player.id]).to eq(2)
    end
  end

  it 'declares the player with highest score as winner' do
    allow_any_instance_of(Turn).to receive(:start) do |turn|
      if turn.player.id == 0
        turn.score = 4000
        turn.player.score = 4000
      else
        turn.score = 500
        turn.player.score += turn.score
      end
    end

    expect { game.start }.to output(/Player 0 wins with 4000 points!/).to_stdout
  end
end
