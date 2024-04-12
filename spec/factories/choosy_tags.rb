FactoryBot.define do
  factory :choosy_tag do
    association :profile
    association :tag
    choosy_type { 0 }
  end
end
