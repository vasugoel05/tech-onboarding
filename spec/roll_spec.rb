# spec/roll_spec.rb

require_relative '../Game_Code/roll'
require_relative '../spec_helper'

RSpec.describe Roll do
  context "when rolling dices" do
    it "rolls the correct number of dice" do
      roll = Roll.new(5)
      expect(roll.outcome.size).to eq(5)
    end

    it "generates numbers between 1 and 6" do
      roll = Roll.new(5)
      expect(roll.outcome).to all(be_between(1,6))
    end
  end

  context "when scoring" do
    it "scores correctly for three 1's" do
      roll = Roll.new(5, override_outcome: [1,1,1,4,6])
      expect(roll.score).to eq(1000)
    end

    it "scores correctly for single 1s and 5s" do
      roll = Roll.new(5, override_outcome: [1,5,2,3,4])
      expect(roll.score).to eq(150)
    end

    it "identifies all scoring dices correctly" do
      roll = Roll.new(5, override_outcome: [1,1,1,5,5])
      expect(roll.all_scoring_dices?).to eq(true)
    end

    it "identifies non-scoring dices correctly" do
      roll = Roll.new(5, override_outcome: [1,2,3,4,6])
      expect(roll.non_scoring_dices).to include(2,3,4,6)
    end
  end
end
