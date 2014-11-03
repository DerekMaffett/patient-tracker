FactoryGirl.define do
  factory :resident, class: User do
    name 'Gregory House'
    role 'Resident'
    email 'gregoryhouse@hospital.com'
    password 'resident'
    password_confirmation 'resident'
    first_name 'Gregory'
    last_name 'House'
    confirmed_at Time.now
  end
end
