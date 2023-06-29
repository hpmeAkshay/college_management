FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      full_phone_number { '+918805463425' }
      gender { Faker::Gender.binary_type }
      role { 'student' }
      date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65).strftime("%d/%m/%Y") }
      country { Faker::Address.country }
      city { Faker::Address.city }
      state { Faker::Address.state }
      address { Faker::Address.street_address }
  
    end
  end
  