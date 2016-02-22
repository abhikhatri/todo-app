class Api::V1::SessionsController < Api::V1::ApplicationController

	def create
		if params[:email] && params[:password]
			@user = User.where(email: params[:email]).first
			if @user.present?
				if @user.valid_password?(params[:password])
					@success = true
				else
					@success = false
					@messages = "Password doesn't match."
				end 
			else
				@success = false
				@messages = "Invalid email and password combination."
			end
		else
			@success = false
			@messages = params[:email].present? ? "Password is missing" : "Email is missing"
		end
		if @success
			@user.update_attributes(online: true, login_token: SecureRandom.hex(4))
			render json: {
				success: true,
				id: @user.id,
				login_token: @user.login_token
			}
		else
			render json: {
				messages: @messages,
				success: false
			}
		end
	end

	def destroy
		@user = User.fetch_by_login_token(params[:id])
		if @user.present?
			if @user.update_attributes(online: false, login_token: "")
				render json: {
					success: true,
					online: @user.online,
					messages: "Successfully loged out."
				}
			else
				render json: {
					success: false,
					messages: @user.errors.full_messages.join(", ")
				}
			end
		else
			render json: {
				success: false,
				messages: "Session does not exist."
			}
		end
	end

end