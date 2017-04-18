class CreateSclasses < ActiveRecord::Migration
  def change
    create_table :sclasses do |t|
      t.references :subject, index: true, foreign_key: true
      t.references :teacher, index: true, foreign_key: true
      t.string :sclass_id
      t.string :room

      t.timestamps null: false
    end
  end
end
