class Sclass < ActiveRecord::Base
  validates :sclass_id, uniqueness: true
  
  belongs_to :subject
  belongs_to :teacher
  has_many :learnings
  has_many :students, through: :learnings
  has_many :mini_works
  has_many :tests, through: :test_sclasses
  has_many :documents
  has_many :groups
  has_many :schedules
  has_many :point_components
  has_many :score_tables
  has_many :missed_logs, through: :learnings

  scope :opening_classes, -> {where("start_date <= ? AND end_date >= ?", Date.today, Date.today)}

	def self.search(search)
  		if search
    	where("sclass_id LIKE ?", "%#{search}%")
  		else
    	Sclass.all
  		end
	end

  def make_schedules(weekday, first_lession,last_lession, start_date, end_date)
    start_date = Date.strptime(start_date, '%d/%m/%Y')
    end_date = Date.strptime(end_date, '%d/%m/%Y')
    wdays = weekday.split(',').map{|i| i.to_i}
    days = (start_date..end_date).to_a.select{|k| wdays.include?(k.wday)}
    days.each do |day|
      schedule = self.schedules.build(date: day, first_lession: first_lession.to_i, last_lession: last_lession.to_i) 
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
end
