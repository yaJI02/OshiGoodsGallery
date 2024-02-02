class TagsController < ApplicationController
  def destroy
    if current_user.admin_user?
      @tag = Tag.find(params[:id])
      @tag.destroy
      redirect_to admin_tag_index_path, flash: { success: t('flash.destroy', item: Tag.model_name.human) }
    else
      redirect_to root_path, flash: { danger: t('flash.not_authorized') }
    end
  end

end