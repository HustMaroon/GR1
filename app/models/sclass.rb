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

	def self.search(search)
  		if search
    	where("sclass_id LIKE ?", "%#{search}%")
  		else
    	Sclass.all
  		end
	end

  def make_schedule(weekday, lession, start_date, end_date)
    start_date = Date.strptime(start_date, '%d/%m/%Y')
    end_date = Date.strptime(end_date, '%d/%m/%Y')
    wdays = weekday.split(',').map{|i| i.to_i}
    days = (start_date..end_date).to_a.select{|k| wdays.include?(k.wday)}
    days.each do |day|
      schedule = this.schedules.build(date: day, start_time: get_start_time(lession), end_time: get_end_time(lession))
      schedule.save
    end
  end

  def get_start_time(lession)
  end

  def get_end_time(lession)
  end
end
