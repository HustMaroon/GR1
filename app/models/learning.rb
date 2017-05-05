class Learning < ActiveRecord::Base
  validates :sclass_id, uniqueness: {scope: :student_id}
  belongs_to :student
  belongs_to :sclass
  has_many :points, dependent: :destroy
  has_many :missed_logs, dependent: :destroy

  # def self.to_csv(options = {})
  #   CSV.generate(options) do |csv|
  #     csv << column_names
  #     all.each do |learning|
  #       csv << learning.attributes.values_at(*column_names)
  #     end
  #   end
  # end
  def get_avg_score
    0
  end

  def classify
    'F'
  end
end
