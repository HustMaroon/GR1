class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references :sclass, index: true, foreign_key: true
      t.text :content
      t.string :name

      t.timestamps null: false
    end
  end
end
