class Learning < ActiveRecord::Base
  belongs_to :student
  belongs_to :sclass
  has_many :points
  has_many :missed_logs

  # def self.to_csv(options = {})
  #   CSV.generate(options) do |csv|
  #     csv << column_names
  #     all.each do |learning|
  #       csv << learning.attributes.values_at(*column_names)
  #     end
  #   end
  # end
end
