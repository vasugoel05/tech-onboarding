# spec/roll_spec.rb

require_relative '../Game_Code/roll'
require_relative '../spec_helper'

RSpec.describe Roll do
  describe '#initialize' do
    it 'rolls the correct number of dice' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(1)
      roll = Roll.new(5)
      expect(roll.outcome.length).to eq(5)
    end
  end

  describe '#score calculation' do
    it 'gives 1000 points for three 1s' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(1, 1, 1, 2, 3)
      roll = Roll.new(5)
      expect(roll.score).to eq(1000)
    end

    it 'gives 200 points for three 2s' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(2, 2, 2, 4, 6)
      roll = Roll.new(5)
      expect(roll.score).to eq(200)
    end

    it 'gives 300 points for three 3s' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(3, 3, 3, 4, 5)
      roll = Roll.new(5)
      expect(roll.score).to eq(350) # 300 + 50
    end

    it 'gives 400 points for three 4s' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(4, 4, 4, 1, 5)
      roll = Roll.new(5)
      expect(roll.score).to eq(550) # 400 + 100 + 50
    end

    it 'gives 500 points for three 5s' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(5, 5, 5, 1, 2)
      roll = Roll.new(5)
      expect(roll.score).to eq(600) # 500 + 100
    end

    it 'gives 600 points for three 6s' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(6, 6, 6, 1, 5)
      roll = Roll.new(5)
      expect(roll.score).to eq(750) # 600 + 100 + 50
    end

    it 'adds 100 per single 1 and 50 per single 5' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(1, 5, 3, 4, 6)
      roll = Roll.new(5)
      expect(roll.score).to eq(150)
    end

    it 'returns zero if no scoring dice' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(2, 3, 4, 6, 6)
      roll = Roll.new(5)
      expect(roll.score).to eq(0)
    end

    it 'combines triplet and singles correctly' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(1, 1, 1, 5, 5)
      roll = Roll.new(5)
      expect(roll.score).to eq(1100) # 1000 + 50 + 50
    end
  end

  describe '#non_scoring_dices' do
    it 'removes scoring dice from non-scoring list' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(1, 1, 1, 5, 2)
      roll = Roll.new(5)
      expect(roll.non_scoring_dices).to contain_exactly(2)
    end
  end

  describe '#all_scoring_dices?' do
    it 'returns true when all dice score' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(1, 1, 1, 5, 5)
      roll = Roll.new(5)
      expect(roll.all_scoring_dices?).to be true
    end

    it 'returns false when some dice don’t score' do
      allow_any_instance_of(Roll).to receive(:throw_dice).and_return(1, 2, 3, 4, 6)
      roll = Roll.new(5)
      expect(roll.all_scoring_dices?).to be false
    end
  end
end
