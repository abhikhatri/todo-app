class Api::V1::SessionsController < Api::V1::ApplicationController

	def create
		if params[:email] && params[:password]
			@user = User.where(email: params[:email]).first_or_initialize
			if @user.new_record?
				@user.attributes = {password: params[:password], password_confirmation: params[:password]}
				if @user.save
					@success = true
				else
					@success = false
					@messages = @user.errors.full_messages.join(", ")
				end
			else
				if @user.valid_password?(params[:password])
					@success = true
				else
					@success = false
					@messages = "Password doesn't match."
				end
			end
		else
			@success = false
			@messages = params[:email].present? ? "Password is missing" : "Email is missing"
		end
		if @success
			render json: @user
		else
			render json: {
				messages: @messages,
				success: false
			}
		end
	end

	def destroy
		@user = User.where(id: params[:id]).first
		if @user.present?
			render json: {
				success: true,
				message: "Successfully loged out."
			}
		else
			render json: {
				success: false,
				message: "Session does not exist."
			}
		end
	end

end