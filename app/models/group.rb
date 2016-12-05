class Group < ActiveRecord::Base
  belongs_to :sclass
  belongs_to :topic
  has_many :student_groups
  has_many :students, through: :student_groups
end
