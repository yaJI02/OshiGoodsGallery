class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :post_places, dependent: :destroy
  has_many :places, through: :post_places, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }
  validates :purchase_cost, length: { maximum: 255 }
  validates :post_type, presence: true
  validates :purchase_status, presence: true

  enum post_type: { merchandise: 0, showroom: 1 }
  enum purchase_status: { purchased: 0, reservation: 1, considering: 2 }

  def save_places(place_list)
    current_places = places.pluck(:name) unless places.nil?
    old_places = current_places - place_list
    new_places = place_list - current_places

    old_places.each do |old_name|
      place = self.places.find_by(name: old_name)
      self.places.delete(place) if place.present?
    end

    new_places.each do |new_name|
      self.places.find_or_create_by(name: new_name)
    end
  end

  def save_tags(tag_list,tag_type_value)
    current_tags = tags.where(tag_type: tag_type_value).pluck(:name) unless tags.nil?
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags

    old_tags.each do |old_name|
      tag = self.tags.find_by(name: old_name)
      self.tags.delete(tag) if tag.present?
    end

    new_tags.each do |new_name|
      self.tags.find_or_create_by(name: new_name, tag_type: tag_type_value)
    end
  end
end
