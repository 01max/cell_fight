FactoryBot.define do

  factory :fighter do |c|

    c.name {
      [
        Faker::Movies::LordOfTheRings,
        Faker::Games::Zelda,
        Faker::TvShows::DrWho
      ].sample.character
    }

    c.health_base_points  { rand(0..Fighter::MAX_HEALTH_BASE_POINTS) }
    c.defense_base_points { rand(0..Fighter::MAX_DEFENSE_BASE_POINTS) }
    c.attack_base_points  { Fighter::MAX_TOTAL_BASE_POINTS - (health_base_points + defense_base_points) }

  end

end
