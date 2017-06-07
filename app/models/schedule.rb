class Schedule < ActiveRecord::Base
  belongs_to :sclass
  has_many :missed_logs, dependent: :destroy

  def self.search(search)
  		if search
    	where("date LIKE ?", "%#{search}%")
  		else
    	Schedule.all
  		end
	end
end
