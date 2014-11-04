FactoryGirl.define do
  factory :resident, class: User do
    name { "#{first_name} #{last_name}" }
    role 'Resident'
    email { Faker::Internet.email }
    password 'resident'
    password_confirmation 'resident'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    confirmed_at Time.now
  end

  factory :admin, class: User do
    name { "#{first_name} #{last_name}" }
    role 'Admin'
    email { Faker::Internet.email }
    password 'admin'
    password_confirmation 'admin'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    confirmed_at Time.now
  end
end
