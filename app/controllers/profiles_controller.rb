class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[edit update]
  skip_before_action :require_login, only: %i[show]

  # GET /profiles/1 or /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
    @post = Post.find_by(id: @profile.post_id)
    @stamps = PostStamp.icons
  end

  # GET /profiles/1/edit
  def edit
    @favorite_tag_list = Tag.joins(:choosy_tags).where(choosy_tags: { choosy_type: :favorite_tag }).pluck(:name).join(',')
    @dislike_tag_list = Tag.joins(:choosy_tags).where(choosy_tags: { choosy_type: :dislike_tag }).pluck(:name).join(',')
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    if @profile.update(profile_params)
      current_user.update(name: params[:profile][:user_name])
      redirect_to profile_url(@profile), flash: { success: t('flash.update.success', item: Profile.model_name.human) }
    else
      flash.now[:danger] = t('flash.update.danger', item: Profile.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def my_best
    post = Post.find(params[:id])
    if post.user == current_user
      current_user.profile.update(post_id: post.id)
      redirect_to my_page_users_path
    else
      redirect_to my_page_users_path, flash: { danger: t('flash.update.danger', item: 'マイベスト投稿') }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    if Profile.find(params[:id]).user_id == current_user.id
      @profile = current_user.profile
    else
      redirect_to profile_path(params[:id]), flash: { danger: t('flash.not_authorized') }
    end
  end

  # Only allow a list of trusted parameters through.
  def profile_params
    params.require(:profile).permit(:avatar, :sns_account, :display_tag_type, :is_display_dislike_tag)
  end
end
