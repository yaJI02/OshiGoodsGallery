class PostStamp < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :stamp, presence: true

  enum stamp: { nice: 0, cute: 1, cool: 2, great: 3, recommend: 4, loved: 5, awesome: 6 }
end
