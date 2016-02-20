class Api::V1::UsersController < Api::V1::ApplicationController

	before_action :load_user, only: [:update, :destroy]

	def create
		@user = User.new(user_params)
		if @user.save
			render json: {
				success: true,
				user: @user.as_json({
					only: [:login_token, :email, :name, :online, :state, :country],
					methods: [:image_url]
				})
			}
		else
			render json: {
				success: false,
				messages: @user.errors.full_messages.join(", ")
			}
		end
	end

	def update
		if @user.update_attributes(user_params)
			render json: {
				success: true,
				user: @user.as_json({
					only: [:login_token, :email, :name, :online, :state, :country],
					methods: [:image_url]
				})
			}
		else
			render json: {
				success: false, 
				messages: @user.error.full_messages.join(", ")
			}
		end
	end

	def destroy
		if @user.destroy
			render json: {
				success: true,
				messages: "Successfully deleted."
			}
		else
			render json: {
				success: false,
				messages: "Something went wrong."
			}
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :image, :state, :country, :email, :password, :password_confirmation)
		end

		def load_user
			@user = User.fetch_by_login_token(params[:id])
			(render json: {messages: "User not found", success: false}) if @user.blank?
		end
end