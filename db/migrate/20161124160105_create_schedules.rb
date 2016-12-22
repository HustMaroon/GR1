class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :sclass, index: true, foreign_key: true
      t.date :date
      t.text :content
      t.string :start_time
      t.string :ending_time

      t.timestamps null: false
    end
  end
end
