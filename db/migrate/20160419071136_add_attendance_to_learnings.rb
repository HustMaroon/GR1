class AddAttendanceToLearnings < ActiveRecord::Migration
  def change
  	add_column :learnings, :attendance, :integer, default: 0
  end
end
