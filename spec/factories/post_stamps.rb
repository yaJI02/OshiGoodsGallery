FactoryBot.define do
  factory :post_stamp do
    association :post
    association :user
    stamp { 0 }
  end
end
