class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[create new]
  before_action :set_user_post, only: %i[my_page set_user_post_list]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      login(user_params[:email], user_params[:password])
      @profile = Profile.create(user: current_user)
      redirect_to edit_profile_path(current_user.profile), flash: { success: t('flash.create.success', item: User.model_name.human) }
    else
      flash.now[:danger] = t('flash.create.danger', item: User.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def my_page
    @stamps = PostStamp.icons
    @get_stamps = PostStamp.includes(:post).where(posts: { user_id: current_user })
  end

  def set_user_post_list
    render turbo_stream: turbo_stream.update('change-mypage-list', partial: 'user_post_list')
  end

  def set_my_list
    @posts = Post.includes(:user, :profile, :tags, :post_stamps, :my_lists).where(my_lists: { user_id: current_user.id }).page(params[:page])
    render turbo_stream: turbo_stream.update('change-mypage-list', partial: 'my_list')
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def set_user_post
    @posts = Post.where(user_id: current_user).includes(:tags, :post_stamps).page(params[:page])
    @mybest_post = current_user.profile.post_id.nil? ? [] : @posts.find(current_user.profile.post_id)
  end
end
