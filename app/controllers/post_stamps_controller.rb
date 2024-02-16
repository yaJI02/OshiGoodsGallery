class PostStampsController < ApplicationController
  before_action :set_stamps, only: %i[registration destroy]

  def registration
    if @stamp.present?
      redirect_to request.referer, flash: { danger: t('flash.post_stamp.danger', item: @stamp.stamp_i18n) }
    else
      @stamp = @post.post_stamps.create(user_id: current_user.id, stamp: PostStamp.stamps[params[:stamp]])
      flash.now[:success] = t('flash.post_stamp.success', item: @stamp.stamp_i18n)
      render turbo_stream: [
        turbo_stream.update("#{@stamp.stamp}-stamp-yet", partial: "reaction_stamps/#{@stamp.stamp}_done", locals: { post: @post }),
        turbo_stream.replace("flash_messages", partial: "shared/flash_message")
      ]
    end
  end

  def destroy
    @stamp.destroy

    flash.now[:success] = t('flash.post_stamp.destroy', item: @stamp.stamp_i18n)
    render turbo_stream: [
      turbo_stream.update("#{@stamp.stamp}-stamp-done", partial: "reaction_stamps/#{@stamp.stamp}_yet", locals: { post: @post }),
      turbo_stream.replace("flash_messages", partial: "shared/flash_message")
    ]
  end

  private

  def set_stamps
    @post = Post.find(params[:id])
    @stamp = PostStamp.find_by(post_id: @post, user_id: current_user.id, stamp: params[:stamp])
  end
end
