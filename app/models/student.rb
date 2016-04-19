class Student < ActiveRecord::Base
	has_many :learnings
	has_many :sclasses, through: :learnings
end
