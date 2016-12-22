class CreateScoreTables < ActiveRecord::Migration
  def change
    create_table :score_tables do |t|
      t.references :sclass, index: true, foreign_key: true
      t.references :point_component, index: true, foreign_key: true
      t.string :title

      t.timestamps null: false
    end
  end
end
