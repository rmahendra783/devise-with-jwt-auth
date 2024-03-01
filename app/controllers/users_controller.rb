# app/controllers/users_controller.rb

class UsersController < ApplicationController
  before_action :authenticate_request, except: [:create,:index]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    # @user = User.new(user_params)
    @user = User.new(name: params[:name], email: params[:email], password: params[:password])


    if @user.save
      SendEmailsJob.send_email_perameter(@user)
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
  	@current_user = @user
    if @current_user&.update(name: params[:name])
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
