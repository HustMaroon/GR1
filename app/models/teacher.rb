class Teacher < ActiveRecord::Base
	validates :email, uniqueness: true
	# validates :password, length: {in: 6..20 }
	has_many :sclasses
	has_many :tests
	has_many :notifications
	has_secure_password

	def self.search(search)
  		if search
    	where("name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%")
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

	def self.generate(gender)
		first_name = ["Đỗ", "Nguyễn", "Trần", "Võ", "Lê", "Phạm"]
		male_mid_name = ["Văn", "Công", "Hoàng", "Duy", "Thanh", "Xuân", "Minh"]
		female_mid_name = ["Thị", "Lệ", "Như", "Thu", "Thanh"]
		male_last_name = ["Tùng", "Thành", "Vũ", "Tuấn", "Công", "Thắng", "Minh",
											"Chung", "Trung", "Hải", "Hoàng", "Long", "Quân", "Việt"]
		female_last_name = ["Trang", "Linh", "Hoa", "Thảo", "Lan Anh", "Vân", "Quyên",
											 "My", "Hằng", "Yến", "Tâm", "Duyên", "Ngọc", "Hạnh", "Mai"]
		if gender == "male"
			first_name[rand(first_name.length)] +" "+ male_mid_name[rand(male_mid_name.length)] +
				" "+ male_last_name[rand(male_last_name.length)]
		else
			first_name[rand(first_name.length)] +" "+ female_mid_name[rand(female_mid_name.length)] +
				" "+ female_last_name[rand(female_last_name.length)]
		end
	end

end
