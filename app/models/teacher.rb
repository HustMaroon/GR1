class Teacher < ActiveRecord::Base
	has_many :sclasses
	has_secure_password

	def self.search(search)
  		if search
    	where("name LIKE ?", "%#{search}%")
  		else
    	Teacher.all
  		end
	end
end
