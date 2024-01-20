class PostPlace < ApplicationRecord
  belongs_to :post
  belongs_to :place

  validates :post_id, presence: true
  validates :place_id, presence: true
end
