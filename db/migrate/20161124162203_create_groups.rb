class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :sclass, index: true, foreign_key: true
      t.string :name
      t.references :topic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
