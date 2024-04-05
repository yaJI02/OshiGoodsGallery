class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :post_places, dependent: :destroy
  has_many :places, through: :post_places, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :post_stamps, dependent: :destroy
  has_many :my_lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile # rubocop:disable Rails/HasManyOrHasOneDependent

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, length: { maximum: 65_535 }
  validates :purchase_cost, length: { maximum: 255 }
  validates :post_type, presence: true
  validates :purchase_status, presence: true
  validates :display_comment, inclusion: { in: [true, false] }

  enum post_type: { merchandise: 0, showroom: 1 }
  enum purchase_status: { purchased: 0, reservation: 1, considering: 2 }

  scope :author_stamped_posts, ->(select_value) { joins(:post_stamps).where('posts.user_id = post_stamps.user_id AND post_stamps.stamp = ?', select_value.to_s) }
  scope :not_disliked_by_user, ->(user) { joins(:post_tags).where.not('post_tags IS NULL OR post_tags.post_id IN (?)', PostTag.where(tag_id: user.profile.choosy_tags.dislike_tag.pluck(:tag_id)).select(:post_id)) }
  scope :only_favorite_of_user, lambda { |user|
    not_favorite_tags = Tag.pluck(:id) - user.profile.choosy_tags.favorite_tag.pluck(:tag_id)
    joins(:post_tags).where.not('post_tags IS NULL OR post_tags.post_id IN (?)', PostTag.where(tag_id: not_favorite_tags).select(:post_id))
  }

  def save_places(place_list)
    current_places = places.nil? ? [] : places.pluck(:name)
    old_places = current_places - (place_list.nil? ? [] : place_list)
    new_places = (place_list.nil? ? [] : place_list) - current_places

    old_places.each do |old_name|
      post_place = post_places.joins(:place).find_by(places: { name: old_name })
      post_place.delete
    end

    new_places.each do |new_name|
      place = Place.find_or_create_by(name: new_name)
      post_places.create(place_id: place.id)
    end
  end

  def save_tags(tag_list, tag_type_value)
    current_tags = tags.where(tag_type: tag_type_value).nil? ? [] : tags.where(tag_type: tag_type_value).pluck(:name)
    old_tags = current_tags - (tag_list.nil? ? [] : tag_list)
    new_tags = (tag_list.nil? ? [] : tag_list) - current_tags

    old_tags.each do |old_name|
      post_tag = post_tags.joins(:tag).find_by(tags: { name: old_name, tag_type: tag_type_value })
      post_tag.delete
    end

    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name: new_name, tag_type: tag_type_value)
      post_tags.create(tag_id: tag.id)
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

  private_class_method :ransackable_attributes
  private_class_method :ransackable_associations
  private_class_method :ransackable_scopes

  def self.ransackable_attributes(auth_object = nil)
    %w[title body post_type]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user tags places post_stamps]
  end

  def self.ransackable_scopes(auth_object = nil)
    %w[author_stamped_posts]
  end

  def stamp_count(stamp)
    post_stamps.where(stamp: stamp).count
  end

  def self.filtered_posts_for_user(user)
    case user.profile.display_tag_type
    when 'all_tag'
      all
    when 'not_ng'
      not_disliked_by_user(user)
    when 'only_favorite'
      only_favorite_of_user(user)
    end
  end

  def start_time
    if bought_at.present?
      return bought_at
    else
      return created_at
    end
  end
end
