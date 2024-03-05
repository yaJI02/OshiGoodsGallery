class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[edit update]
  skip_before_action :require_login, only: %i[show]

  # GET /profiles/1 or /profiles/1.json
  def show
    @profile = Profile.includes(:choosy_tags).find(params[:id])
    @post = Post.find_by(id: @profile.post_id)
    @stamps = PostStamp.icons
    user = @profile.user
    @following_users_count = user.following_user.count
    @follower_users_count = user.follower_user.count
  end

  # GET /profiles/1/edit
  def edit
    @favorite_tag_list = Tag.joins(:choosy_tags).where(choosy_tags: { profile_id: @profile, choosy_type: :favorite_tag }).pluck(:name).join(',')
    @dislike_tag_list = Tag.joins(:choosy_tags).where(choosy_tags: { profile_id: @profile, choosy_type: :dislike_tag }).pluck(:name).join(',')
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    if @profile.update(profile_params)
      current_user.update(name: params[:profile][:user_name])
      save_choosy_tags_list
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

  def save_choosy_tags_list
    @f_list = params[:profile][:favorite_tag].present? ? JSON.parse(params[:profile][:favorite_tag]).pluck('value') : []
    @profile.save_choosy_tags(@f_list, 0)
    @d_list = params[:profile][:dislike_tag].present? ? JSON.parse(params[:profile][:dislike_tag]).pluck('value') : []
    @profile.save_choosy_tags(@d_list, 1)
  end

  # Only allow a list of trusted parameters through.
  def profile_params
    params.require(:profile).permit(:avatar, :sns_account, :display_tag_type, :is_display_dislike_tag)
  end
end
