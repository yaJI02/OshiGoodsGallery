class RankingController < ApplicationController
  before_action :set_stamps, only: %i[top]
  skip_before_action :require_login
  def top
    @nice_ranking = Post.includes(:user, :profile, :tags, :post_stamps).sort_by { |post| -post.nice_count }.first(10)
  end

  def set_stamps
    @stamps = PostStamp.icons
  end
end
