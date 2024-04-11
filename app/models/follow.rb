class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  validates :follower, uniqueness: { scope: :followed }

  private

  def create_notifications
    Notification.create(subject: self, user: followed, action_type: :followed)
  end
end
