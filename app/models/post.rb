class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :post_places, dependent: :destroy
  has_many :places, through: :post_places, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :post_stamps, dependent: :destroy
  has_one :profile

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }
  validates :purchase_cost, length: { maximum: 255 }
  validates :post_type, presence: true
  validates :purchase_status, presence: true

  enum post_type: { merchandise: 0, showroom: 1 }
  enum purchase_status: { purchased: 0, reservation: 1, considering: 2 }

  def save_places(place_list)
    old_places = places.pluck(:name) - Array(place_list)
    places.where(name: old_places).destroy_all

    (Array(place_list) - places.pluck(:name)).each do |new_name|
      places.find_or_create_by(name: new_name)
    end
  end

  def save_tags(tag_list, tag_type_value)
    old_tags = tags.where(tag_type: tag_type_value).pluck(:name) - Array(tag_list)
    tags.where(name: old_tags, tag_type: tag_type_value).destroy_all

    (Array(tag_list) - tags.where(tag_type: tag_type_value).pluck(:name)).each do |new_name|
      tags.find_or_create_by(name: new_name, tag_type: tag_type_value)
    end
  end

  def save_post_stamps(post_stamp_list)
    now_stamps = post_stamps.where(user_id: user_id)
    current_stamps = now_stamps.pluck(:stamp)
    old_stamps = current_stamps - Array(post_stamp_list)
    now_stamps.where(stamp: PostStamp.stamps.slice(*old_stamps).values).destroy_all

    (Array(post_stamp_list) - current_stamps).each do |new_stamp|
      post_stamps.create(stamp: PostStamp.stamps[new_stamp], user_id: user_id)
    end
  end
end
