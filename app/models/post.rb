class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }
  validates :purchase_cost, length: { maximum: 255 }
  validates :post_type, presence: true
  validates :purchase_status, presence: true

  enum post_type: { merchandise: 0, showroom: 1 }
  enum purchase_status: { purchased: 0, reservation: 1, considering: 2 }
end
