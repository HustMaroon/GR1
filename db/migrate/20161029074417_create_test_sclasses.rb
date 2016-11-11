class CreateTestSclasses < ActiveRecord::Migration
  def change
    create_table :test_sclasses do |t|
      t.references :test, index: true, foreign_key: true
      t.references :sclass, index: true, foreign_key: true
      t.boolean :opened, default: false

      t.timestamps null: false
    end
  end
end
