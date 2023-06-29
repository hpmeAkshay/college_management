FactoryBot.define do
    factory :academic do
      college_name { Faker::University.name }
      career_goals { Faker::Lorem.sentence }
      known_languages { Faker::Lorem.words(number: 3).join(', ') }
      other_languages { Faker::Lorem.words(number: 3).join(', ') }
      currently_working { Faker::Company.name }
      specialization { Faker::Lorem.word }
      total_experience { Faker::Number.between(from: 1, to: 10).to_s }
      availability { Faker::Lorem.word }

      association :user
      association :interest
      association :qualification

    end
end
  