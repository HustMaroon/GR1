class Learning < ActiveRecord::Base
  validates :sclass_id, uniqueness: {scope: :student_id}
  belongs_to :student
  belongs_to :sclass
  belongs_to :group

  # def self.to_csv(options = {})
  #   CSV.generate(options) do |csv|
  #     csv << column_names
  #     all.each do |learning|
  #       csv << learning.attributes.values_at(*column_names)
  #     end
  #   end
  # end
  def get_avg_score
    process_score = self.get_process_score
    term_ratio = self.sclass.course.term_ratio
    avg = self.term_point * term_ratio + process_score * (1 - term_ratio )
    avg.round(2)
  end

  def get_process_score
    bonus = self.get_bonus
    score = 0
    self.points.each do |point|
      score += point.value * point.score_table.score_component.ratio / point.get_freq / 100
    end
    if score + bonus < 0
      return 0
    else
      return score + bonus
    end
  end

  def get_bonus
    sclass = self.sclass
    student = self.student
    days_off = sclass.missed_logs.where(student: student).count
    sclass.bonus.each do |bonu|
      return bonu.bonus if bonu.match?(days_off)
    end
    return 0
  end

  def classify
    avg_score = self.get_avg_score
    if avg_score < 4
      'F'
    elsif avg_score >= 4 && avg_score <= 5
      'D'
    elsif avg_score >=5 && avg_score < 6
      'D+'
    elsif avg_score >=6 && avg_score <6.5
      'C'
    elsif avg_score >=6.5 && avg_score <7
      'C+'
    elsif avg_score >= 7 && avg_score <8
      'B'
    elsif avg_score >=8 && avg_score <8.5
      'B+'
    elsif avg_score >=8.5 && avg_score < 10
      'A'
    elsif avg_score == 10
      'A+'
    end       
        
        
      
  end

  def points
    self.sclass.points.where(student: self.student)
  end
end
