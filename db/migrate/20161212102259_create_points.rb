class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.references :score_table, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true
      t.float :value, default: 0
      t.string :note

      t.timestamps null: false
    end
  end
end
