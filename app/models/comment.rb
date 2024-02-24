class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one :notification, as: :subject, dependent: :destroy

  validates :body, presence: true, length: { maximum: 65_535 }
end
