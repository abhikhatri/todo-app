class List < ActiveRecord::Base

	has_many :tasks
	belongs_to :user

	validate :user_presence

	private

		def user_presence
			if User.where(id: self.user_id).blank?
				self.errors.add(:base, "User not present, may be you are not logged in.")
			end
		end
	
end
