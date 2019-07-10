FactoryBot.define do

  factory :fight do |c|

    c.fighter_a {
      if Fighter.all.sample
        Fighter.all.sample
      else
        FactoryBot.create(:fighter)
      end
    }

    c.fighter_b {
      if Fighter.where.not(id: fighter_a_id).sample
        Fighter.where.not(id: fighter_a_id).sample
      else
        FactoryBot.create(:fighter)
      end
    }

  end

end
