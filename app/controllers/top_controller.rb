class TopController < ApplicationController
  skip_before_action :require_login

  def index
    @new_merchandise = Post.merchandise.order(created_at: :DESC).includes(:user, :profile, :tags, :post_stamps).limit(10)
    @new_showroom = Post.showroom.order(created_at: :DESC).includes(:user, :profile, :tags, :post_stamps).limit(10)
  end

  def terms_of_use; end
  def about; end
  def privacy_policy; end
end
