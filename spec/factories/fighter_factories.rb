FactoryBot.define do

  factory :fighter do |c|

    c.name { Faker::Address.country }

  end

end
