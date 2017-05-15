class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :topic, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true
      t.string :file
      t.float :score

      t.timestamps null: false
    end
  end
end
