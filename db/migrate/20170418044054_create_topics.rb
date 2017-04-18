class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :sclass, index: true, foreign_key: true
      t.string :title
      t.datetime :deadline
      t.integer :ratio

      t.timestamps null: false
    end
  end
end
