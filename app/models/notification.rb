class Notification < ApplicationRecord
  belongs_to :user

  belongs_to :subject, polymorphic: true

  validates :action_type, presence: true
  validates :checked, inclusion: { in: [true, false] }

  enum action_type: { commented_to_own_post: 0, reaction_to_own_post: 1 }
end
