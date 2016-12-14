class Sclass < ActiveRecord::Base
  belongs_to :subject
  belongs_to :teacher
  has_many :learnings
  has_many :students, through: :learnings
  has_many :mini_works
  has_many :tests, through: :test_sclasses
  has_many :documents
  has_many :groups
  has_many :topics
  has_many :schedules
  has_many :point_components
  has_many :score_tables

	def self.search(search)
  		if search
    	where("sclass_id LIKE ?", "%#{search}%")
  		else
    	Sclass.all
  		end
	end
end
