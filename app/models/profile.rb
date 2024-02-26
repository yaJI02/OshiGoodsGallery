class Profile < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  belongs_to :user
  has_one :post # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :choosy_tags, dependent: :destroy

  validates :sns_account, length: { maximum: 255 }
  validates :display_tag_type, presence: true
  validates :is_display_dislike_tag, inclusion: { in: [true, false] }

  enum display_tag_type: { all_tag: 0, not_ng: 1, only_favorite: 2 }
end
