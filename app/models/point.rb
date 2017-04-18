class Point < ActiveRecord::Base
  belongs_to :score_table
  belongs_to :learning
end
