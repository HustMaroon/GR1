class MissedLog < ActiveRecord::Base
  belongs_to :student
  belongs_to :schedule

  def self.search(search)
  		if search
    		where(student: Student.search(search)) +  where(schedule: Schedule.search(search))
  		else
    	MissedLog.all
  		end
	end
end
