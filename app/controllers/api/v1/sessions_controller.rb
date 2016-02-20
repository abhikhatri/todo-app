class Api::V1::SessionsController < Api::V1::ApplicationController

	def create
		if params[:email] && params[:password]
			@user = User.where(email: params[:email]).first_or_initialize
			if @user.new_record?
				@user.attributes = {password: params[:password], password_confirmation: params[:password]}
				if @user.save
					List.create(user_id: @user.id, name: "todo")
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
			@user.update_attributes(online: true, login_token: SecureRandom.hex(4))
			render json: @user
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