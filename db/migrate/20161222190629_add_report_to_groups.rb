class AddReportToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :report, :string
  end
end
