class UserSerializer < ActiveModel::Serializer
	attributes :login_token,
						 :email,
						 :online

		has_many :lists
end