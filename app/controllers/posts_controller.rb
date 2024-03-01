# app/controllers/posts_controller.rb

class PostsController < ApplicationController
  before_action :authenticate_request
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all
    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
  	@post = @current_user.posts.build(title: params[:title], content: params[:content])

    # @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
  	@current_user = @user
    if @post.update(title: params[:title], content: params[:content])
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
	def destroy
	  if @post
	    @post.destroy
	    if @post.destroyed?
	      render json: { message: 'Post successfully destroyed' }, status: :ok
	    else
	      render json: { error: 'Failed to destroy post' }, status: :unprocessable_entity
	    end
	  else
	    render json: { error: 'Post not found' }, status: :not_found
	  end
	end

  private

  def set_post
    @post = Post.find(params[:id])
    render json: { error: 'Post not found' }, status: :not_found
  end

  def set_user
    @user = User.find(params[:id])
    render json: { error: 'user not found' }, status: :not_found
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end
