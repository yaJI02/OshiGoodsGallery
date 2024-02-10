class Place < ApplicationRecord
  has_many :posts, through: :post_places
  has_many :post_places, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }

  private_class_method :ransackable_attributes
  private_class_method :ransackable_associations

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[posts]
  end
end
