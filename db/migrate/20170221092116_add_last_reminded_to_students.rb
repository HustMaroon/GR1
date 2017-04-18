class AddLastRemindedToStudents < ActiveRecord::Migration
  def change
    add_column :students, :last_reminded, :date
  end
end
