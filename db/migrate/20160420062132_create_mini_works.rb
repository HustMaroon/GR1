class CreateMiniWorks < ActiveRecord::Migration
  def change
    create_table :mini_works do |t|
      t.string :name
      t.float :ratio
      t.references :sclass, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
