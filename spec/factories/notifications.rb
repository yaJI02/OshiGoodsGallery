FactoryBot.define do
  factory :notification do
    action_type { 0 }
    checked { true }
    association :user

    factory :notification_for_comment do
      association :subject, factory: :comment
    end

    factory :notification_for_post_stamp do
      association :subject, factory: :post_stamp
    end

    factory :notification_for_user do
      association :subject, factory: :user
    end
  end
end
