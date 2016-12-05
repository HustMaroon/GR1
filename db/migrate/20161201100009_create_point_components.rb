class CreatePointComponents < ActiveRecord::Migration
  def change
    create_table :point_components do |t|
      t.belongs_to :sclass, index: true, foreign_key: true
      t.integer :mid_term_test, default: 0
      t.integer :short_test, default: 0
      t.integer :apperance, default: 0

      t.timestamps null: false
    end
  end
end
