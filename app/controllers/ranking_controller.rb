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
    render turbo_stream: turbo_stream.update('change-ranking-list', partial: 'replacement_for_ranking')
  end

  private

  def set_stamps
    @stamps = PostStamp.icons
  end

  def set_stamps_data
    @ranking_data = Post.includes(:user, :profile, :tags, :post_stamps).sort_by { |post| -post.stamp_count(@current_stamp) }.first(10)
    current_stamp_value = PostStamp.stamps[@current_stamp.to_sym]
    @previous_stamp = @current_stamp == 'nice' ? 'awesome' : PostStamp.stamps.key(current_stamp_value - 1)
    @next_stamp = @current_stamp == 'awesome' ? 'nice' : PostStamp.stamps.key(current_stamp_value + 1)
    @rank_icon =  @current_stamp == 'nice' ? 'bi-hand-thumbs-up-fill' : PostStamp::ICONS[@current_stamp.to_sym]
  end
end
