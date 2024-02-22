class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def edit; end

  def create
    @comment = Comment.new(new_comment_params)

    if @comment.save
      redirect_to post_path(@comment.post_id), flash: { success: t('flash.create.success', item: Comment.model_name.human) }
    else
      redirect_to post_path(@comment.post_id), flash: { danger: t('flash.create.danger', item: Comment.model_name.human) }
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post_id), flash: { success: t('flash.update.success', item: Comment.model_name.human) }
    else
      render :edit, status: :unprocessable_entity
      flash.now[:danger] = t('flash.update.danger', item: Comment.model_name.human)
    end
  end

  def destroy
    @comment.destroy

    redirect_to post_path(@comment.post_id), flash: { success: t('flash.destroy', item: Comment.model_name.human) }
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def new_comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id], user_id: current_user.id)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
