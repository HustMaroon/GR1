class ScoreComponent < ActiveRecord::Base
  belongs_to :sclass
  has_many :score_tables
end
