class Place < ApplicationRecord
  has_many :posts, through: :post_places
  has_many :post_places, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
end
