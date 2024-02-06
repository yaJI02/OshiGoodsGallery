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

  def get_all_post_place
    @tags = Place.pluck(:name)
    render json: @tags
  end

  def get_all_post_content_tag
    @tags = Tag.content_tag.pluck(:name)
    render json: @tags
  end

  def get_all_post_merchandise_tag
    @tags = Tag.merchandise_tag.pluck(:name)
    render json: @tags
  end
end