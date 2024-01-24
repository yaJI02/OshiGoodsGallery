class Tag < ApplicationRecord
  has_many :posts, through: :post_places
  has_many :post_tags, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :tag_type, presence: true

  enum tag_type: { merchandise_tag: 0, content_tag: 1 }

  scope :merchandise, -> { where(tag_type: Tag.tag_types[:merchandise_tag]) }
  scope :content, -> { where(tag_type: Tag.tag_types[:content_tag]) }
end
