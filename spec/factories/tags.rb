FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "tag#{n}" }
    tag_type { 0 }
  end
end
