class RankingController < ApplicationController
  before_action :set_stamps, only: %i[top set_ranking]
  skip_before_action :require_login
  def top
    @current_stamp = 'nice'
    set_stamps_data
  end

  def set_ranking
    @current_stamp = params[:stamp]
    set_stamps_data
    partial_url = @set_period.present? ? 'replacement_for_ranking_this_month' : 'replacement_for_ranking'
    render turbo_stream: turbo_stream.update('change-ranking-list', partial: partial_url)
  end

  private

  def set_stamps
    @stamps = PostStamp.icons
  end

  def set_stamps_data
    @set_period = params[:period].presence
    posts = Post.includes(:user, :profile, :tags, :post_stamps).group(:id)
    posts = posts.filtered_posts_for_user(current_user) if current_user.present?
    posts = posts.where('posts.created_at >= ?', Time.zone.today.beginning_of_month) if @set_period.present?
    @ranking_data = posts.sort_by { |post| -post.stamp_count(@current_stamp) }.first(10)
    @rank_icon =  @current_stamp == 'nice' ? 'bi-hand-thumbs-up-fill' : PostStamp::ICONS[@current_stamp.to_sym]
  end
end
