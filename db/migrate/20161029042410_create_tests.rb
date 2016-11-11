class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.references :teacher, index: true, foreign_key: true
      t.string :name
      t.integer :time

      t.timestamps null: false
    end
  end
end
