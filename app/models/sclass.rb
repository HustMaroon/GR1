class Sclass < ActiveRecord::Base
  belongs_to :subject
  belongs_to :teacher
  has_many :learnings
  has_many :students, through: :learnings
end
