class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def edit; end

  def create
    @comment = Comment.new(new_comment_params)
    @comments = Comment.where(post_id: @comment.post_id).includes(:user).order(created_at: :desc)
    @post = @comment.post

    if @comment.save
      @comment = Comment.new
    else
      flash.now[:danger] = t('flash.create.danger', item: Comment.model_name.human)
    end
  end

  def update
    return if @comment.update(comment_params)

    render :edit, status: :unprocessable_entity
    flash.now[:danger] = t('flash.update.danger', item: Comment.model_name.human)
  end

  def destroy
    @comment.destroy
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
