class AdminController < ApplicationController
  before_action :admin_authorized

  def index; end

  def destroy_all_tag_place
    Place.all.destroy_all
    Tag.all.destroy_all
    redirect_to posts_url
  end

    private

  def admin_authorized
    if ENV['ADMIN_USER_EMAIL'] != current_user.email
      redirect_to root_path, flash: { danger: t('flash.not_authorized') }
    end
  end
end
