class Group < ActiveRecord::Base
	mount_uploader :report, ReportUploader
	
  has_many :learnings
  has_many :students, through: :learnings
  has_many :reports
  # has_one :sclass, through: :learnings
  # def days_to_deadline
  # 	(self.deadline - Date.today).to_i
  # end
  def add_member(learning)
    learning.update_attributes(group: self) unless self.students.exists?(learning.student.id)
  end

  def sclass
    self.learnings.first.sclass
  end

  def group_score
    group_score = 0
    self.reports.each do |report|
      group_score += report.score * report.topic.ratio/100 unless report.score.nil?
    end
    return group_score
  end

end
