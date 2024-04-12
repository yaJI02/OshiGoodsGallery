FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "contact_user#{n}" }
    sequence(:email) { |n| "contact_user_#{n}@example.com" }
    sequence(:email_confirmation) { |n| "contact_user_#{n}@example.com" }
    subject { 0 }
    message { 'contact_message' }
    sequence(:login_user) { |n| "contact_login_user#{n}" }
  end
end
