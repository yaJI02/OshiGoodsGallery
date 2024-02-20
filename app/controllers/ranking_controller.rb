class RankingController < ApplicationController
  before_action :set_stamps, only: %i[top set_ranking]
  skip_before_action :require_login
  def top
    @ranking_data = Post.includes(:user, :profile, :tags, :post_stamps).sort_by { |post| -post.stamp_count('nice') }.first(10)
  end

  def set_ranking
    stamp = params[:stamp]
    @ranking_data = Post.includes(:user, :profile, :tags, :post_stamps).sort_by { |post| -post.stamp_count(stamp) }.first(10)
    @rank_icon =  PostStamp::ICONS[stamp.to_sym]
    render turbo_stream: turbo_stream.update('change-ranking-list', partial: "#{stamp}_ranking")
  end

  private

  def set_stamps
    @stamps = PostStamp.icons
  end
end
