class Profile < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  belongs_to :user
  has_one :post # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :choosy_tags, dependent: :destroy

  validates :sns_account, length: { maximum: 255 }
  validates :display_tag_type, presence: true
  validates :is_display_dislike_tag, inclusion: { in: [true, false] }

  enum display_tag_type: { all_tag: 0, not_ng: 1, only_favorite: 2 }

  def save_choosy_tags(tag_list, tag_type_value)
    current_tags = choosy_tags.where(choosy_type: tag_type_value).nil? ? [] : choosy_tags.where(choosy_type: tag_type_value).joins(:tag).pluck('tags.name')
    old_tags = current_tags - (tag_list.nil? ? [] : tag_list)
    new_tags = (tag_list.nil? ? [] : tag_list) - current_tags

    old_tags.each do |old_name|
      tag = choosy_tags.joins(:tag).find_by(tags: { name: old_name }, choosy_type: tag_type_value)
      tag.delete
    end

    new_tags.each do |new_name|
      tag = Tag.find_by(name: new_name) || Tag.create(name: new_name, tag_type: 2)
      choosy_tags.create(tag_id: tag.id, choosy_type: tag_type_value)
    end
  end
end
