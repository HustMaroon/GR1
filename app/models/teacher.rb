class Teacher < ActiveRecord::Base
	validates :email, uniqueness: true
	has_many :sclasses
	has_many :tests
	has_secure_password

	def self.search(search)
  		if search
    	where("name LIKE ?", "%#{search}%")
  		else
    	Teacher.all
  		end
	end
end
