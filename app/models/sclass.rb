class Sclass < ActiveRecord::Base
  validates :sclass_id, uniqueness: true
  
  belongs_to :course
  belongs_to :teacher
  has_many :learnings, dependent: :destroy
  has_many :students, through: :learnings
  has_many :groups, -> { distinct }, through: :learnings
  has_many :documents, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :score_components, dependent: :destroy
  has_many :score_tables, through: :score_components
  has_many :topics, dependent: :destroy
  has_many :missed_logs, through: :schedules
  has_many :points, through: :score_tables
  has_many :bonus, dependent: :destroy
  scope :opening_classes, -> {where("start_date <= ? AND end_date >= ?", Date.today, Date.today)}

	def self.search(search)
  		if search
    	where("sclass_id LIKE ?", "%#{search}%")
  		else
    	Sclass.all
  		end
	end

  def make_schedules(weekday, first_lesson,last_lesson, start_date, end_date)
    start_date = Date.strptime(start_date, '%d/%m/%Y')
    end_date = Date.strptime(end_date, '%d/%m/%Y')
    wdays = weekday.split(',').map{|i| i.to_i}
    days = (start_date..end_date).to_a.select{|k| wdays.include?(k.wday)}
    days.each do |day|
      schedule = self.schedules.build(date: day, first_lesson: first_lesson.to_i, last_lesson: last_lesson.to_i) 
      schedule.save
    end
  end

  def get_remaining_lessons
    remaining_lessons = 0;
    self.schedules.each do |sc|
      if (Date.today <=> sc.date) == 1
        remaining_lessons += 1
      end        
    end
    return remaining_lessons
  end

  def ungrouped_students
    groups = self.groups
    grouped_students = []
    if groups.empty?
      @students = self.students
    else
      groups.each do |g|
        g.students.each do |s|
            grouped_students << s
        end
      end
      @students = self.students - grouped_students
    end
    return @students
  end

  # def groups
  #   groups = []
  #   groups << self.learnings.first.group
  #   self.learnings.each do |learning|
  #     groups << learning.group unless learning.group.in? groups
  #   end
  #   return groups
  # end
end
