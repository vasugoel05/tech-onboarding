# spec/player_spec.rb

require_relative '../Game_Code/player'
require_relative '../spec_helper'

RSpec.describe Player do
  let(:player) { Player.new(1) }

  it "initializes with correct id" do
    expect(player.id).to eq(1)
  end

  it "initializes with score 0" do
    expect(player.score).to eq(0)
  end

  it "initializes as not in the game" do
    expect(player.in_the_game).to eq(false)
  end

  it "returns correct string representation" do
    expect(player.to_s).to eq("Player 1 with current score 0")
  end
end
