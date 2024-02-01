class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path, flash: { danger: t('flash.not_login') }
  end
end
