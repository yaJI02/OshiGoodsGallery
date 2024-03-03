class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :posts, dependent: :destroy
  has_many :post_stamps, dependent: :destroy
  has_many :my_lists, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :follower, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy, inverse_of: :follower
  has_many :followed, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy, inverse_of: :followed
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  has_one :profile, dependent: :destroy

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  def admin_user?
    ENV['ADMIN_USER_EMAIL'] == email
  end

  def total_post
    posts.count
  end

  def total_purchase_cost
    posts.sum(:purchase_cost)
  end

  def notifications_exists?
    notifications.exists?(checked: false)
  end

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  private_class_method :ransackable_attributes
  private_class_method :ransackable_associations

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[posts]
  end
end
