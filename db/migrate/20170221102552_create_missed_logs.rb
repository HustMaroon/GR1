class CreateMissedLogs < ActiveRecord::Migration
  def change
    create_table :missed_logs do |t|
      t.references :learning, index: true, foreign_key: true
      t.references :schedule, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
