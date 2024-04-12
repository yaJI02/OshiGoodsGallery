FactoryBot.define do
  factory :comment do
    sequence(:body) { |n| "comment_body_#{n}" }
    association :user
    association :post
  end
end
