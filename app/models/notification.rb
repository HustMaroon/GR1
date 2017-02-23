class Notification < ActiveRecord::Base
	def user
		return self.user_type == 1 ? Teacher.find(self.user_id) : Student.find(self.user_id)
	end
end
