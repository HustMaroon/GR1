class Document < ActiveRecord::Base
  belongs_to :sclass
  mount_uploader :file, FileUploader
end
