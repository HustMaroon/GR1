class Group < ActiveRecord::Base
	mount_uploader :report, ReportUploader
	
  has_many :student_groups
  has_many :students, through: :student_groups
  belongs_to :sclass
  has_many :reports
  has_many :topics

  # def days_to_deadline
  # 	(self.deadline - Date.today).to_i
  # end

end
