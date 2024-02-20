class RankingController < ApplicationController
  before_action :set_stamps, only: %i[top]
  skip_before_action :require_login
  def top
    @ranking_data = Post.includes(:user, :profile, :tags, :post_stamps).sort_by { |post| -post.stamp_count('nice') }.first(10)

  def set_stamps
    @stamps = PostStamp.icons
  end
end
