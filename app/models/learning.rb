class Learning < ActiveRecord::Base
  belongs_to :student
  belongs_to :sclass
  has_many :points
end
