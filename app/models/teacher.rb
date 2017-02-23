class Teacher < ActiveRecord::Base
	validates :email, uniqueness: true
	has_many :sclasses
	has_many :tests
	has_many :notifications
	has_secure_password

	def self.search(search)
  		if search
    	where("name LIKE ?", "%#{search}%")
  		else
    	Teacher.all
  		end
	end

	def get_schedules date
		self.schedules.select do |sc|
			sc[:date] == date
		end
	end

	def schedules
		schedules = []
		self.sclasses.each do |sc|
			schedules += sc.schedules
		end
		schedules
	end

	def notifications
		Notification.where(user_id: self.id, user_type: 1)
	end

end
