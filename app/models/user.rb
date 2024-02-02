class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :posts, dependent: :destroy
  has_many :post_stamps, dependent: :destroy
  has_one :profile, dependent: :destroy

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  def admin_user?
    ENV['ADMIN_USER_EMAIL'] == self.email
  end

  def total_post
    posts.count
  end

  def total_purchase_cost
    posts.sum(:purchase_cost)
  end
end
