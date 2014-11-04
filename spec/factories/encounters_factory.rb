FactoryGirl.define do
  factory :encounter do
    encounter_type { Encounter::TYPES.sample.to_s.humanize }
    encountered_on { Faker::Date.backward(30) }
  end
end
