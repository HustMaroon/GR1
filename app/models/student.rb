class Student < ActiveRecord::Base
	validates :std_id, uniqueness: true
	has_many :learnings
	has_many :sclasses, through: :learnings
	has_many :mini_works, through: :sclasses
	has_many :student_groups
	has_many :groups, through: :student_groups
	has_secure_password

	def self.search(search)
  		if search
    	where("name LIKE ?", "%#{search}%")
  		else
    	Student.all
  		end
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
		Notification.where(user_id: self.id, user_type: 2)
	end

	def get_missed_lessons sclass
		learning = Learning.find_by(student: self, sclass: sclass)
		learning.missed_logs.count
	end

	def name_and_id
		std = Student.find(self.id)
		if std.std_id.nil?
			"#{std.name}"
		else
			"#{std.name}-#{std.std_id}"
		end
	end
	
end
