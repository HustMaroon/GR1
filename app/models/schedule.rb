class Schedule < ActiveRecord::Base
  belongs_to :sclass
  has_many :missed_logs, dependent: :destroy
end
