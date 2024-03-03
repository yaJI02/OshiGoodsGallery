class TopController < ApplicationController
  skip_before_action :require_login

  def index
    posts = Post.includes(:user, :profile, :tags, :post_stamps).group(:id)
    posts = posts.filtered_posts_for_user(current_user) if current_user.present?
    @new_merchandise = posts.merchandise.order(created_at: :DESC).limit(10)
    @new_showroom = posts.showroom.order(created_at: :DESC).limit(10)
    @nice_ranking = posts.sort_by { |post| -post.stamp_count('nice') }.first(10)
  end

  def terms_of_use; end
  def about; end
  def privacy_policy; end
end
