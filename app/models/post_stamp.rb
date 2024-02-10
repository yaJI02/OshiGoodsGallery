class PostStamp < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :stamp, presence: true, uniqueness: { scope: %i[post_id user_id] }

  enum stamp: { nice: 0, cute: 1, cool: 2, great: 3, recommend: 4, loved: 5, awesome: 6 }

  private_class_method :ransackable_attributes
  private_class_method :ransackable_associations

  def self.ransackable_attributes(auth_object = nil)
    %w[stamp]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[post]
  end
end
