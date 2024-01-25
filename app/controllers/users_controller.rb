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
      redirect_to new_profile_path
      flash[:success]= '新規登録が完了しました'
    else
      flash.now[:danger] = '新規登録に失敗しました'
      render :new, status: :unprocessable_entity 
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name)
    end
end
