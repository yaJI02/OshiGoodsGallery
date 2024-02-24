class PostStamp < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  validates :stamp, presence: true, uniqueness: { scope: %i[post_id user_id] }

  enum stamp: { nice: 0, cute: 1, cool: 2, great: 3, recommend: 4, loved: 5, awesome: 6 }

  ICONS = { cute: 'bi-flower2', cool: 'bi-suit-diamond-fill', great: 'bi-stars', recommend: 'bi-fire', loved: 'bi-heart-fill', awesome: 'bi-sun-fill' }.freeze

  private_class_method :ransackable_attributes
  private_class_method :ransackable_associations

  def self.ransackable_attributes(auth_object = nil)
    %w[stamp]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[post]
  end

  def icon_name
    ICONS[stamp.to_sym]
  end

  def self.icons
    ICONS
  end

  private

  def create_notifications
    return if post.user == user

    Notification.create(subject: self, user: post.user, action_type: :reaction_to_own_post)
  end
end
