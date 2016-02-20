class Api::V1::ListsController < Api::V1::ApplicationController

	# before_filter :authenticate_user!
	before_action :load_list, only: [:edit, :update, :show, :destroy]

	def index
		render json: {
			list: current_user.lists
		}
	end

	def create
		@list = List.new(list_params)
		if @list.save
			render json: {
				success: true,
				list: @list.as_json({
					only: [:id, :name],
					methods: [:tasks]
				})
			}
		else
			render json: {
				success: false,
				errors: @list.errors.full_messages.join(", ")
			}
		end
	end

	def update
		if @list.update_attributes(list_params)
			render json: {
				success: true,
				list: @list.as_json({
					only: [:id, :name],
					methods: [:tasks]
				})
			}
		else
			render json: {
				success: false,
				errors: @list.errors.full_messages.join(", ")
			}
		end
	end

	def show
		
	end

	def destroy
		if @list.destroy
			render json: {
				success: true,
				message: "Successfully deleted."
			}
		else
			render json: {
				success: false,
				message: "Something went wrong."
			}
		end
	end

	private

		def list_params
			params.require(:list).permit(:user_id, :name)
		end

		def load_list
			@list = List.where(id: params[:id]).first
		end

end