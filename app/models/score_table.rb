class ScoreTable < ActiveRecord::Base
  belongs_to :sclass
  belongs_to :score_component
  has_many :points, dependent: :destroy
end
