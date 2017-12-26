class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @subscriptions = Subscription.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @posts = Post.all
    @subscriptions = Subscription.all
    render partial: 'posts/all_posts', locals: {posts: @posts, subscriptions: @subscriptions}
  end

  def user_posts
    @posts = Post.all
  end

  def users
    @users = User.all
  end

  def follow
    if params[:type] == 'follow'
      current_user.subscribe(current_user.id, params[:id])
    else
      current_user.unsubscribe(current_user.id, params[:id])
    end
    @posts = Post.all
    @subscriptions = Subscription.all
    render partial: 'posts/all_posts', locals: {posts: @posts, subscriptions: @subscriptions}
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:caption, :image, :user_id)
    end
end
