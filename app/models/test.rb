class Test < ActiveRecord::Base
  belongs_to :teacher
  has_many :questions
  has_many :sclasses, through: :test_sclasses
end
