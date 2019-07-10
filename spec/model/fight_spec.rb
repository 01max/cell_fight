require 'rails_helper'

RSpec.describe Fighter, type: :model do
  existing_fight = Fight.last
  fight = existing_fight.nil? ? FactoryBot.create(:fight) : existing_fight

  # to_s

  it 'responds to to_s' do
    expect(fight.to_s).not_to be_empty
  end

  it 'responds to to_s with its fighters & if' do
    expect(fight.to_s).to eq("##{fight.id} - #{fight.fighter_a} VS #{fight.fighter_b}")
  end
end
