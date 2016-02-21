class TaskSerializer < ActiveModel::Serializer

	attributes :id,
             :title,
						 :description,
						 :start_time,
						 :end_time,
						 :pause_time,
						 :elapsed_time,
						 :completed
						 
end