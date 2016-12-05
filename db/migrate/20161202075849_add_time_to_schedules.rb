class AddTimeToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :start_time, :string
    add_column :schedules, :ending_time, :string
  end
end
