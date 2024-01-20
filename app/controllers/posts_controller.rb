class PostsController < ApplicationController
  before_action :set_post, only: %i[ edit update destroy ]
  skip_before_action :require_login, only: %i[index]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @post_places = @post.places
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @place_list = @post.places.pluck(:name).join(',')
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)
    place_list = params[:post][:place].split(',')
    if @post.save
      @post.save_places(place_list)
      redirect_to post_url(@post)
      flash[:success]= '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new, status: :unprocessable_entity 
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    place_list = params[:post][:place].split(',')
    if @post.update(post_params)
      @post.save_places(place_list)
      redirect_to post_url(@post)
      flash[:success]= '投稿を更新しました'
    else
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
    @post = current_user.posts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :purchase_cost, :bought_at, :post_type, :purchase_status, :photo)
  end
end
