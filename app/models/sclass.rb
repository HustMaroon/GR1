class Sclass < ActiveRecord::Base
  belongs_to :subject
  belongs_to :teacher
  has_many :learnings
  has_many :students, through: :learnings
  has_many :mini_works
  has_many :tests, through: :test_sclasses
  has_many :documents

	def self.search(search)
  		if search
    	where("sclass_id LIKE ?", "%#{search}%")
  		else
    	Sclass.all
  		end
	end
end
