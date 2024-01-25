class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ edit update ]

  # GET /profiles/1 or /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
    @post = Post.find_by(id: @profile.post_id)
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit; end

  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user

    if @profile.save
      redirect_to profile_url(@profile)
      flash[:success] = t('flash.create.success', item: Profile.model_name.human)
    else
      flash.now[:danger] = t('flash.create.danger', item: Profile.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    if @profile.update(profile_params)
      current_user.update(name: params[:profile][:user_name])
      redirect_to profile_url(@profile)
      flash[:success] = t('flash.update.success', item: Profile.model_name.human)
    else
      flash.now[:danger] = t('flash.update.danger', item: Profile.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = current_user.profile
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:avatar, :sns_account, :display_tag_type, :is_display_dislike_tag)
    end
end
