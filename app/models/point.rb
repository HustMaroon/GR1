class Point < ActiveRecord::Base
  belongs_to :score_table
  belongs_to :student

  def get_freq
		self.score_table.score_component.score_tables.count
	end
end
