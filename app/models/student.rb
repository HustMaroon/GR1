class Student < ActiveRecord::Base
	has_many :learnings
	has_many :sclasses, through: :learnings
	has_many :mini_works, through: :sclasses
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
end
