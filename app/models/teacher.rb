class Teacher < ActiveRecord::Base
	has_many :sclasses

	def self.search(search)
  		if search
    	where("name LIKE ?", "%#{search}%")
  		else
    	Teacher.all
  		end
	end
end
