class Learning < ActiveRecord::Base
  belongs_to :student
  belongs_to :sclass
  has_many :points
  has_many :missed_logs
end
