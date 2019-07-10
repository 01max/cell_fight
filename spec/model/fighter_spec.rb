require 'rails_helper'

RSpec.describe Fighter, type: :model do
  existing_fighter = Fighter.last
  fighter = existing_fighter.nil? ? FactoryBot.create(:fighter) : existing_fighter

  # to_s

  it 'responds to to_s' do
    expect(fighter.to_s).not_to be_empty
  end

  it 'responds to to_s with its name & id' do
    expect(fighter.to_s).to eq("#{fighter.name} [#{fighter.id}]")
  end

  # total_base_points

  it 'responds to total_base_points with an Integer' do
    expect(fighter.total_base_points).to be_an(Integer)
  end

  it 'responds to total_base_points with the correct value' do
    expected_value = fighter.attack_base_points.to_i + fighter.defense_base_points.to_i + fighter.health_base_points.to_i
    expect(fighter.total_base_points).to eq(expected_value)
  end

  # max_health

  it 'responds to max_health with an Integer' do
    expect(fighter.max_health).to be_an(Integer)
  end

  it 'responds to max_health with the correct value' do
    expected_value = (fighter.total_base_points + fighter.defense_base_points.to_i + fighter.health_base_points.to_i*2)*10
    expect(fighter.max_health).to eq(expected_value)
  end

  # private methods

  # has_valid_base_points?

  context 'when its total_base_points is greater than Fighter::MAX_TOTAL_BASE_POINTS' do
    invalid_fighter = Fighter.new(attack_base_points: Fighter::MAX_TOTAL_BASE_POINTS+1)

    it 'responds to has_valid_base_points? with false' do
      expect(invalid_fighter.send(:has_valid_base_points?)).to eq(false)
    end
  end

  context 'when its total_base_points is lower than (or equal to) Fighter::MAX_TOTAL_BASE_POINTS' do
    it 'responds to has_valid_base_points? with false' do
      expect(fighter.send(:has_valid_base_points?)).to eq(true)
    end
  end

  # set_default_base_points

  it 'has all his undefined *_base_points attributes value to 0 by set_default_base_points' do
    fighter.attack_base_points = nil
    expect{ fighter.send(:set_default_base_points) }.to change{ fighter.attack_base_points  }.from(nil).to(0)
  end

end
