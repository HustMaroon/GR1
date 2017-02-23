class MissedLog < ActiveRecord::Base
  belongs_to :learning
  belongs_to :schedule
end
