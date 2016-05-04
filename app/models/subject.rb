class Subject < ActiveRecord::Base
	has_many :sclasses

	def self.search(search)
  		if search
    	where("sbj_id LIKE ?", "%#{search}%")
  		else
    	Subject.all
  		end
	end
end
