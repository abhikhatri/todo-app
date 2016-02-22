class UserSerializer < ActiveModel::Serializer
	attributes :id,
						 :login_token,
						 :email,
						 :name,
						 :state,
						 :country,
						 :image_url,
						 :online

		has_many :lists, only: [:id, :name]
end