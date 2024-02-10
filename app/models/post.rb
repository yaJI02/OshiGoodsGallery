class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :post_places, dependent: :destroy
  has_many :places, through: :post_places, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :post_stamps, dependent: :destroy
  has_one :profile # rubocop:disable Rails/HasManyOrHasOneDependent

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }
  validates :purchase_cost, length: { maximum: 255 }
  validates :post_type, presence: true
  validates :purchase_status, presence: true

  enum post_type: { merchandise: 0, showroom: 1 }
  enum purchase_status: { purchased: 0, reservation: 1, considering: 2 }

  scope :author_stamped_posts, ->(select_value) {
    joins(:post_stamps)
    .where('posts.user_id = post_stamps.user_id AND post_stamps.stamp = ?', "#{select_value}")
  }

  def save_places(place_list)
    current_places = places.nil? ? [] : places.pluck(:name)
    old_places = current_places - (place_list.nil? ? [] : place_list)
    new_places = (place_list.nil? ? [] : place_list) - current_places

    old_places.each do |old_name|
      place = places.find_by(name: old_name)
      post_place = post_places.find_by(place_id: place)
      post_place.delete
    end

    new_places.each do |new_name|
      if place = Place.find_by(name: new_name) # rubocop:disable Lint/AssignmentInCondition
        post_places.create(place_id: place.id)
      else
        places.create(name: new_name)
      end
    end
  end

  def save_tags(tag_list, tag_type_value)
    current_tags = tags.where(tag_type: tag_type_value).nil? ? [] : tags.where(tag_type: tag_type_value).pluck(:name)
    old_tags = current_tags - (tag_list.nil? ? [] : tag_list)
    new_tags = (tag_list.nil? ? [] : tag_list) - current_tags

    old_tags.each do |old_name|
      tag = tags.find_by(name: old_name, tag_type: tag_type_value)
      post_tag = post_tags.find_by(tag_id: tag)
      post_tag.delete
    end

    new_tags.each do |new_name|
      if tag = Tag.find_by(name: new_name, tag_type: tag_type_value) # rubocop:disable Lint/AssignmentInCondition
        post_tags.create(tag_id: tag.id)
      else
        tags.create(name: new_name, tag_type: tag_type_value)
      end
    end
  end

  def save_post_stamps(post_stamp_list)
    now_stamps = post_stamps.where(user_id: user_id) # rubocop:disable Style/HashSyntax
    current_stamps = now_stamps.pluck(:stamp)
    old_stamps = current_stamps - Array(post_stamp_list)
    now_stamps.where(stamp: PostStamp.stamps.slice(*old_stamps).values).destroy_all

    (Array(post_stamp_list) - current_stamps).each do |new_stamp|
      post_stamps.create(stamp: PostStamp.stamps[new_stamp], user_id: user_id) # rubocop:disable Style/HashSyntax
    end
  end

  private

  def self.ransackable_attributes(auth_object = nil)
    ['title', 'body', 'post_type']
  end

  def self.ransackable_associations(auth_object = nil)
    ['user', 'tags', 'places', 'post_stamps']
  end

  def self.ransackable_scopes(auth_object=nil)
    ['author_stamped_posts']
  end
end
