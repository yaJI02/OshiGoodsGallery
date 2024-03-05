class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[create new]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path, flash: { success: t('flash.login.success') }
    else
      flash.now[:danger] = t('flash.login.danger')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to login_path, status: :see_other, flash: { success: t('flash.logout') }
  end
end
