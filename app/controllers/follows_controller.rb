class FollowsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer, flash: { success: 'フォローしました' }
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer, flash: { success: 'フォロー解除しました' }
  end
end
