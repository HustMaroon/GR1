class ChangeColumnLinkToFile < ActiveRecord::Migration
  def change
  	rename_column :documents, :link, :file
  end
end
