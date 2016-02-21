class Api::V1::TasksController < Api::V1::ApplicationController

	before_action :load_task, only: [:update, :destroy, :end_task, :start_task]

	def index
		@list = List.where(id: params[:list_id]).first
		render json: @list.tasks
	end

	def create
		@task = Task.new(task_params)
		if @task.save
			render json: {
				success: true,
				task: @task.as_json({
					only: [:id, :title, :description]
				})
			}
		else
			render json: {
				success: false,
				messages: @task.errors.full_messages.join(", ")
			}
		end
	end

	def update
		if @task.update_attributes(task_params)
			render json: {
				success: true,
				task: @task.as_json({
					only: [:id, :title, :description]
				})
			}
		else
			render json: {
				success: false,
				messages: @task.errors.full_messages.join(", ")
			}
		end
	end

	def destroy
		if @task.destroy
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

	def start_task
		if @task.update_attributes(start_time: Time.zone.now, active: true)
			render json: {
				success: true,
				start_time: @task.start_time
			}
		else
			render json: {
				success: false,
				messages: @task.errors.full_messages.join(", ")
			}
		end
	end

	def end_task
		if @task.update_attributes(end_time: Time.zone.now, active: false, elapsed_time: (Time.zone.now - @task.start_time).to_f / 3600)
			render json: {
				success: true,
				start_time: @task.start_time,
				end_time: @task.end_time,
				elapsed_time: ((@task.end_time - @task.start_time).to_f / 3600).round(2)
			}
		else
			render json: {
				success: false,
				messages: @task.errors.full_messages.join(", ")
			}
		end
	end

	private

		def task_params
			params.require(:task).permit(:title, :description, :list_id)
		end

		def load_task
			id = params[:id] || params[:task_id]
			@task = Task.where(id: id).first
			(render json: {messages: "Task not found. ", success: false}) if @task.blank?
		end

end