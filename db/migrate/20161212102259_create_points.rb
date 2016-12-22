class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.references :score_table, index: true, foreign_key: true
      t.references :learning, index: true, foreign_key: true
      t.integer :value, default: 0
      t.string :note

      t.timestamps null: false
    end
  end
end
