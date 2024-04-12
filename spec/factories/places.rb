FactoryBot.define do
  factory :place do
    sequence(:name) { |n| "place#{n}" }
  end
end
