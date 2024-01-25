class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create new]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      if @user.profile.nil?
        redirect_to new_profile_path
        flash[:success] = 'ログインしました'
      else
        redirect_to root_path
        flash[:success] = 'ログインしました'
      end
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to login_path, status: :see_other
    flash[:success]= 'ログアウトしました'
  end
end
