class Student < ActiveRecord::Base
	has_many :learnings
	has_many :sclasses, through: :learnings
	has_secure_password

	def self.search(search)
  		if search
    	where("name LIKE ?", "%#{search}%")
  		else
    	Student.all
  		end
	end
end
