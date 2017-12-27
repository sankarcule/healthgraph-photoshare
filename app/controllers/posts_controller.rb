class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  layout "visitors"
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order(updated_at: :desc)
    @subscriptions = Subscription.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save!
    @posts = Post.all.order(updated_at: :desc)
    @subscriptions = Subscription.all
    respond_to do |format|
      format.js
    end
  end

  def user_posts
    @posts = current_user.subscribed_tos.map{|a| a.posts}.flatten.sort{|a,b| b.updated_at <=> a.updated_at}
  end

  def users
    @users = User.all
    @subscriptions = Subscription.all
  end

  def follow
    if params[:type] == 'follow'
      current_user.subscribe(current_user.id, params[:id])
    else
      current_user.unsubscribe(current_user.id, params[:id])
    end
    @posts = Post.all.order(updated_at: :desc)
    @subscriptions = Subscription.all
    @users = User.all
    if params[:page] == "index"
      render partial: 'posts/all_posts', locals: {posts: @posts, subscriptions: @subscriptions}
    else
      render partial: 'posts/all_users', locals: {subscriptions: @subscriptions, users: @users}
    end
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
