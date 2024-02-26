class Tag < ApplicationRecord
  has_many :posts, through: :post_places
  has_many :post_tags, dependent: :destroy
  has_many :choosy_tags, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :tag_type, presence: true

  enum tag_type: { merchandise_tag: 0, content_tag: 1, choosy_tag: 2 }

  private_class_method :ransackable_attributes
  private_class_method :ransackable_associations

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[posts]
  end
end
