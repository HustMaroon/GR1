class Group < ActiveRecord::Base
	mount_uploader :report, ReportUploader
	
  has_many :student_groups
  has_many :students, through: :student_groups
  belongs_to :sclass

  def days_to_deadline
  	(self.deadline - Date.today).to_i
  end

end
