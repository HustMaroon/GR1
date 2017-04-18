class Topic < ActiveRecord::Base
  belongs_to :sclass
  has_many :reports, dependent: :destroy
end
