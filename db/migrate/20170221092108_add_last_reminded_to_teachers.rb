class AddLastRemindedToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :last_reminded, :date
  end
end
