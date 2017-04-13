class AddLessonNumberToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :first_lesson, :integer
    add_column :schedules, :last_lesson, :integer
  end
end
