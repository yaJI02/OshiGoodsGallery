FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "post_title_#{n}" }
    sequence(:body) { |n| "post_body_#{n}" }
    purchase_cost { 1000 }
    bought_at { '2000-01-01' }
    post_type { 0 }
    purchase_status { 0 }
    display_comment { true }
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/sample.jpg')) }
    association :user
  end
end
