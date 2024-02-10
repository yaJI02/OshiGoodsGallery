class Place < ApplicationRecord
  has_many :posts, through: :post_places
  has_many :post_places, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }

  private

  def self.ransackable_attributes(auth_object = nil)
    ['name']
  end

  def self.ransackable_associations(auth_object = nil)
    ['posts']
  end
end
