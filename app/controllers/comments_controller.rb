# app/controllers/comments_controller.rb

class CommentsController < ApplicationController
  before_action :authenticate_request
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :set_user, only: [:show, :update, :destroy]

  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comments
  def index
    @comments = Comment.all
    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  # def create
  #   @comment = Comment.new(comment_params)

  #   if @comment.save
  #     render json: @comment, status: :created, location: @comment
  #   else
  #     render json: @comment.errors, status: :unprocessable_entity
  #   end
  # end


  def create
  	# byebug
  	# @current_user = @user
    @comment = Comment.new(comment_params)
    @comment.user = @current_user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    begin
      # @post = Post.find(params[:id])
      @post = Post.find_by(id: params[:post_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Post not found' }, status: :not_found
    end
  end

  def set_user
    @user = User.find(params[:id])
    render json: { error: 'user not found' }, status: :not_found
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
