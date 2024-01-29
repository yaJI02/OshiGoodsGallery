class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[create new]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      login(user_params[:email], user_params[:password])
      @profile = Profile.new
      @profile.user = current_user
      @profile.save
      redirect_to edit_profile_path(current_user.profile)
      flash[:success]= t('flash.create.success', item: User.model_name.human)
    else
      flash.now[:danger] = t('flash.create.danger', item: User.model_name.human)
      render :new, status: :unprocessable_entity 
    end
  end

  def my_page
    @posts = Post.where(user_id: current_user).includes(:tags, :post_stamps).page(params[:page])
    @mybest_post = current_user.profile.post_id.nil? ? [] : @posts.find(current_user.profile.post_id)
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
