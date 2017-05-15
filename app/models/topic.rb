class Topic < ActiveRecord::Base
  belongs_to :sclass
  has_many :reports, dependent: :destroy

  def days_to_deadline
  	(self.deadline.to_date - Date.today).to_i
  end
end
