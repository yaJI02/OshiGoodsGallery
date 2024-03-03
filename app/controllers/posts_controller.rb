class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  before_action :set_list, only: %i[create update]
  before_action :set_stamps, only: %i[new edit show index]
  skip_before_action :require_login, only: %i[index show]

  # GET /posts or /posts.json
  def index
    @post_types = Post.post_types.keys
    @q = Post.includes(:user, :profile, :tags, :post_stamps)
    @q = @q.filtered_posts_for_user(current_user) if current_user.present?

    if params[:q].present?
      search_freeword = params[:q][:title_or_body_or_user_name_or_places_name_or_tags_name_cont].presence
      search_type = params[:q][:post_type_eq].presence
      search_stamp = params[:q][:author_stamped_posts].presence
    end

    if search_freeword.present?
      keywords = search_freeword.split(',')
      grouping_hash = keywords.map { |word| { title_or_body_or_user_name_or_places_name_or_tags_name_cont: word } }
      grouping_hash << { post_type_eq: search_type } if search_type.present?
      @q = @q.ransack(combinator: 'and', groupings: grouping_hash)
    else
      @q = @q.ransack(params[:q])
    end

    @posts = search_stamp.present? ? @q.result.author_stamped_posts(search_stamp) : @q.result.group(:id)
    @posts = @posts.order(created_at: :DESC).page(params[:page])
    @search_words = search_freeword.presence
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.includes(:user, :profile, :tags, :post_stamps, :my_lists).find(params[:id])
    @post_merchandise_tag = @post.tags.merchandise_tag
    @post_cotent_tag = @post.tags.content_tag
    @oshi_point_stamps = @post.post_stamps.where(user_id: @post.user_id)
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  # GET /posts/new
  def new
    @post = Post.new
    @oshi_point_stamps_list = []
  end

  # GET /posts/1/edit
  def edit
    @place_list = @post.places.pluck(:name).join(',')
    @merchandise_tag_list = @post.tags.merchandise_tag.pluck(:name).join(',')
    @content_tag_list = @post.tags.content_tag.pluck(:name).join(',')
    @oshi_point_stamps_list = @post.post_stamps.where(user_id: @post.user_id).pluck(:stamp)
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      save_accessories
      redirect_to post_url(@post), flash: { success: t('flash.create.success', item: Post.model_name.human) }
    else
      set_stamps
      set_cache
      flash.now[:danger] = t('flash.create.danger', item: Post.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.update(post_params)
      save_accessories
      redirect_to post_url(@post), flash: { success: t('flash.update.success', item: Post.model_name.human) }
    else
      set_stamps
      set_cache
      render :edit, status: :unprocessable_entity
      flash.now[:danger] = t('flash.update.danger', item: Post.model_name.human)
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    if current_user.admin_user?
      redirect_to admin_index_path, flash: { success: t('flash.destroy', item: Post.model_name.human) }
    else
      redirect_to posts_url, flash: { success: t('flash.destroy', item: Post.model_name.human) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    if Post.find(params[:id]).user == current_user
      @post = current_user.posts.find(params[:id])
    elsif current_user.admin_user?
      @post = Post.find(params[:id])
    else
      redirect_to post_path(params[:id]), flash: { danger: t('flash.not_authorized') }
    end
  end

  def set_list
    @p_list = params[:post][:place].present? ? JSON.parse(params[:post][:place]).pluck('value') : []
    @m_list = params[:post][:merchandise_tag].present? ? JSON.parse(params[:post][:merchandise_tag]).pluck('value') : []
    @c_list = params[:post][:content_tag].present? ? JSON.parse(params[:post][:content_tag]).pluck('value') : []
    @s_list = params[:post][:post_stamp].presence || []
  end

  def set_stamps
    @stamps = PostStamp.icons
  end

  def set_cache
    @place_list = params[:post][:place]
    @merchandise_tag_list = params[:post][:merchandise_tag]
    @content_tag_list = params[:post][:content_tag]
    @oshi_point_stamps_list = @s_list
  end

  def save_accessories
    @post.save_places(@p_list)
    @post.save_tags(@m_list, 0)
    @post.save_tags(@c_list, 1)
    @post.save_post_stamps(@s_list)
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :purchase_cost, :bought_at, :post_type, :purchase_status, :photo, :photo_cache, :display_comment)
  end
end
