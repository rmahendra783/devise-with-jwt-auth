class ApplicationController < ActionController::Base
	# include Devise::Controllers::Helpers
    skip_before_action :verify_authenticity_token
    # before_action :set_current_user
    # before_action :set_flash

	private
	def authenticate_request
	    header = request.headers['token'] || params[:token]
	    header = header.split(' ').last if header
	    begin
	      @decoded = JsonWebToken.decode(header)
	      @current_user = User.find_by(id: @decoded[:user_id])
	    rescue ActiveRecord::RecordNotFound => e
	      render json: { errors: e.message }, status: :unauthorized
	    rescue JWT::DecodeError => e
	      render json: { errors: e.message }, status: :unauthorized
	    end
	end

	# def set_flash
	# 	flash[:notice] = "log out successfully"
	# end

end

