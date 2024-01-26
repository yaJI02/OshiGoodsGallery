class PostsController < ApplicationController
  before_action :set_post, only: %i[ edit update destroy ]
  before_action :set_list, only: %i[ create update ]
  before_action :set_stamps, only: %i[ new edit ]
  skip_before_action :require_login, only: %i[index]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.includes(:tags, :post_stamps).page(params[:page])
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @post_user_profile = Profile.find_by(user_id: @post.user_id)
    @post_places = @post.places
    @post_merchandise_tags = @post.tags.merchandise
    @post_content_tags = @post.tags.content
    @oshi_point_stamps = @post.post_stamps.where(user_id: @post.user_id)
  end

  # GET /posts/new
  def new
    @post = Post.new
    @oshi_point_stamps_list = []
  end

  # GET /posts/1/edit
  def edit
    @place_list = @post.places.pluck(:name).join(',')
    @merchandise_tag_list = @post.tags.merchandise.pluck(:name).join(',')
    @content_tag_list = @post.tags.content.pluck(:name).join(',')
    @oshi_point_stamps_list = @post.post_stamps.where(user_id: @post.user_id).pluck(:stamp)
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      @post.save_places(@p_list)
      @post.save_tags(@m_list, 0)
      @post.save_tags(@c_list, 1)
      @post.save_post_stamps(@s_list)
      redirect_to post_url(@post)
      flash[:success]= '投稿しました'
    else
      @stamps = PostStamp.stamps.keys
      @stamps.shift
      @place_list = params[:post][:place]
      @merchandise_tag_list = params[:post][:merchandise_tag]
      @content_tag_list = params[:post][:content_tag]
      @oshi_point_stamps_list = @s_list
      flash.now[:danger] = '投稿に失敗しました'
      render :new, status: :unprocessable_entity 
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.update(post_params)
      @post.save_places(@p_list)
      @post.save_tags(@m_list, 0)
      @post.save_tags(@c_list, 1)
      @post.save_post_stamps(@s_list)
      redirect_to post_url(@post)
      flash[:success]= '投稿を更新しました'
    else
      @stamps = PostStamp.stamps.keys
      @stamps.shift
      @place_list = params[:post][:place]
      @merchandise_tag_list = params[:post][:merchandise_tag]
      @content_tag_list = params[:post][:content_tag]
      @oshi_point_stamps_list = @s_list
      render :edit, status: :unprocessable_entity
      flash.now[:danger] = '投稿の更新に失敗しました'
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    redirect_to posts_url
    flash[:success]= '投稿を削除しました'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    unless Post.find(params[:id]).user == current_user
      redirect_to post_path(params[:id])
      flash[:danger] = t('flash.not_authorized')
    else
      @post = current_user.posts.find(params[:id])
    end
  end

  def set_list
    @p_list = params[:post][:place].split(',')
    @m_list = params[:post][:merchandise_tag].split(',')
    @c_list = params[:post][:content_tag].split(',')
    @s_list = params[:post][:post_stamp].nil? ? [] : params[:post][:post_stamp]
  end

  def set_stamps
    @stamps = PostStamp.stamps.keys
    @stamps.shift
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :purchase_cost, :bought_at, :post_type, :purchase_status, :photo, :photo_cache)
  end
end
