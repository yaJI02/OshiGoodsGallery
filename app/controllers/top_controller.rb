class TopController < ApplicationController
  skip_before_action :require_login

  def index;end
  def terms_of_use;end
  def about;end
  def privacy_policy;end
end