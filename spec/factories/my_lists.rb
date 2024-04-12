FactoryBot.define do
  factory :my_list do
    association :user
    association :post
  end
end
