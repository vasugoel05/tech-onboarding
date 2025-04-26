# spec/turn_spec.rb

require_relative '../Game_Code/turn'
require_relative '../spec_helper'

RSpec.describe Turn do
  let(:player) { Player.new(0) }
  let(:turn) { Turn.new(player) }

  it "initializes with 5 dices" do
    expect(turn.no_of_dices).to eq(5)
  end

  it "initializes with 0 score" do
    expect(turn.score).to eq(0)
  end

  it "enters the game when score is 300 or more" do
    allow_any_instance_of(Roll).to receive(:score).and_return(350)
    allow_any_instance_of(Roll).to receive(:non_scoring_dices).and_return([])
    allow_any_instance_of(Roll).to receive(:all_scoring_dices?).and_return(true)
    allow(turn).to receive(:gets).and_return('end')

    turn.start
    expect(player.in_the_game).to eq(true)
  end

  it "does not enter the game if score is less than 300" do
    allow_any_instance_of(Roll).to receive(:score).and_return(250)
    allow_any_instance_of(Roll).to receive(:non_scoring_dices).and_return([])
    allow_any_instance_of(Roll).to receive(:all_scoring_dices?).and_return(true)
    allow(turn).to receive(:gets).and_return('end')

    turn.start
    expect(player.in_the_game).to eq(false)
  end
end
