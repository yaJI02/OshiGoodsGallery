FactoryBot.define do
  factory :post_place do
    association :post
    association :place
  end
end
