class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  validates :body, presence: true, length: { maximum: 65_535 }

  private

  def create_notifications
    return if post.user == user

    Notification.create(subject: self, user: post.user, action_type: :commented_to_own_post)
  end
end
