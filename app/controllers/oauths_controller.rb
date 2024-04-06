class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    return redirect_to root_path, flash: { danger: t('flash.login.danger') } if logged_in?

    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      if @user.profile.nil?
        @profile = Profile.create(user: @user)
        redirect_to edit_profile_path(@profile), flash: { success: t('flash.oauth_login.success', item: provider.titleize) }
      else
        redirect_to root_path, flash: { success: t('flash.oauth_login.success', item: provider.titleize) }
      end
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        @profile = Profile.create(user: current_user)
        redirect_to edit_profile_path(@profile), flash: { success: t('flash.oauth_login.success', item: provider.titleize) }
      rescue StandardError
        redirect_to login_path, flash: { danger: t('flash.oauth_login.danger', item: provider.titleize) }
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
