class Contact < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, confirmation: { message: I18n.t('errors.messages.email_confirmation') }, length: { maximum: 255 }
  validates :email_confirmation, presence: true, length: { maximum: 255 }
  validates :subject, presence: true
  validates :message, presence: true, length: { maximum: 65_535 }
  validates :login_user, length: { maximum: 255 }

  enum subject: { about_other: 0, about_account: 1 }
end
