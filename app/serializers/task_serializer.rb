class TaskSerializer < ActiveModel::Serializer

	attributes :title,
						 :description,
						 :start_time,
						 :end_time,
						 :pause_time,
						 :elapsed_time
						 
end