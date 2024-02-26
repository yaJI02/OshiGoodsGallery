class ChoosyTag < ApplicationRecord
  belongs_to :profile
  belongs_to :tag

  validates :choosy_type, presence: true

  enum choosy_type: { favorite_tag: 0, dislike_tag: 1 }
end
