FactoryBot.define do
  factory :profile do
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/sample_avatar.jpg')) }
    sequence(:sns_account) { |n| "@sns_account_#{n}" }
    display_tag_type { 0 }
    is_display_dislike_tag { true }
    association :user
  end
end
