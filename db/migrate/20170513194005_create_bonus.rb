class CreateBonus < ActiveRecord::Migration
  def change
    create_table :bonus do |t|
      t.references :sclass, index: true, foreign_key: true
      t.string :condition
      t.integer :bonus

      t.timestamps null: false
    end
  end
end
