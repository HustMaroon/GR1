class AddDeadlineToMiniWorks < ActiveRecord::Migration
  def change
    add_column :mini_works, :deadline, :datetime
  end
end
