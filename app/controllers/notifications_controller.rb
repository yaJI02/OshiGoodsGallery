class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page]).per(20)
    @notifications.where(checked: false).find_each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    @notifications = current_user.notifications.find(params[:id])
    @notifications.destroy
    redirect_to notifications_path
  end

  def destroy_all
    @notifications = current_user.notifications.destroy_all
    redirect_to notifications_path
  end
end
