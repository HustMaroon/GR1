class Report < ActiveRecord::Base
  belongs_to :topic
  belongs_to :group
  mount_uploader :file, ReportUploader
end
