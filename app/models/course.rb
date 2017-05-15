class Course < ActiveRecord::Base
	validates :course_id, uniqueness: true
	has_many :sclasses

	def self.search(search)
  		if search
    	where("course_id LIKE ?", "%#{search}%")
  		else
    	Course.all
  		end
	end
end
