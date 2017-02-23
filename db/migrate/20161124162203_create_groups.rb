class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
    	t.references :sclass, index: true, foreign_key: true
      t.string :name
      t.text :topic
      t.float :point, default: 0
      t.date :deadline
      t.string :report
      t.timestamps null: false
    end
  end
end
