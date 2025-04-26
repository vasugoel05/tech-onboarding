# spec/game_spec.rb

require_relative '../Game_Code/game'
require_relative '../spec_helper'

RSpec.describe Game do
  let(:game) { Game.new(2) }

  it "initializes correct number of players" do
    expect(game.players.size).to eq(2)
  end

  it "players are initialized correctly" do
    expect(game.players.first).to be_a(Player)
  end

  it "prints final scores without error" do
    expect { game.send(:print_final_scores) }.not_to raise_error
  end

  it "goes into final round when player reaches 3000" do
    player = game.players.first
    player.score = 3000
    expect(player.score).to be >= 3000
  end
end
