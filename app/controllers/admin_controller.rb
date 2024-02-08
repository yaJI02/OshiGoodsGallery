class AdminController < ApplicationController
  before_action :admin_authorized

  def index
    @posts = Post.order(created_at: :DESC).includes(:user, :profile, :tags, :post_stamps).page(params[:page])
  end

  def tag_index
    @tags = Tag.order(created_at: :DESC).page(params[:page])
  end

  def place_index
    @places = Place.order(created_at: :DESC).page(params[:page])
  end

  def destroy_all_tag_place
    Place.destroy_all
    Tag.destroy_all
    redirect_to posts_url
  end

  private

  def admin_authorized
    return if current_user.admin_user?

    redirect_to root_path, flash: { danger: t('flash.not_authorized') }
  end
end
