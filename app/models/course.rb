class Course < ActiveRecord::Base
	validates :course_id, uniqueness: true
	has_many :sclasses, dependent: :destroy

	def self.search(search)
  		if search
    	where("course_id LIKE ? OR name LIKE ?", "%#{search}%", "%#{search}%")
  		else
    	Course.all
  		end
	end
end
