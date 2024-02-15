class MyListController < ApplicationController
  before_action :set_my_list, only: %i[registration destroy]

  def registration
    if @mylist.present?
      redirect_to request.referer, flash: { danger: t('flash.my_list.danger') }
    else
      current_user.my_lists.create(post_id: @post.id)
      redirect_to post_path(@post), flash: { success: t('flash.my_list.success') }
    end
  end

  def destroy
    @mylist.destroy

    redirect_to request.referer, flash: { success: t('flash.my_list.destroy') }
  end

  private

  def set_my_list
    @post = Post.find(params[:id])
    @mylist = MyList.find_by(post_id: @post, user_id: current_user)
  end
end
