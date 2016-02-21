class UserSerializer < ActiveModel::Serializer
	attributes :login_token,
						 :email,
						 :name,
						 :state,
						 :country,
						 :image_url,
						 :online

		has_many :lists, only: [:id, :name]
end