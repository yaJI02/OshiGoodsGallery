class PostStampsController < ApplicationController
  before_action :set_stamps, only: %i[registration destroy]
  before_action :stamp_authorized, only: %i[registration]

  def registration
    @stamp = @post.post_stamps.create(user_id: current_user.id, stamp: PostStamp.stamps[params[:stamp]])
    flash.now[:success] = t('flash.post_stamp.success', item: @stamp.stamp_i18n)
    stamp_partial = @stamp.stamp == 'nice' ? 'reaction_stamps/nice_done' : 'reaction_stamps/done'
    stamp_locals = { post: @post }
    stamp_locals[:stamp] = @stamp.stamp if @stamp.stamp != 'nice'
    stamp_locals[:icon] = @stamp.icon_name if @stamp.stamp != 'nice'

    render turbo_stream: [
      turbo_stream.replace("#{@stamp.stamp}-stamp-yet", partial: stamp_partial, locals: stamp_locals),
      turbo_stream.replace('flash_messages', partial: 'shared/flash_message')
    ]
  end

  def destroy
    @stamp.destroy

    flash.now[:success] = t('flash.post_stamp.destroy', item: @stamp.stamp_i18n)
    stamp_partial = @stamp.stamp == 'nice' ? 'reaction_stamps/nice_yet' : 'reaction_stamps/yet'
    stamp_locals = { post: @post }
    stamp_locals[:stamp] = @stamp.stamp if @stamp.stamp != 'nice'
    stamp_locals[:icon] = @stamp.icon_name if @stamp.stamp != 'nice'

    render turbo_stream: [
      turbo_stream.replace("#{@stamp.stamp}-stamp-done", partial: stamp_partial, locals: stamp_locals),
      turbo_stream.replace('flash_messages', partial: 'shared/flash_message')
    ]
  end

  private

  def set_stamps
    @post = Post.find(params[:id])
    @stamp = PostStamp.find_by(post_id: @post, user_id: current_user.id, stamp: params[:stamp])
  end

  def stamp_authorized
    redirect_to request.referer, flash: { danger: t('flash.post_stamp.mypost') } if params[:stamp] == 'nice' && @post.user == current_user
    redirect_to request.referer, flash: { danger: t('flash.post_stamp.danger', item: @stamp.stamp_i18n) } if @stamp.present?
  end
end
